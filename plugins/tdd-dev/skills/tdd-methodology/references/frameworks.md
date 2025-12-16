# Framework-Specific TDD Guide

## Jest / Vitest (JavaScript/TypeScript)

### Detection

Check for test framework in `package.json`:

```json
{
  "devDependencies": {
    "jest": "^29.0.0",
    // or
    "vitest": "^1.0.0"
  },
  "scripts": {
    "test": "jest",
    // or
    "test": "vitest"
  }
}
```

### Test File Naming

- `*.test.ts` / `*.test.tsx` / `*.test.js`
- `*.spec.ts` / `*.spec.tsx` / `*.spec.js`
- `__tests__/*.ts`

### Basic Test Structure

```typescript
import { describe, it, expect, beforeEach, afterEach } from 'vitest';
// or for Jest: import { describe, it, expect } from '@jest/globals';

import { Calculator } from './calculator';

describe('Calculator', () => {
  let calculator: Calculator;

  beforeEach(() => {
    calculator = new Calculator();
  });

  describe('add', () => {
    it('should add two positive numbers', () => {
      expect(calculator.add(2, 3)).toBe(5);
    });

    it('should handle negative numbers', () => {
      expect(calculator.add(-1, 1)).toBe(0);
    });
  });

  describe('divide', () => {
    it('should divide two numbers', () => {
      expect(calculator.divide(10, 2)).toBe(5);
    });

    it('should throw when dividing by zero', () => {
      expect(() => calculator.divide(10, 0)).toThrow('Division by zero');
    });
  });
});
```

### Async Testing

```typescript
it('should fetch user data', async () => {
  const user = await userService.getUser(1);
  expect(user.name).toBe('John');
});

it('should reject invalid user id', async () => {
  await expect(userService.getUser(-1)).rejects.toThrow('Invalid ID');
});
```

### Mocking

```typescript
import { vi } from 'vitest'; // or jest.fn() for Jest

// Mock function
const mockFetch = vi.fn().mockResolvedValue({ data: 'test' });

// Mock module
vi.mock('./api', () => ({
  fetchData: vi.fn().mockResolvedValue({ data: 'mocked' }),
}));

// Spy on method
const spy = vi.spyOn(console, 'log');
```

### Run Commands

```bash
# Run all tests
npm test
pnpm test

# Run specific file
npm test -- calculator.test.ts
pnpm test calculator.test.ts

# Run tests matching pattern
npm test -- --testNamePattern="add"
pnpm test --testNamePattern="add"

# Watch mode
npm test -- --watch
pnpm test --watch

# Coverage
npm test -- --coverage
```

---

## Pytest (Python)

### Detection

Check for pytest configuration:
- `pytest.ini`
- `pyproject.toml` with `[tool.pytest.ini_options]`
- `setup.cfg` with `[tool:pytest]`

### Test File Naming

- `test_*.py`
- `*_test.py`
- Files in `tests/` directory

### Basic Test Structure

```python
import pytest
from calculator import Calculator


class TestCalculator:
    """Tests for Calculator class."""

    @pytest.fixture
    def calculator(self):
        """Create a Calculator instance for each test."""
        return Calculator()

    def test_add_positive_numbers(self, calculator):
        """Should add two positive numbers."""
        assert calculator.add(2, 3) == 5

    def test_add_negative_numbers(self, calculator):
        """Should handle negative numbers."""
        assert calculator.add(-1, 1) == 0

    def test_divide_two_numbers(self, calculator):
        """Should divide two numbers."""
        assert calculator.divide(10, 2) == 5

    def test_divide_by_zero_raises(self, calculator):
        """Should raise ZeroDivisionError when dividing by zero."""
        with pytest.raises(ZeroDivisionError):
            calculator.divide(10, 0)
```

### Fixtures

```python
import pytest

@pytest.fixture
def sample_user():
    """Create a sample user for tests."""
    return User(name="Test", email="test@example.com")

@pytest.fixture
def db_connection():
    """Create and cleanup database connection."""
    conn = create_connection()
    yield conn
    conn.close()

@pytest.fixture(scope="module")
def expensive_resource():
    """Shared across all tests in module."""
    return create_expensive_resource()
```

### Parametrized Tests

```python
@pytest.mark.parametrize("input,expected", [
    ("test@example.com", True),
    ("invalid", False),
    ("@missing.com", False),
    ("missing@", False),
])
def test_email_validation(input, expected):
    """Should validate email format correctly."""
    assert validate_email(input) == expected
```

### Async Testing

```python
import pytest

@pytest.mark.asyncio
async def test_async_fetch():
    """Should fetch data asynchronously."""
    result = await fetch_data(url)
    assert result.status == 200
```

### Mocking

```python
from unittest.mock import Mock, patch, MagicMock

def test_with_mock():
    """Test with mocked dependency."""
    mock_service = Mock()
    mock_service.get_user.return_value = User(name="Mocked")

    result = process_user(mock_service, user_id=1)

    mock_service.get_user.assert_called_once_with(1)

@patch('module.external_api')
def test_with_patch(mock_api):
    """Test with patched module."""
    mock_api.fetch.return_value = {"data": "mocked"}
    result = my_function()
    assert result == {"data": "mocked"}
```

### Run Commands

```bash
# Run all tests
pytest
python -m pytest

# Run specific file
pytest tests/test_calculator.py

# Run specific test
pytest tests/test_calculator.py::TestCalculator::test_add

# Run tests matching pattern
pytest -k "add or subtract"

# Verbose output
pytest -v

# Stop on first failure
pytest -x

# Show print statements
pytest -s

# Coverage
pytest --cov=src --cov-report=html
```

---

## Go Testing

### Detection

- `go.mod` file exists
- Test files: `*_test.go`

### Test File Naming

- `calculator_test.go` for `calculator.go`
- Tests in same package or `_test` package

### Basic Test Structure

```go
package calculator

import "testing"

func TestAdd(t *testing.T) {
    calc := NewCalculator()

    result := calc.Add(2, 3)

    if result != 5 {
        t.Errorf("Add(2, 3) = %d; want 5", result)
    }
}

func TestDivideByZero(t *testing.T) {
    calc := NewCalculator()

    _, err := calc.Divide(10, 0)

    if err == nil {
        t.Error("Divide(10, 0) should return error")
    }
}
```

### Table-Driven Tests

```go
func TestAdd(t *testing.T) {
    tests := []struct {
        name     string
        a, b     int
        expected int
    }{
        {"positive numbers", 2, 3, 5},
        {"negative numbers", -1, 1, 0},
        {"zeros", 0, 0, 0},
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            result := Add(tt.a, tt.b)
            if result != tt.expected {
                t.Errorf("Add(%d, %d) = %d; want %d",
                    tt.a, tt.b, result, tt.expected)
            }
        })
    }
}
```

### Run Commands

```bash
# Run all tests
go test ./...

# Run specific package
go test ./pkg/calculator

# Verbose
go test -v ./...

# Run specific test
go test -run TestAdd ./...

# Coverage
go test -cover ./...
go test -coverprofile=coverage.out ./...
```

---

## Generic Framework Detection

For unknown frameworks, detect test commands:

### package.json (Node.js)

```bash
# Check scripts
grep -A 20 '"scripts"' package.json | grep test
```

### pyproject.toml (Python)

```bash
# Check for test configuration
grep -E "pytest|unittest|nose" pyproject.toml
```

### Makefile

```bash
# Check for test target
grep -E "^test:" Makefile
```

### Common Test Commands

| Language | Command |
|----------|---------|
| JavaScript | `npm test`, `pnpm test`, `yarn test` |
| Python | `pytest`, `python -m pytest`, `python -m unittest` |
| Go | `go test ./...` |
| Rust | `cargo test` |
| Java | `mvn test`, `gradle test` |
| Ruby | `bundle exec rspec`, `rake test` |
| PHP | `./vendor/bin/phpunit` |
| C# | `dotnet test` |

### Fallback Strategy

If framework not detected:
1. Look for `test` script in project config
2. Check for common test directories (`tests/`, `test/`, `__tests__/`)
3. Ask user for test command
4. Store in `.claude/tdd-dev.local.md` for future use
