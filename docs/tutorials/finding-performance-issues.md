# Finding Performance Issues with n1-optimizer

In this tutorial, you will learn how to use n1-optimizer to identify performance bottlenecks in your codebase. By the end, you will have run a full performance analysis, understood the output from all four specialized agents, and fixed a real N+1 query issue.

## What You Will Learn

- How to run a comprehensive performance analysis
- What each of the four parallel agents examines
- How to read and interpret severity-grouped findings
- How to prioritize which issues to address first
- How to fix a common N+1 query problem
- How to verify your fixes improved performance

## Prerequisites

Before starting this tutorial, ensure you have:

- Completed the [Getting Started guide](./getting-started.md)
- Installed the n1-optimizer plugin (`/plugin install n1-optimizer`)
- A codebase ready to analyze (this tutorial uses examples from a typical web application)

## Step 1: Run the Performance Analysis

Open your project in Claude Code and run the analyze command.

Type `/n1-optimizer:analyze` and press Enter.

You can optionally specify a directory to focus the analysis:

```
/n1-optimizer:analyze src/api
```

Once you run the command, n1-optimizer launches four specialized agents simultaneously. Each agent examines a different layer of your application stack. This parallel approach means you get comprehensive results faster than sequential analysis.

## Step 2: Understanding the Four Agents

While the analysis runs, here is what each agent examines.

### Database Analyzer

This agent scans your ORM queries and database access patterns. It looks for:
- N+1 query problems where code fetches related records inside loops
- Missing eager loading opportunities
- Absent database indexes
- Inefficient query patterns like using `SELECT *` when you only need specific columns

### Backend Analyzer

This agent examines your server-side code for performance anti-patterns. It identifies:
- Synchronous operations in loops that could run in parallel
- Memory leaks from accumulating data structures
- Blocking I/O operations
- Inefficient data transformations

### Frontend Analyzer

This agent reviews your React, Vue, or other frontend framework code. It finds:
- Unnecessary re-renders
- Missing memoization
- Large bundle sizes from improper imports
- Render-blocking resources

### API Analyzer

This agent inspects your API layer for data transfer inefficiencies. It catches:
- Over-fetching where endpoints return more data than clients need
- Missing pagination on list endpoints
- Chatty API patterns requiring multiple round-trips
- Opportunities to implement response caching

## Step 3: Reading the Severity-Grouped Output

After a few moments, you will see consolidated findings grouped by severity. Here is an example of what the output looks like:

```
=== PERFORMANCE ANALYSIS COMPLETE ===

Database Issues (2 High, 1 Medium)
----------------------------------
[HIGH] N+1 Query Pattern
  Location: src/api/orders/getOrders.ts:45
  Impact: ~500ms added latency per request
  Problem: Loop fetches customer for each order separately
  Suggestion: Use eager loading with include: { customer: true }

[HIGH] Missing Index
  Location: orders table, customer_id column
  Impact: Full table scan on 100k+ rows
  Problem: Foreign key lacks supporting index
  Suggestion: CREATE INDEX idx_orders_customer_id ON orders(customer_id)

[MEDIUM] Unbounded Query
  Location: src/api/products/list.ts:12
  Impact: Timeout risk with large datasets
  Problem: No LIMIT clause on findMany()
  Suggestion: Add take/skip parameters with default limit

Backend Issues (1 High, 2 Medium)
---------------------------------
[HIGH] Sequential API Calls
  Location: src/services/dashboardService.ts:34
  Impact: 800ms latency from 4 sequential calls
  Problem: Dashboard data fetched one endpoint at a time
  Suggestion: Use Promise.all() for parallel fetching

[MEDIUM] Synchronous File Processing
  Location: src/services/importService.ts:78
  Impact: Blocks event loop for 2-3 seconds
  Problem: Processing uploaded files synchronously
  Suggestion: Use streaming or worker threads

Frontend Issues (1 High, 1 Low)
-------------------------------
[HIGH] Unnecessary Re-renders
  Location: src/components/ProductGrid.tsx:12
  Impact: 200+ re-renders on filter change
  Problem: Parent state change triggers full grid re-render
  Suggestion: Wrap ProductCard with React.memo()

API Issues (1 High, 1 Medium)
-----------------------------
[HIGH] Over-fetching on /api/products
  Location: src/api/products/list.ts:23
  Impact: 3x more data transferred than needed
  Problem: Returns full product with relations for list view
  Suggestion: Create separate list DTO with only needed fields
```

## Step 4: Prioritizing Which Issues to Fix

You now have a list of findings. Here is how to decide what to fix first.

**Fix HIGH issues immediately.** These cause noticeable user-facing problems like slow page loads, timeouts, or crashes under load. The N+1 query adding 500ms per request directly hurts every user.

**Schedule MEDIUM issues for your current sprint.** These degrade performance but may not be immediately visible. The missing index will become critical as your data grows.

**Track LOW issues for future optimization.** Consider these when you have dedicated performance improvement time.

### Prioritization Decision Matrix

| Severity | User Impact | Fix Timeline |
|----------|-------------|--------------|
| HIGH | Noticeable lag, timeouts, failures | Immediately |
| MEDIUM | Gradual degradation, scaling issues | This sprint |
| LOW | Minor inefficiency, code smell | Backlog |

## Step 5: Fixing a HIGH Severity N+1 Query

Let us fix the N+1 query from our example. The database analyzer found this issue:

**Before (problematic code):**
```typescript
// src/api/orders/getOrders.ts
async function getOrders() {
  const orders = await prisma.order.findMany();

  // N+1: This runs a query for EACH order
  for (const order of orders) {
    order.customer = await prisma.customer.findUnique({
      where: { id: order.customerId }
    });
  }

  return orders;
}
```

This code runs 1 query to fetch orders, then N additional queries (one per order) to fetch each customer. With 100 orders, that is 101 database queries.

**After (fixed code):**
```typescript
// src/api/orders/getOrders.ts
async function getOrders() {
  const orders = await prisma.order.findMany({
    include: {
      customer: true  // Eager load in single query
    }
  });

  return orders;
}
```

The fixed version uses eager loading to fetch all orders and their customers in a single query with a JOIN.

## Step 6: Verifying Your Fixes

After applying fixes, verify they improved performance.

**Run the analysis again:**
```
/n1-optimizer:analyze src/api/orders
```

The N+1 finding should no longer appear.

**Check query count in development:**
Enable query logging in your ORM to confirm the reduced query count. For Prisma, add to your client initialization:
```typescript
const prisma = new PrismaClient({
  log: ['query']
});
```

**Measure response time:**
Use your browser's Network tab or an API client to compare response times before and after. The fixed N+1 query should reduce latency significantly, often by 50-90% depending on the number of records.

## What You Learned

You now know how to use n1-optimizer to find performance problems in your codebase:

1. **Run analysis** with `/n1-optimizer:analyze`
2. **Understand the four agents** that examine database, backend, frontend, and API layers
3. **Read severity-grouped output** to understand issue impact
4. **Prioritize fixes** based on HIGH > MEDIUM > LOW severity
5. **Fix N+1 queries** using eager loading
6. **Verify improvements** by re-running analysis and measuring response times

## Next Steps

- Run `/n1-optimizer:analyze` on other parts of your codebase
- Address the remaining HIGH severity issues from your first analysis
- Set up regular performance analysis as part of your code review process
- Read [How to Interpret n1-optimizer Results](../how-to/n1-optimizer-results.md) for deeper understanding
- Explore the [Analysis Patterns Reference](../reference/n1-optimizer-patterns.md) for all detectable issues

## See Also

- [Understanding the Four n1-optimizer Agents](../explanations/n1-optimizer-agents.md)
- [n1-optimizer Patterns Reference](../reference/n1-optimizer-patterns.md)
