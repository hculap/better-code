# Refactoring Patterns for Code Standards Violations

Common refactoring techniques to fix size and complexity violations.

## File Too Large

### Pattern: Split by Domain/Feature

**When**: File contains multiple unrelated responsibilities

**Before**:
```
user-service.ts (800 LOC)
├── User CRUD operations
├── Authentication logic
├── Email notifications
└── Reporting/analytics
```

**After**:
```
users/
├── user-repository.ts (150 LOC) - CRUD
├── auth-service.ts (200 LOC) - Authentication
├── email-service.ts (100 LOC) - Notifications
└── user-analytics.ts (150 LOC) - Reporting
```

### Pattern: Extract Data Types

**When**: File has many type definitions alongside logic

**Before**:
```typescript
// order-service.ts (600 LOC)
interface Order { ... }
interface OrderItem { ... }
interface OrderStatus { ... }
type PaymentMethod = ...
// ... 50 more lines of types
// ... 500 lines of logic
```

**After**:
```typescript
// types/order.ts (60 LOC)
export interface Order { ... }
export interface OrderItem { ... }
// ...

// order-service.ts (500 LOC)
import { Order, OrderItem } from './types/order';
// ... logic only
```

### Pattern: Extract Constants/Config

**When**: Large configuration blocks mixed with logic

**Before**:
```python
# processor.py (700 LOC)
ALLOWED_EXTENSIONS = ['.jpg', '.png', ...]  # 50 items
ERROR_MESSAGES = {...}  # 100 lines
DEFAULT_CONFIG = {...}  # 80 lines
# ... 470 lines of logic
```

**After**:
```python
# config/processor_config.py
ALLOWED_EXTENSIONS = [...]
ERROR_MESSAGES = {...}
DEFAULT_CONFIG = {...}

# processor.py (470 LOC)
from config.processor_config import *
```

---

## Function Too Large

### Pattern: Extract Method

**When**: Function does multiple distinct things

**Before**:
```typescript
async function processOrder(order: Order) {
  // Validate order (20 lines)
  if (!order.items.length) throw new Error('Empty order');
  // ... more validation

  // Calculate totals (30 lines)
  let subtotal = 0;
  for (const item of order.items) {
    // ... complex calculation
  }

  // Apply discounts (25 lines)
  // ...

  // Save to database (15 lines)
  // ...

  // Send notifications (20 lines)
  // ...
}
```

**After**:
```typescript
async function processOrder(order: Order) {
  validateOrder(order);
  const totals = calculateTotals(order);
  const finalPrice = applyDiscounts(totals, order.discountCode);
  await saveOrder(order, finalPrice);
  await sendOrderNotifications(order);
}

function validateOrder(order: Order): void { /* 20 lines */ }
function calculateTotals(order: Order): OrderTotals { /* 30 lines */ }
function applyDiscounts(totals: OrderTotals, code?: string): number { /* 25 lines */ }
async function saveOrder(order: Order, price: number): Promise<void> { /* 15 lines */ }
async function sendOrderNotifications(order: Order): Promise<void> { /* 20 lines */ }
```

### Pattern: Replace Conditionals with Polymorphism

**When**: Large switch/if-else blocks

**Before**:
```python
def calculate_shipping(order):
    if order.shipping_method == 'standard':
        # 20 lines of standard shipping logic
        pass
    elif order.shipping_method == 'express':
        # 20 lines of express shipping logic
        pass
    elif order.shipping_method == 'overnight':
        # 20 lines of overnight shipping logic
        pass
    elif order.shipping_method == 'international':
        # 30 lines of international shipping logic
        pass
    # ... more methods
```

**After**:
```python
class ShippingCalculator(ABC):
    @abstractmethod
    def calculate(self, order) -> Decimal:
        pass

class StandardShipping(ShippingCalculator):
    def calculate(self, order) -> Decimal:
        # 20 lines
        pass

class ExpressShipping(ShippingCalculator):
    def calculate(self, order) -> Decimal:
        # 20 lines
        pass

CALCULATORS = {
    'standard': StandardShipping(),
    'express': ExpressShipping(),
    # ...
}

def calculate_shipping(order):
    calculator = CALCULATORS[order.shipping_method]
    return calculator.calculate(order)
```

### Pattern: Extract Loop Body

**When**: Loop contains complex logic

**Before**:
```go
func processItems(items []Item) []Result {
    var results []Result
    for _, item := range items {
        // 40 lines of processing per item
        validated := validateItem(item)
        if validated.Err != nil {
            log.Error(...)
            continue
        }
        transformed := transform(item)
        enriched := enrich(transformed)
        // ... more processing
        results = append(results, enriched)
    }
    return results
}
```

**After**:
```go
func processItems(items []Item) []Result {
    var results []Result
    for _, item := range items {
        result, err := processItem(item)
        if err != nil {
            log.Error(err)
            continue
        }
        results = append(results, result)
    }
    return results
}

func processItem(item Item) (Result, error) {
    // 40 lines - now in its own testable function
}
```

---

## High Cyclomatic Complexity

### Pattern: Guard Clauses (Early Return)

**When**: Deep nesting from validation checks

**Before**:
```typescript
function processRequest(req: Request): Response {
  if (req.isValid) {
    if (req.user.isAuthenticated) {
      if (req.user.hasPermission('write')) {
        if (req.data.length < MAX_SIZE) {
          // actual logic here (20 lines)
          return { success: true };
        } else {
          return { error: 'Data too large' };
        }
      } else {
        return { error: 'No permission' };
      }
    } else {
      return { error: 'Not authenticated' };
    }
  } else {
    return { error: 'Invalid request' };
  }
}
```

**After**:
```typescript
function processRequest(req: Request): Response {
  if (!req.isValid) {
    return { error: 'Invalid request' };
  }
  if (!req.user.isAuthenticated) {
    return { error: 'Not authenticated' };
  }
  if (!req.user.hasPermission('write')) {
    return { error: 'No permission' };
  }
  if (req.data.length >= MAX_SIZE) {
    return { error: 'Data too large' };
  }

  // actual logic here (20 lines)
  return { success: true };
}
```

### Pattern: Extract Validation

**When**: Multiple validation checks inflate complexity

**Before**:
```python
def create_user(data):
    if not data.get('email'):
        raise ValueError('Email required')
    if not is_valid_email(data['email']):
        raise ValueError('Invalid email format')
    if not data.get('password'):
        raise ValueError('Password required')
    if len(data['password']) < 8:
        raise ValueError('Password too short')
    if not has_uppercase(data['password']):
        raise ValueError('Password needs uppercase')
    # ... 10 more validation checks

    # actual user creation (30 lines)
```

**After**:
```python
def create_user(data):
    validate_user_data(data)
    # actual user creation (30 lines)

def validate_user_data(data):
    validate_email(data.get('email'))
    validate_password(data.get('password'))

def validate_email(email):
    if not email:
        raise ValueError('Email required')
    if not is_valid_email(email):
        raise ValueError('Invalid email format')

def validate_password(password):
    if not password:
        raise ValueError('Password required')
    if len(password) < 8:
        raise ValueError('Password too short')
    # ...
```

### Pattern: Replace Nested Conditionals with Map/Dict

**When**: Multiple if/elif checking the same variable

**Before**:
```ruby
def get_discount(customer_type)
  if customer_type == 'gold'
    0.20
  elsif customer_type == 'silver'
    0.15
  elsif customer_type == 'bronze'
    0.10
  elsif customer_type == 'new'
    0.05
  elsif customer_type == 'vip'
    0.25
  else
    0.0
  end
end
```

**After**:
```ruby
DISCOUNTS = {
  'gold' => 0.20,
  'silver' => 0.15,
  'bronze' => 0.10,
  'new' => 0.05,
  'vip' => 0.25
}.freeze

def get_discount(customer_type)
  DISCOUNTS.fetch(customer_type, 0.0)
end
```

---

## Multiple Responsibilities (SRP Violation)

### Pattern: Separate Concerns into Collaborators

**When**: Class/module handles unrelated tasks

**Before**:
```typescript
class UserService {
  createUser(data: UserData): User { /* 30 lines */ }
  updateUser(id: string, data: UserData): User { /* 25 lines */ }
  deleteUser(id: string): void { /* 15 lines */ }

  sendWelcomeEmail(user: User): void { /* 20 lines */ }
  sendPasswordReset(email: string): void { /* 25 lines */ }

  generateReport(userId: string): Report { /* 40 lines */ }
  exportToCsv(users: User[]): string { /* 30 lines */ }
}
```

**After**:
```typescript
class UserService {
  constructor(
    private emailService: EmailService,
    private reportService: UserReportService
  ) {}

  createUser(data: UserData): User { /* 30 lines */ }
  updateUser(id: string, data: UserData): User { /* 25 lines */ }
  deleteUser(id: string): void { /* 15 lines */ }
}

class EmailService {
  sendWelcomeEmail(user: User): void { /* 20 lines */ }
  sendPasswordReset(email: string): void { /* 25 lines */ }
}

class UserReportService {
  generateReport(userId: string): Report { /* 40 lines */ }
  exportToCsv(users: User[]): string { /* 30 lines */ }
}
```

---

## Common Anti-Patterns to Avoid

### Don't: Create "Utils" Dumping Grounds

**Bad**:
```
utils.ts (1200 LOC)
├── string helpers
├── date helpers
├── validation helpers
├── formatting helpers
└── random stuff
```

**Good**:
```
utils/
├── string-utils.ts (80 LOC)
├── date-utils.ts (100 LOC)
├── validation.ts (120 LOC)
└── formatting.ts (90 LOC)
```

### Don't: Over-Extract to Tiny Functions

**Bad** (too granular):
```python
def add_one(x): return x + 1
def multiply_by_two(x): return x * 2
def subtract_five(x): return x - 5

result = subtract_five(multiply_by_two(add_one(value)))
```

**Good** (meaningful abstraction):
```python
def apply_pricing_formula(base_price):
    """Apply standard pricing adjustment: (base + 1) * 2 - 5"""
    return (base_price + 1) * 2 - 5
```

### Don't: Split Mid-Logic

**Bad** (arbitrary split):
```typescript
function processOrder_Part1(order) {
  // half of the logic
}

function processOrder_Part2(order, intermediate) {
  // other half
}
```

**Good** (meaningful boundaries):
```typescript
function validateOrder(order) { /* validation */ }
function calculatePricing(order) { /* pricing */ }
function persistOrder(order, pricing) { /* storage */ }
```

---

## Refactoring Checklist

Before refactoring:
- [ ] Existing tests pass
- [ ] Understand current behavior
- [ ] Identify code boundaries

During refactoring:
- [ ] Make small, incremental changes
- [ ] Run tests after each change
- [ ] Commit frequently

After refactoring:
- [ ] All tests still pass
- [ ] No new functionality added
- [ ] Code is more readable
- [ ] File/function sizes within limits
- [ ] Complexity reduced
