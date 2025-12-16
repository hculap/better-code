---
description: Safe refactoring verified by existing tests
argument-hint: "<target>" [--strict|--standard|--relaxed] [--file <path>] [--plan|--skip-plan]
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, TodoWrite, AskUserQuestion, EnterPlanMode, ExitPlanMode
---

# TDD Safe Refactor

Perform safe refactoring protected by existing tests: **$ARGUMENTS**

## Parse Arguments

Extract from arguments:
- **Target**: What to refactor (required) - can be:
  - File path: `src/utils.ts`
  - Symbol name: `calculateTotal`
  - Description: `extract validation logic`
- **--strict / --standard / --relaxed**: Override strictness mode (optional)
- **--file <path>**: Target specific file (optional, overrides target parsing)
- **--plan**: Force planning mode (require approval before refactoring)
- **--skip-plan**: Skip planning entirely, execute directly

## Target Resolution

Resolve the refactor target:

1. **If looks like a file path** (contains `/` or `.`):
   - Treat as file path
   - Verify file exists
   - Load file for analysis

2. **If looks like a symbol** (single word, camelCase, PascalCase):
   - Search codebase for function/class/method with that name
   - If found: Target that symbol
   - If multiple matches: Ask user to clarify

3. **If descriptive text**:
   - Analyze description to identify target code
   - Search for relevant patterns
   - Confirm understanding with user

## Plan Mode Decision

Determine planning behavior based on flags:

1. **If `--skip-plan` flag**: Skip planning, proceed directly to refactoring
2. **If `--plan` flag**: Force planning before refactoring
3. **If neither flag (default)**: Ask user using AskUserQuestion:
   - "Would you like to review and approve the refactoring plan before I start?"
   - Options: "Yes, show me the plan" / "No, proceed directly"

## Refactoring Planning Phase (unless --skip-plan)

If planning is enabled (via `--plan` flag or user choice):

1. **Enter plan mode**: Use EnterPlanMode tool
2. **Analyze the target code**:
   - What code smells or issues exist?
   - What refactoring transformations apply?
   - What tests cover this code?
3. **Write refactoring plan** to plan file including:
   - Target files and symbols
   - Proposed refactoring steps (in order)
   - Expected benefits of each change
   - Relevant test coverage
4. **Exit plan mode**: Wait for user approval via ExitPlanMode
5. **Proceed to refactoring** only after approval

## Pre-Refactor Verification

**Critical**: Refactoring requires GREEN state to begin.

1. **Run all tests**: Execute test command
2. **Verify GREEN**: All tests must pass before refactoring
3. **Identify relevant tests**: Which tests cover the target code?

```
Pre-Refactor Check:

Tests: X passed, 0 failed
Status: GREEN ✓ (safe to refactor)

Relevant tests covering target:
- [test 1]
- [test 2]
- [test 3]
```

If tests are failing:
```
Cannot refactor - tests are failing.

Failing tests:
- [test names]

Fix failing tests first, then retry refactor.
Use /tdd-dev:bug to fix issues with TDD.
```

## Refactoring Analysis

Analyze the target code for improvements:

1. **Code smells to address**:
   - Duplication (DRY violations)
   - Long methods (>20 lines)
   - Deep nesting (>3 levels)
   - Unclear naming
   - God classes/functions
   - Feature envy
   - Primitive obsession

2. **Proposed changes**:
   - List each refactoring step
   - Explain the benefit
   - Note any risks

Present analysis:
```
Refactoring Analysis: [target]

Current Issues:
1. [issue]: [description]
2. [issue]: [description]

Proposed Refactorings:
1. [refactoring]: [benefit]
2. [refactoring]: [benefit]

Proceed with refactoring? (Each step verified by tests)
```

## Refactoring Loop

### Execute One Change at a Time

For each proposed refactoring:

1. **Make single change**: One refactoring transformation
2. **Run tests immediately**: After every change
3. **Verify GREEN**: Tests must still pass
4. **If RED**: Immediately revert and try smaller step

```
Refactoring Step [N]: [description]

Change: [what was modified]
Tests: X passed, 0 failed
Status: GREEN ✓ (refactoring safe)
```

### Common Refactoring Transformations

Apply as appropriate:

- **Extract Method**: Pull code block into named function
- **Rename**: Improve variable/function/class names
- **Inline**: Remove unnecessary indirection
- **Extract Variable**: Name complex expressions
- **Move**: Relocate code to better location
- **Replace Conditional with Polymorphism**: Use OOP patterns
- **Introduce Parameter Object**: Group related parameters
- **Replace Magic Number with Constant**: Name numeric literals

### Revert on Failure

If any test fails after a change:

```
Refactoring REVERTED: [step description]

Reason: Test failure after change
Failing test: [test name]

Options:
1. Try smaller refactoring step
2. Skip this refactoring
3. Investigate test coupling
```

## Output Format

During refactoring:
```
Refactoring: [target]

Step [N]/[total]: [transformation]
  Before: [brief description]
  After: [brief description]
  Tests: PASS ✓
```

## Completion

When refactoring is complete:
```
Refactoring Complete: [target]

Changes Applied:
1. [change 1]
2. [change 2]
3. [change 3]

Files Modified: [list]
Tests: X passed, 0 failed
Final Status: GREEN ✓

Code quality improved while maintaining all behavior.
```

## Safety Guidelines

### What Refactoring IS:
- Improving code structure without changing behavior
- Making code easier to understand
- Reducing duplication
- Improving naming

### What Refactoring IS NOT:
- Adding new features
- Fixing bugs
- Changing behavior
- Performance optimization (usually)

If behavior change is needed:
```
Note: Requested change appears to modify behavior, not just structure.

This requires a test change. Use:
- /tdd-dev:feature for new behavior
- /tdd-dev:bug for fixing incorrect behavior

Continue with structure-only refactoring? (y/n)
```

## Insufficient Test Coverage

If target code lacks test coverage:
```
Warning: Limited test coverage for [target]

Existing tests may not catch regressions.

Options:
1. Add tests first (recommended)
2. Proceed carefully with manual verification
3. Abort refactoring

Recommendation: Use /tdd-dev:feature to add test coverage first.
```

Begin safe refactoring process.
