# n1-optimizer Analysis Patterns Reference

This reference catalogs all performance patterns detected by the n1-optimizer plugin, organized by layer and severity.

## Quick Reference by Severity

### HIGH Severity (Fix Immediately)

| Pattern | Layer | Description |
|---------|-------|-------------|
| N+1 Query | Database | Loop executing individual queries |
| Unbatched Writes | Database | Individual INSERT/UPDATE in loops |
| O(n²) Algorithm | Backend | Nested loops creating quadratic complexity |
| Blocking I/O | Backend | Synchronous operations stalling event loops |
| Render Loop | Frontend | Components causing infinite re-render cycles |
| Large Bundle Import | Frontend | Importing entire libraries unnecessarily |
| Over-fetching | API | Endpoints returning significantly more data than needed |
| Missing Pagination | API | Unbounded result sets on list endpoints |

### MEDIUM Severity (Fix Soon)

| Pattern | Layer | Description |
|---------|-------|-------------|
| Missing Index | Database | Queries on unindexed columns |
| Deep Pagination | Database | OFFSET-based pagination |
| Sequential Awaits | Backend | Async operations that could run in parallel |
| Redundant Computation | Backend | Repeated expensive calculations |
| Missing Memoization | Frontend | Components re-rendering with unchanged props |
| State Too High | Frontend | State causing unnecessary child renders |
| Chatty API | API | Multiple calls where batch would work |
| Under-fetching | API | Multiple calls needed for single view |

### LOW Severity (Fix When Convenient)

| Pattern | Layer | Description |
|---------|-------|-------------|
| SELECT * Usage | Database | Fetching all columns unnecessarily |
| Inefficient Collection | Backend | Array methods that could be optimized |
| Inline Object Creation | Frontend | Objects created in render causing reference changes |
| Missing Cache Headers | API | Stable data without caching guidance |

---

## Database Patterns

### N+1 Query Pattern

**Severity:** HIGH

**Description:** Executing one query to fetch parent records, then N additional queries for related data. This is the most common and impactful performance anti-pattern.

**Detection Signals:**
- Loop containing database calls with relationship access
- Lazy loading of relationships inside iteration
- ORM method calls inside `.map()`, `.forEach()`, or `for` loops

**Impact:** Query count scales linearly with data size. 100 records = 101 queries.

**Example (Problematic):**
```typescript
// N+1: Executes 1 + N queries
const orders = await prisma.order.findMany();
for (const order of orders) {
  order.customer = await prisma.customer.findUnique({
    where: { id: order.customerId }
  });
}
```

**Fix:**
```typescript
// Fixed: Single query with JOIN
const orders = await prisma.order.findMany({
  include: { customer: true }
});
```

**ORM-Specific Fixes:**

| ORM | Fix Pattern |
|-----|-------------|
| Rails/ActiveRecord | `.includes(:relation)` |
| Django | `.select_related()`, `.prefetch_related()` |
| SQLAlchemy | `joinedload()`, `selectinload()` |
| Prisma | `include: { relation: true }` |
| TypeORM | `relations: ['relation']` |

---

### Unbatched Writes

**Severity:** HIGH

**Description:** Individual INSERT/UPDATE statements executed in loops instead of bulk operations.

**Detection Signals:**
- Write operations inside iteration constructs
- Sequential `.create()` or `.save()` calls in loops
- Missing bulk operation methods

**Impact:** Each write requires a database round-trip. 100 inserts = 100 round-trips.

**Example (Problematic):**
```typescript
// Slow: 100 separate INSERT statements
for (const item of items) {
  await prisma.item.create({ data: item });
}
```

**Fix:**
```typescript
// Fast: Single bulk INSERT
await prisma.item.createMany({ data: items });
```

---

### Missing Index

**Severity:** MEDIUM

**Description:** Queries filtering or sorting on columns without appropriate indexes, causing full table scans.

**Detection Signals:**
- WHERE clauses on non-indexed columns
- JOIN conditions on non-indexed columns
- ORDER BY on non-indexed columns
- EXPLAIN showing sequential scan

**Impact:** Query time grows linearly with table size. Large tables become unusable.

**Example:**
```sql
-- Without index: Full table scan
SELECT * FROM orders WHERE customer_id = 123;

-- Fix: Add index
CREATE INDEX idx_orders_customer_id ON orders(customer_id);
```

---

### Deep Pagination

**Severity:** MEDIUM

**Description:** Using OFFSET for pagination, which becomes slower as pages increase.

**Detection Signals:**
- OFFSET values that grow with page number
- Queries with `LIMIT x OFFSET y` where y > 1000
- Pagination endpoints with high page numbers

**Impact:** Database must scan and discard OFFSET rows. Page 100 with 20 items scans 2000 rows.

**Example (Problematic):**
```sql
-- Slow for high page numbers
SELECT * FROM products LIMIT 20 OFFSET 2000;
```

**Fix (Cursor-based):**
```sql
-- Fast regardless of position
SELECT * FROM products
WHERE id > :last_seen_id
ORDER BY id
LIMIT 20;
```

---

### SELECT * Usage

**Severity:** LOW

**Description:** Fetching all columns when only a subset is needed.

**Detection Signals:**
- `SELECT *` queries
- ORM queries without column selection
- Large row sizes with unused columns

**Impact:** Increased memory usage and network transfer. May prevent index-only scans.

**Example (Problematic):**
```typescript
// Fetches all columns
const users = await prisma.user.findMany();
```

**Fix:**
```typescript
// Fetches only needed columns
const users = await prisma.user.findMany({
  select: { id: true, name: true, email: true }
});
```

---

## Backend Patterns

### O(n²) Algorithm

**Severity:** HIGH

**Description:** Nested loops creating quadratic time complexity where linear solutions exist.

**Detection Signals:**
- Nested `for`/`forEach`/`map` over same or related data
- `.includes()` or `.find()` inside loops (array search in loop)
- Missing use of Set/Map for lookups

**Impact:** Processing time squares with data size. 1000 items = 1,000,000 operations.

**Example (Problematic):**
```typescript
// O(n²): Nested loop with array search
const result = [];
for (const order of orders) {
  for (const customer of customers) {
    if (customer.id === order.customerId) {
      result.push({ order, customer });
    }
  }
}
```

**Fix:**
```typescript
// O(n): Build lookup map first
const customerMap = new Map(customers.map(c => [c.id, c]));
const result = orders.map(order => ({
  order,
  customer: customerMap.get(order.customerId)
}));
```

---

### Blocking I/O

**Severity:** HIGH

**Description:** Synchronous operations that block the event loop in async environments.

**Detection Signals:**
- `fs.readFileSync` in request handlers
- Synchronous network calls
- CPU-intensive operations without worker threads
- Missing `await` on intentionally blocking operations

**Impact:** Blocks all concurrent requests. Single slow operation affects all users.

**Example (Problematic):**
```typescript
// Blocks event loop
app.get('/report', (req, res) => {
  const data = fs.readFileSync('large-file.csv'); // Blocking!
  const processed = heavyProcessing(data);
  res.json(processed);
});
```

**Fix:**
```typescript
// Non-blocking with streams
app.get('/report', async (req, res) => {
  const stream = fs.createReadStream('large-file.csv');
  const processed = await processStream(stream);
  res.json(processed);
});
```

---

### Sequential Awaits

**Severity:** MEDIUM

**Description:** Async operations executed sequentially when they could run in parallel.

**Detection Signals:**
- Multiple independent `await` statements in sequence
- Loop with `await` inside
- Missing `Promise.all()` for independent operations

**Impact:** Total time = sum of individual times instead of max.

**Example (Problematic):**
```typescript
// Sequential: ~3 seconds total
const users = await fetchUsers();
const products = await fetchProducts();
const orders = await fetchOrders();
```

**Fix:**
```typescript
// Parallel: ~1 second total
const [users, products, orders] = await Promise.all([
  fetchUsers(),
  fetchProducts(),
  fetchOrders()
]);
```

---

### Redundant Computation

**Severity:** MEDIUM

**Description:** Repeated expensive calculations that could be cached.

**Detection Signals:**
- Same function called multiple times with same arguments
- Expensive computations in hot paths
- Missing memoization for pure functions

**Impact:** CPU cycles wasted on duplicate work.

**Example (Problematic):**
```typescript
// Computes fibonacci(40) three times
console.log(fibonacci(40));
console.log(fibonacci(40));
console.log(fibonacci(40));
```

**Fix:**
```typescript
// Memoized: computes once, returns cached
const memoizedFib = memoize(fibonacci);
console.log(memoizedFib(40));
console.log(memoizedFib(40)); // Instant
console.log(memoizedFib(40)); // Instant
```

---

### Memory Accumulation

**Severity:** MEDIUM

**Description:** Loading large datasets into memory without bounds.

**Detection Signals:**
- Array operations on unbounded queries
- Missing pagination in data processing
- Growing memory usage over time
- `findAll()` without limits

**Impact:** Memory exhaustion, OOM crashes, GC pauses.

**Example (Problematic):**
```typescript
// Loads ALL records into memory
const allUsers = await prisma.user.findMany();
allUsers.forEach(user => process(user));
```

**Fix:**
```typescript
// Processes in batches
const BATCH_SIZE = 1000;
let cursor = 0;

while (true) {
  const batch = await prisma.user.findMany({
    take: BATCH_SIZE,
    skip: cursor
  });
  if (batch.length === 0) break;

  for (const user of batch) {
    process(user);
  }
  cursor += BATCH_SIZE;
}
```

---

## Frontend Patterns

### Render Loop

**Severity:** HIGH

**Description:** Components causing infinite or excessive re-render cycles.

**Detection Signals:**
- State updates in `useEffect` without proper dependencies
- Callbacks that update parent state unconditionally
- Props that change on every render

**Impact:** UI freezes, high CPU usage, potential crashes.

**Example (Problematic):**
```tsx
// Infinite loop: effect triggers re-render, which triggers effect
function Component() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    setCount(count + 1); // Causes re-render, which runs effect again
  });

  return <div>{count}</div>;
}
```

**Fix:**
```tsx
// Add proper dependencies
function Component() {
  const [count, setCount] = useState(0);

  useEffect(() => {
    const timer = setTimeout(() => setCount(c => c + 1), 1000);
    return () => clearTimeout(timer);
  }, []); // Only runs once

  return <div>{count}</div>;
}
```

---

### Large Bundle Import

**Severity:** HIGH

**Description:** Importing entire libraries when only small parts are needed.

**Detection Signals:**
- `import _ from 'lodash'` instead of specific imports
- Large bundle sizes from utility libraries
- Unused exports in bundle analysis

**Impact:** Increased bundle size, slower page load.

**Example (Problematic):**
```typescript
// Imports entire lodash (~70KB)
import _ from 'lodash';
const result = _.debounce(fn, 100);
```

**Fix:**
```typescript
// Imports only debounce (~2KB)
import debounce from 'lodash/debounce';
const result = debounce(fn, 100);
```

---

### Missing Memoization

**Severity:** MEDIUM

**Description:** Components re-rendering when their props haven't meaningfully changed.

**Detection Signals:**
- Components in lists without `React.memo`
- Expensive child components re-rendering on parent state change
- Missing `useMemo`/`useCallback` for computed values

**Impact:** Unnecessary render cycles, slow UI updates.

**Example (Problematic):**
```tsx
// Re-renders on every parent update
function ExpensiveList({ items }) {
  return items.map(item => <ExpensiveItem key={item.id} item={item} />);
}
```

**Fix:**
```tsx
// Only re-renders when item prop changes
const MemoizedItem = React.memo(ExpensiveItem);

function ExpensiveList({ items }) {
  return items.map(item => <MemoizedItem key={item.id} item={item} />);
}
```

---

### State Too High

**Severity:** MEDIUM

**Description:** State located in a parent component when it could be isolated to children.

**Detection Signals:**
- Parent state changes causing many child re-renders
- Props drilling through multiple levels
- Global state used for local concerns

**Impact:** Unnecessary re-renders of unrelated components.

**Example (Problematic):**
```tsx
// Filter state in parent causes entire list to re-render
function Parent() {
  const [filter, setFilter] = useState('');
  const [data, setData] = useState([]);

  return (
    <>
      <FilterInput value={filter} onChange={setFilter} />
      <ExpensiveList data={data} filter={filter} />
    </>
  );
}
```

**Fix:**
```tsx
// Filter state isolated to FilterableList
function Parent() {
  const [data, setData] = useState([]);

  return <FilterableList data={data} />;
}

function FilterableList({ data }) {
  const [filter, setFilter] = useState('');
  // Only this component re-renders on filter change
  return (
    <>
      <FilterInput value={filter} onChange={setFilter} />
      <ExpensiveList data={data} filter={filter} />
    </>
  );
}
```

---

## API Patterns

### Over-fetching

**Severity:** HIGH

**Description:** Endpoints returning significantly more data than clients need.

**Detection Signals:**
- Large JSON responses with many unused fields
- Same endpoint used for list and detail views
- Full object graphs returned for simple lists

**Impact:** Increased network transfer, slower parsing, privacy concerns.

**Example (Problematic):**
```typescript
// Returns full user objects for a simple list
app.get('/users', async (req, res) => {
  const users = await prisma.user.findMany({
    include: { posts: true, comments: true, profile: true }
  });
  res.json(users); // 500KB response
});
```

**Fix:**
```typescript
// Returns only needed fields
app.get('/users', async (req, res) => {
  const users = await prisma.user.findMany({
    select: { id: true, name: true, avatarUrl: true }
  });
  res.json(users); // 5KB response
});
```

---

### Missing Pagination

**Severity:** HIGH

**Description:** Unbounded result sets on list endpoints.

**Detection Signals:**
- `findMany()` without `take`/`limit`
- List endpoints returning all records
- Growing response times with data size

**Impact:** Timeout risk, memory issues, slow responses.

**Example (Problematic):**
```typescript
// Returns ALL products (could be millions)
app.get('/products', async (req, res) => {
  const products = await prisma.product.findMany();
  res.json(products);
});
```

**Fix:**
```typescript
// Returns paginated results with metadata
app.get('/products', async (req, res) => {
  const { page = 1, limit = 20 } = req.query;
  const skip = (page - 1) * limit;

  const [products, total] = await Promise.all([
    prisma.product.findMany({ take: limit, skip }),
    prisma.product.count()
  ]);

  res.json({
    data: products,
    pagination: { page, limit, total, pages: Math.ceil(total / limit) }
  });
});
```

---

### Chatty API

**Severity:** MEDIUM

**Description:** Multiple API calls required where a batch endpoint would be more efficient.

**Detection Signals:**
- Frontend making N calls for N items
- Sequential API calls for related data
- Missing batch endpoints

**Impact:** Multiple round-trips, increased latency.

**Example (Problematic):**
```typescript
// Client makes 10 separate calls
for (const id of productIds) {
  const product = await fetch(`/api/products/${id}`);
}
```

**Fix:**
```typescript
// Client makes 1 batch call
const products = await fetch('/api/products/batch', {
  method: 'POST',
  body: JSON.stringify({ ids: productIds })
});
```

---

### Under-fetching

**Severity:** MEDIUM

**Description:** Multiple calls needed to assemble data for a single view.

**Detection Signals:**
- Sequential dependent API calls
- Waterfall network requests in dev tools
- Related data not included in response

**Impact:** Increased latency, complex client code.

**Example (Problematic):**
```typescript
// Client needs 3 sequential calls
const order = await fetch(`/api/orders/${id}`);
const customer = await fetch(`/api/customers/${order.customerId}`);
const products = await Promise.all(
  order.items.map(item => fetch(`/api/products/${item.productId}`))
);
```

**Fix:**
```typescript
// Client makes 1 call with included data
const orderWithDetails = await fetch(`/api/orders/${id}?include=customer,products`);
```

---

## Detection Heuristics

The analyzer uses these signals to identify patterns:

| Heuristic | What It Detects |
|-----------|-----------------|
| Loop Analysis | Operations inside for/while/map/forEach |
| Call Patterns | Repeated similar calls with different parameters |
| Timing Correlation | Linear time increase with data size |
| Resource Usage | Memory/connection consumption patterns |
| Code Structure | Async operations, lazy loading patterns |
| Query Patterns | SELECT *, missing LIMIT, OFFSET usage |
| Import Analysis | Full library imports vs. specific imports |

---

## See Also

- [How to Interpret n1-optimizer Results](../how-to/n1-optimizer-results.md)
- [Understanding the Four n1-optimizer Agents](../explanations/n1-optimizer-agents.md)
- [Finding Performance Issues Tutorial](../tutorials/finding-performance-issues.md)
