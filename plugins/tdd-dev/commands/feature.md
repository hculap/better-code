---
description: Implement a new feature using full TDD loop
argument-hint: "<feature description>" [--strict|--standard|--relaxed] [--no-refactor] [--file <path>] [--plan|--skip-plan]
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, TodoWrite, AskUserQuestion, EnterPlanMode, ExitPlanMode
---

# TDD Feature Implementation

Implement a new feature using strict Test-Driven Development: **$ARGUMENTS**

## Parse Arguments

Extract from arguments:
- **Feature description**: The main description (required)
- **--strict / --standard / --relaxed**: Override strictness mode (optional)
- **--no-refactor**: Skip refactor phase after green (optional)
- **--file <path>**: Target specific file for tests/implementation (optional)
- **--plan**: Force planning mode (require approval before test and implementation)
- **--skip-plan**: Skip planning entirely, execute directly

## Pre-Flight Checks

1. **Load settings**: Read `.claude/tdd-dev.local.md` if exists
2. **Determine strictness**: Use flag override > settings > default (strict)
3. **Detect test command**: From settings or auto-detect from project files
4. **Identify test location**: Find appropriate test file or create new one
5. **Reset TDD cycle state**: Create/update `.claude/.tdd-cycle-state` to start fresh RED phase:
   ```json
   {"phase": "red", "testFilesWritten": [], "testsRan": false, "testsFailed": false}
   ```
   This ensures hooks enforce "write test first" for this new feature.

## Plan Mode Decision

Determine planning behavior based on flags:

1. **If `--skip-plan` flag**: Skip all planning, proceed directly to TDD loop
2. **If `--plan` flag**: Force planning before both RED and GREEN phases
3. **If neither flag (default)**: Ask user using AskUserQuestion:
   - "Would you like to review and approve the test plan before I write tests?"
   - Options: "Yes, show me the plan" / "No, proceed directly"
   - Store response for consistent behavior in GREEN phase

## Test Planning Phase (unless --skip-plan)

If planning is enabled (via `--plan` flag or user choice):

1. **Enter plan mode**: Use EnterPlanMode tool
2. **Analyze requirements**:
   - What behaviors need testing for this feature?
   - What edge cases should be covered?
   - What test structure fits the project best?
3. **Write test plan** to plan file including:
   - Test file location
   - Test cases to write (describe/it structure)
   - Expected assertions for each test
   - Mocking strategy if external dependencies involved
4. **Exit plan mode**: Wait for user approval via ExitPlanMode
5. **Proceed to RED phase** only after approval

## Implementation Planning Phase (unless --skip-plan)

After RED phase succeeds and before GREEN phase, if planning is enabled:

1. **Enter plan mode**: Use EnterPlanMode tool
2. **Analyze failing tests**:
   - What's the minimal code to make tests pass?
   - What dependencies are needed?
   - What files need creation or modification?
3. **Write implementation plan** to plan file including:
   - Files to create/modify
   - Functions/classes to implement
   - Dependencies to add (if any)
   - Minimal implementation strategy (no over-engineering)
4. **Exit plan mode**: Wait for user approval via ExitPlanMode
5. **Proceed to GREEN phase** only after approval

## TDD Loop Execution

### Iteration Tracking

- Maximum iterations: 5 (configurable in settings)
- Track cycle count and outcomes
- After limit: Summarize and ask to continue

### Phase 1: RED - Write Failing Test

1. **Analyze requirement**: Understand what behavior is needed for this feature
2. **Locate test file**: Find existing test file or determine where to create one
3. **Write test first**:
   - Clear, descriptive test name
   - Arrange-Act-Assert structure
   - Test the expected behavior, not implementation details
4. **Run tests**: Execute test command
5. **Verify RED**: Confirm test fails for the right reason (missing behavior, not syntax error)

Present test output summary:
```
Tests: X passed, Y failed
Failing: [test names]
Status: RED ✓ (expected)
```

### Phase 2: GREEN - Minimal Implementation

1. **Write minimal code**: Only enough to make the failing test pass
2. **No over-engineering**: Resist adding features not required by tests
3. **Run tests**: Execute test command
4. **Verify GREEN**: All tests pass (new test + no regressions)

Present test output summary:
```
Tests: X passed, 0 failed
Status: GREEN ✓
```

If tests still fail:
- Analyze failure
- Make minimal fix
- Re-run tests
- Iterate until green (up to limit)

### Phase 3: REFACTOR (unless --no-refactor)

Only proceed when ALL tests are green.

1. **Identify improvements**:
   - Remove duplication
   - Improve naming
   - Simplify structure
   - Extract methods if beneficial
2. **Make ONE change at a time**
3. **Run tests after each change**
4. **Stay GREEN throughout**

If tests fail during refactor:
- Immediately revert the change
- Try a smaller refactoring step

## Output Format

After each cycle, show:
```
Cycle [N]: [RED|GREEN|REFACTOR]

Action: [what was done]
Tests: X passed, Y failed (score: Z%)
Status: [current phase status]

[If failed: specific failure details]
```

## Completion

When feature is complete:
```
Feature Complete: [feature description]

Summary:
  Cycles: [N]
  Tests Added: [count]
  Files Changed: [list]
  Final Status: GREEN ✓

Test Coverage: [if measurable]
```

## Error Handling

- **Test command not found**: Ask user to configure test command
- **Syntax errors in test**: Fix before proceeding to implementation
- **Iteration limit reached**: Summarize attempts, ask to continue or stop
- **Unclear requirement**: Ask clarifying questions before writing test

Begin the TDD loop for the requested feature.
