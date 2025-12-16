# Jest TDD Cycle Example

Complete walkthrough of implementing a `UserValidator` using strict TDD.

## Requirement

Create a user validator that:
- Validates email format
- Ensures password has minimum 8 characters
- Checks username is alphanumeric

---

## Cycle 1: Email Validation (Valid Email)

### RED: Write Failing Test

```typescript
// src/user-validator.test.ts
import { UserValidator } from './user-validator';

describe('UserValidator', () => {
  describe('validateEmail', () => {
    it('should return true for valid email', () => {
      const validator = new UserValidator();
      expect(validator.validateEmail('test@example.com')).toBe(true);
    });
  });
});
```

**Run tests:**
```bash
npm test
```

**Expected output:**
```
FAIL  src/user-validator.test.ts
  ● UserValidator › validateEmail › should return true for valid email
    Cannot find module './user-validator'
```

✅ Test fails for the right reason (module doesn't exist).

### GREEN: Minimal Implementation

```typescript
// src/user-validator.ts
export class UserValidator {
  validateEmail(email: string): boolean {
    return true; // Simplest thing that passes
  }
}
```

**Run tests:**
```bash
npm test
```

**Expected output:**
```
PASS  src/user-validator.test.ts
  ✓ should return true for valid email
```

✅ Test passes.

### REFACTOR

No refactoring needed yet—code is minimal.

---

## Cycle 2: Email Validation (Invalid Email)

### RED: Write Failing Test

```typescript
it('should return false for invalid email without @', () => {
  const validator = new UserValidator();
  expect(validator.validateEmail('invalid')).toBe(false);
});
```

**Run tests:**
```bash
npm test
```

**Expected output:**
```
FAIL  src/user-validator.test.ts
  ✓ should return true for valid email
  ✕ should return false for invalid email without @
    Expected: false
    Received: true
```

✅ Test fails for the right reason.

### GREEN: Minimal Implementation

```typescript
export class UserValidator {
  validateEmail(email: string): boolean {
    return email.includes('@');
  }
}
```

**Run tests:**
```bash
npm test
```

```
PASS  src/user-validator.test.ts
  ✓ should return true for valid email
  ✓ should return false for invalid email without @
```

✅ Both tests pass.

### REFACTOR

Still simple—no refactoring needed.

---

## Cycle 3: Email Validation (Edge Case)

### RED: Write Failing Test

```typescript
it('should return false for email without domain', () => {
  const validator = new UserValidator();
  expect(validator.validateEmail('test@')).toBe(false);
});
```

**Expected failure:**
```
Expected: false
Received: true
```

### GREEN: Minimal Implementation

```typescript
export class UserValidator {
  validateEmail(email: string): boolean {
    const parts = email.split('@');
    return parts.length === 2 && parts[0].length > 0 && parts[1].length > 0;
  }
}
```

✅ All tests pass.

### REFACTOR

Extract to regex for cleaner validation:

```typescript
export class UserValidator {
  private static EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;

  validateEmail(email: string): boolean {
    return UserValidator.EMAIL_REGEX.test(email);
  }
}
```

**Run tests after refactor:**
```bash
npm test
```

✅ All tests still pass after refactor.

---

## Cycle 4: Password Validation

### RED: Write Failing Test

```typescript
describe('validatePassword', () => {
  it('should return true for password with 8+ characters', () => {
    const validator = new UserValidator();
    expect(validator.validatePassword('password123')).toBe(true);
  });
});
```

**Expected failure:** Method doesn't exist.

### GREEN: Minimal Implementation

```typescript
validatePassword(password: string): boolean {
  return password.length >= 8;
}
```

✅ Test passes.

---

## Cycle 5: Password Validation (Short Password)

### RED: Write Failing Test

```typescript
it('should return false for password with less than 8 characters', () => {
  const validator = new UserValidator();
  expect(validator.validatePassword('short')).toBe(false);
});
```

✅ Test already passes (implementation handles this).

Note: Sometimes tests pass immediately if the implementation is already correct. That's fine—the test still documents the expected behavior.

---

## Cycle 6: Username Validation

### RED: Write Failing Test

```typescript
describe('validateUsername', () => {
  it('should return true for alphanumeric username', () => {
    const validator = new UserValidator();
    expect(validator.validateUsername('user123')).toBe(true);
  });

  it('should return false for username with special characters', () => {
    const validator = new UserValidator();
    expect(validator.validateUsername('user@123')).toBe(false);
  });
});
```

### GREEN: Minimal Implementation

```typescript
validateUsername(username: string): boolean {
  return /^[a-zA-Z0-9]+$/.test(username);
}
```

✅ Both tests pass.

---

## Final Code

```typescript
// src/user-validator.ts
export class UserValidator {
  private static EMAIL_REGEX = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  private static USERNAME_REGEX = /^[a-zA-Z0-9]+$/;

  validateEmail(email: string): boolean {
    return UserValidator.EMAIL_REGEX.test(email);
  }

  validatePassword(password: string): boolean {
    return password.length >= 8;
  }

  validateUsername(username: string): boolean {
    return UserValidator.USERNAME_REGEX.test(username);
  }
}
```

```typescript
// src/user-validator.test.ts
import { UserValidator } from './user-validator';

describe('UserValidator', () => {
  let validator: UserValidator;

  beforeEach(() => {
    validator = new UserValidator();
  });

  describe('validateEmail', () => {
    it('should return true for valid email', () => {
      expect(validator.validateEmail('test@example.com')).toBe(true);
    });

    it('should return false for invalid email without @', () => {
      expect(validator.validateEmail('invalid')).toBe(false);
    });

    it('should return false for email without domain', () => {
      expect(validator.validateEmail('test@')).toBe(false);
    });
  });

  describe('validatePassword', () => {
    it('should return true for password with 8+ characters', () => {
      expect(validator.validatePassword('password123')).toBe(true);
    });

    it('should return false for password with less than 8 characters', () => {
      expect(validator.validatePassword('short')).toBe(false);
    });
  });

  describe('validateUsername', () => {
    it('should return true for alphanumeric username', () => {
      expect(validator.validateUsername('user123')).toBe(true);
    });

    it('should return false for username with special characters', () => {
      expect(validator.validateUsername('user@123')).toBe(false);
    });
  });
});
```

---

## Summary

| Cycle | Phase | Action |
|-------|-------|--------|
| 1 | RED | Test valid email |
| 1 | GREEN | Return true always |
| 2 | RED | Test invalid email |
| 2 | GREEN | Check for @ |
| 3 | RED | Test edge case |
| 3 | GREEN | Split and validate parts |
| 3 | REFACTOR | Extract to regex |
| 4-5 | RED/GREEN | Password validation |
| 6 | RED/GREEN | Username validation |

**Total: 6 TDD cycles, all tests pass, code is clean.**
