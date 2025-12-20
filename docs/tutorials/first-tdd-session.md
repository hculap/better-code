# Your First TDD Session with tdd-dev

In this tutorial, you will complete a full Test-Driven Development workflow using the tdd-dev plugin. By the end, you will have implemented an email validation function from scratch using the Red-Green-Refactor cycle, and you will understand how tdd-dev enforces test-first development.

## What You Will Build

You will create an `isValidEmail()` function that validates email addresses. This is a perfect first TDD exercise because it has clear requirements, multiple edge cases, and produces visible test results at each step.

## Prerequisites

Before starting, make sure you have:

- Completed the [Getting Started guide](./getting-started.md)
- A JavaScript or TypeScript project with a test runner configured (Jest, Vitest, or similar)
- The tdd-dev plugin installed (`/plugin install tdd-dev`)

Open your terminal in your project directory and start Claude Code.

## Step 1: Enable TDD Mode

Begin by activating TDD mode. This tells the plugin to enforce test-first development practices.

Type the following command:

```
/tdd-dev:start
```

You will see output similar to this:

```
TDD Dev Mode: ACTIVE

Configuration:
  Strictness: strict
  Test Command: npm test
```

TDD mode is now active. The plugin will prevent you from writing implementation code without corresponding tests. This enforcement keeps you honest during development and helps build the test-first habit.

## Step 2: Understand the Red-Green-Refactor Cycle

Before writing any code, take a moment to understand the three phases you will cycle through:

**Red Phase**: Write a failing test that describes what you want the code to do. The test fails because the implementation does not exist yet. Seeing the red (failing) test confirms your test is actually testing something.

**Green Phase**: Write the minimum code necessary to make the test pass. Do not add extra features or optimizations. The only goal is turning the test from red to green.

**Refactor Phase**: Improve the code without changing its behavior. Clean up duplication, improve naming, and restructure. Your tests protect you during refactoring because they will catch any accidental behavior changes.

These three phases repeat for each piece of functionality you add.

## Step 3: Start the Email Validation Feature

Now request the email validation feature. The `/tdd-dev:feature` command initiates a complete TDD workflow for a specific feature.

Type:

```
/tdd-dev:feature "implement an isValidEmail function that validates email addresses"
```

The plugin will acknowledge your request and begin the Red phase:

```
Starting TDD workflow for: isValidEmail function

Phase 1: RED - Writing Failing Tests

I'll create tests that define what valid and invalid emails look like.
These tests will fail initially because the function doesn't exist yet.
```

## Step 4: Observe the Red Phase

Watch as the plugin creates your test file. It will generate tests like these:

```javascript
// src/validation.test.js

describe('isValidEmail', () => {
  describe('valid emails', () => {
    it('should return true for standard email format', () => {
      expect(isValidEmail('user@example.com')).toBe(true);
    });

    it('should return true for email with subdomain', () => {
      expect(isValidEmail('user@mail.example.com')).toBe(true);
    });
  });

  describe('invalid emails', () => {
    it('should return false for email without @ symbol', () => {
      expect(isValidEmail('userexample.com')).toBe(false);
    });

    it('should return false for email without domain', () => {
      expect(isValidEmail('user@')).toBe(false);
    });

    it('should return false for empty string', () => {
      expect(isValidEmail('')).toBe(false);
    });
  });
});
```

The plugin will then run the tests:

```
Running tests...

FAIL  src/validation.test.js
  isValidEmail
    valid emails
      ✗ should return true for standard email format
      ✗ should return true for email with subdomain
    invalid emails
      ✗ should return false for email without @ symbol
      ✗ should return false for email without domain
      ✗ should return false for empty string

Tests: 5 failed, 0 passed

RED phase complete - tests are failing as expected.
Moving to GREEN phase...
```

This failing state is exactly what you want. The tests fail because `isValidEmail` does not exist. You have successfully defined the behavior before writing the implementation.

## Step 5: Observe the Green Phase

The plugin now enters the Green phase. It will write the minimum implementation to make the tests pass:

```
Phase 2: GREEN - Writing Minimal Implementation

Creating the simplest code that makes all tests pass.
```

You will see the implementation file created:

```javascript
// src/validation.js

function isValidEmail(email) {
  if (!email || typeof email !== 'string') {
    return false;
  }

  const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
  return emailRegex.test(email);
}

module.exports = { isValidEmail };
```

The plugin runs the tests again:

```
Running tests...

PASS  src/validation.test.js
  isValidEmail
    valid emails
      ✓ should return true for standard email format
      ✓ should return true for email with subdomain
    invalid emails
      ✓ should return false for email without @ symbol
      ✓ should return false for email without domain
      ✓ should return false for empty string

Tests: 5 passed

GREEN phase complete - all tests passing!
Moving to REFACTOR phase...
```

All five tests now pass. The implementation does exactly what the tests require and nothing more.

## Step 6: Observe the Refactor Phase

The plugin evaluates the code for potential improvements:

```
Phase 3: REFACTOR - Improving Code Quality

Reviewing implementation for:
- Code clarity
- Duplication
- Naming
- Structure

Analysis: The current implementation is simple and clear.
No refactoring needed at this stage.

Running tests to confirm behavior unchanged...

PASS  src/validation.test.js
Tests: 5 passed

TDD Cycle Complete!

Summary:
- Feature: isValidEmail function
- Tests written: 5
- All tests passing
- Code is clean and ready for use
```

In this case, the implementation was already clean. In more complex features, the Refactor phase might extract helper functions, rename variables for clarity, or reorganize code structure. The key point is that tests protect you during refactoring because any behavior change would cause a test to fail.

## Step 7: Disable TDD Mode

When you finish your TDD session, disable the mode:

```
/tdd-dev:stop
```

You will see confirmation:

```
TDD Dev Mode: DISABLED
```

TDD mode is now off. The plugin no longer enforces test-first development, and you can write implementation code directly if needed.

## What You Learned

In this tutorial, you completed a full TDD workflow:

1. **Enabled TDD mode** using `/tdd-dev:start`, which activated test-first enforcement
2. **Understood the Red-Green-Refactor cycle** and why each phase matters
3. **Used `/tdd-dev:feature`** to initiate a guided TDD workflow for email validation
4. **Observed the Red phase** where tests were written first and failed as expected
5. **Observed the Green phase** where minimal implementation made tests pass
6. **Observed the Refactor phase** where code quality was evaluated
7. **Disabled TDD mode** using `/tdd-dev:stop` when finished

The tdd-dev plugin enforced discipline throughout. You could not skip ahead to implementation because the hooks blocked writing implementation code without failing tests first.

## Next Steps

Try these exercises to deepen your TDD practice:

- Add more edge cases to your email validation (plus signs, international characters)
- Implement a password strength validator using the same workflow
- Experiment with strictness levels: `/tdd-dev:start --strict` for maximum enforcement
- Use `/tdd-dev:bug` to fix bugs with regression tests first

The test-first habit becomes natural with practice. Each feature you build through TDD will reinforce the cycle until it becomes your default development approach.

## See Also

- [tdd-dev Command Reference](../reference/tdd-dev-commands.md)
- [How to Customize TDD Strictness](../how-to/tdd-strictness.md)
- [How to Configure Test Patterns](../how-to/tdd-test-patterns.md)
