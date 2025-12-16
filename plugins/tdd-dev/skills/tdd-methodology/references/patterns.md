# TDD Patterns and Anti-Patterns

## Common TDD Patterns

### 1. Arrange-Act-Assert (AAA)

Structure every test with three distinct phases:

```typescript
it('should calculate total with discount', () => {
  // Arrange: Set up preconditions
  const cart = new ShoppingCart();
  cart.addItem({ price: 100, quantity: 2 });
  cart.applyDiscount(0.1);

  // Act: Execute the behavior under test
  const total = cart.calculateTotal();

  // Assert: Verify the expected outcome
  expect(total).toBe(180);
});
```

### 2. Given-When-Then (BDD Style)

For behavior-focused tests:

```python
def test_user_receives_welcome_email_after_registration():
    # Given a new user with valid email
    user_data = {"email": "test@example.com", "name": "Test User"}

    # When they complete registration
    result = registration_service.register(user_data)

    # Then they should receive a welcome email
    assert email_service.was_sent_to("test@example.com")
    assert "Welcome" in email_service.last_subject
```

### 3. One Assert Per Test

Keep tests focused on a single behavior:

```typescript
// Good: Separate tests for separate behaviors
it('should return empty array when no items match', () => {
  expect(filter([], predicate)).toEqual([]);
});

it('should return matching items only', () => {
  expect(filter([1, 2, 3], x => x > 1)).toEqual([2, 3]);
});

// Avoid: Multiple unrelated assertions
it('should filter correctly', () => {
  expect(filter([], predicate)).toEqual([]);
  expect(filter([1, 2, 3], x => x > 1)).toEqual([2, 3]);
  expect(filter([1], x => x > 1)).toEqual([]);
});
```

### 4. Test Naming Convention

Use descriptive names that explain the scenario:

```typescript
// Pattern: should_[expected behavior]_when_[condition]
it('should throw ValidationError when email is empty', () => {});
it('should return null when user not found', () => {});
it('should retry three times when connection fails', () => {});
```

### 5. Test Data Builders

Create readable test data:

```typescript
// Builder pattern for complex objects
const user = UserBuilder.create()
  .withEmail('test@example.com')
  .withRole('admin')
  .withCreatedAt(yesterday)
  .build();
```

### 6. Triangulation

When unsure about implementation, add tests that force generalization:

```typescript
// First test - could hardcode "5"
it('should add 2 and 3', () => {
  expect(add(2, 3)).toBe(5);
});

// Triangulation test - forces real implementation
it('should add 10 and 20', () => {
  expect(add(10, 20)).toBe(30);
});
```

## Anti-Patterns to Avoid

### 1. Testing Implementation Details

```typescript
// Bad: Tests internal state
it('should set _isProcessed to true', () => {
  order.process();
  expect(order._isProcessed).toBe(true);
});

// Good: Tests observable behavior
it('should mark order as completed after processing', () => {
  order.process();
  expect(order.status).toBe('completed');
});
```

### 2. Excessive Mocking

```typescript
// Bad: Mock everything
it('should process order', () => {
  const mockDb = mock(Database);
  const mockEmail = mock(EmailService);
  const mockLogger = mock(Logger);
  const mockCache = mock(Cache);
  // ... test becomes about mocks, not behavior
});

// Good: Mock only external boundaries
it('should send confirmation after order placed', () => {
  const emailService = mock(EmailService);
  const orderService = new OrderService(emailService);

  orderService.placeOrder(order);

  expect(emailService.send).toHaveBeenCalledWith(
    expect.objectContaining({ type: 'confirmation' })
  );
});
```

### 3. Test Interdependence

```typescript
// Bad: Tests depend on each other
describe('User', () => {
  let user;

  it('should create user', () => {
    user = createUser(); // Used by next test
  });

  it('should update user', () => {
    user.update({ name: 'New' }); // Depends on previous test
  });
});

// Good: Each test is independent
describe('User', () => {
  it('should create user', () => {
    const user = createUser();
    expect(user).toBeDefined();
  });

  it('should update user', () => {
    const user = createUser();
    user.update({ name: 'New' });
    expect(user.name).toBe('New');
  });
});
```

### 4. Testing Getters/Setters

```typescript
// Bad: Testing trivial code
it('should set name', () => {
  user.name = 'Test';
  expect(user.name).toBe('Test');
});

// Good: Test meaningful behavior
it('should normalize name on set', () => {
  user.name = '  Test User  ';
  expect(user.name).toBe('Test User');
});
```

### 5. Copy-Paste Tests

```typescript
// Bad: Duplicated test structure
it('should validate email format 1', () => {
  expect(validate('test@example.com')).toBe(true);
});
it('should validate email format 2', () => {
  expect(validate('invalid')).toBe(false);
});

// Good: Parameterized tests
it.each([
  ['test@example.com', true],
  ['invalid', false],
  ['@missing-local.com', false],
])('should validate %s as %s', (email, expected) => {
  expect(validate(email)).toBe(expected);
});
```

## TDD Rhythm

### The Two-Minute Rule

Each Red→Green cycle should take about 2 minutes:
- If taking longer, the step is too big
- Break into smaller increments
- Write a simpler test first

### Baby Steps

Progress in tiny increments:

```typescript
// Step 1: Return hardcoded value
function fibonacci(n) {
  return 0;
}

// Step 2: Handle n=1
function fibonacci(n) {
  if (n <= 1) return n;
  return 0;
}

// Step 3: General case
function fibonacci(n) {
  if (n <= 1) return n;
  return fibonacci(n - 1) + fibonacci(n - 2);
}
```

### When to Refactor

Refactor when you see:
- Duplication (DRY violation)
- Long methods (>10 lines)
- Unclear names
- Deep nesting (>3 levels)
- Multiple responsibilities

Never refactor when tests are failing.

## Edge Case Testing

### Boundary Conditions

Always test:
- Empty inputs ([], "", null, undefined)
- Single element ([x], "a")
- Maximum values
- Minimum values
- Off-by-one scenarios

### Error Conditions

```typescript
it('should throw when dividing by zero', () => {
  expect(() => divide(10, 0)).toThrow(DivisionByZeroError);
});

it('should return error result for invalid input', () => {
  const result = parseDate('not-a-date');
  expect(result.isError).toBe(true);
  expect(result.error).toContain('Invalid date format');
});
```

## Test Organization

### File Structure

```
src/
  calculator.ts
  calculator.test.ts  # Co-located test

# OR

src/
  calculator.ts
tests/
  calculator.test.ts  # Separate test directory
```

### Describe Blocks

```typescript
describe('Calculator', () => {
  describe('add', () => {
    it('should add positive numbers', () => {});
    it('should handle negative numbers', () => {});
  });

  describe('divide', () => {
    it('should divide evenly', () => {});
    it('should throw on zero divisor', () => {});
  });
});
```
