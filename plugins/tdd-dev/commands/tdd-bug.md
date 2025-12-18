---
description: Fix a bug with regression test first
argument-hint: "<bug description>" [--strict|--standard|--relaxed] [--no-refactor] [--file <path>] [--plan|--skip-plan]
allowed-tools: Read, Write, Edit, Glob, Grep, Bash, TodoWrite, AskUserQuestion, EnterPlanMode, ExitPlanMode
---

# TDD Bug Fix

Fix a bug using Test-Driven Development - regression test first: **$ARGUMENTS**

## Parse Arguments

Extract from arguments:
- **Bug description**: The bug to fix (required)
- **--strict / --standard / --relaxed**: Override strictness mode (optional)
- **--no-refactor**: Skip refactor phase after green (optional)
- **--file <path>**: Target specific file (optional)
- **--plan**: Force planning mode (require approval before test and fix)
- **--skip-plan**: Skip planning entirely, execute directly

## Pre-Flight Checks

1. **Load settings**: Read `.claude/tdd-dev.local.md` if exists
2. **Determine strictness**: Use flag override > settings > default (strict)
3. **Detect test command**: From settings or auto-detect
4. **Locate bug**: Find the code responsible for the bug
5. **Reset TDD cycle state**: Create/update `.claude/.tdd-cycle-state` to start fresh RED phase:
   ```json
   {"phase": "red", "testFilesWritten": [], "testsRan": false, "testsFailed": false}
   ```
   This ensures hooks enforce "write regression test first" for this bug fix.

## Plan Mode Decision

Determine planning behavior based on flags:

1. **If `--skip-plan` flag**: Skip all planning, proceed directly to TDD loop
2. **If `--plan` flag**: Force planning before both RED and GREEN phases
3. **If neither flag (default)**: Ask user using AskUserQuestion:
   - "Would you like to review and approve the regression test plan before I write tests?"
   - Options: "Yes, show me the plan" / "No, proceed directly"
   - Store response for consistent behavior in GREEN phase

## Regression Test Planning Phase (unless --skip-plan)

If planning is enabled (via `--plan` flag or user choice):

1. **Enter plan mode**: Use EnterPlanMode tool
2. **Analyze the bug**:
   - What is the incorrect behavior?
   - How can we reproduce it in a test?
   - What should the correct behavior be?
3. **Write regression test plan** to plan file including:
   - Test file location
   - Test case that reproduces the bug
   - Expected vs actual behavior
   - Assertions that will fail due to bug
4. **Exit plan mode**: Wait for user approval via ExitPlanMode
5. **Proceed to RED phase** only after approval

## Bug Fix Planning Phase (unless --skip-plan)

After RED phase succeeds and before GREEN phase, if planning is enabled:

1. **Enter plan mode**: Use EnterPlanMode tool
2. **Analyze root cause**:
   - What code is causing the bug?
   - What's the minimal fix?
   - Are there any side effects to consider?
3. **Write fix plan** to plan file including:
   - Files to modify
   - Specific changes to make
   - Minimal fix strategy (no scope creep)
4. **Exit plan mode**: Wait for user approval via ExitPlanMode
5. **Proceed to GREEN phase** only after approval

## Bug Analysis

Before writing tests:

1. **Understand the bug**: What is the incorrect behavior?
2. **Identify root cause**: Where in the code does the bug occur?
3. **Define expected behavior**: What should happen instead?
4. **Find reproduction steps**: How to trigger the bug?

## TDD Bug Fix Loop

### Phase 1: RED - Write Regression Test

**Critical**: Write a test that FAILS due to the bug, proving the bug exists.

1. **Create regression test**:
   - Test name clearly describes the bug scenario
   - Test reproduces the exact failing condition
   - Test asserts the CORRECT expected behavior
2. **Run tests**: Execute test command
3. **Verify RED**: New test fails because of the bug

```
Regression Test: test_[bug_scenario]

Expected: [correct behavior]
Actual: [buggy behavior]
Status: RED ✓ (bug confirmed)
```

If the test passes immediately:
- Bug may already be fixed
- Bug description may be incorrect
- Test may not reproduce the bug correctly
- Investigate before proceeding

### Phase 2: GREEN - Fix the Bug

1. **Make minimal fix**: Change only what's necessary to fix the bug
2. **Avoid scope creep**: Don't refactor or add features
3. **Run tests**: Execute test command
4. **Verify GREEN**: Regression test passes, no new failures

```
Tests: X passed, 0 failed
Regression Test: PASSES ✓
Status: GREEN ✓ (bug fixed)
```

If fix causes other tests to fail:
- Investigate the relationship
- The "bug" might be intentional behavior
- May need to adjust approach

### Phase 3: REFACTOR (unless --no-refactor)

Only proceed when ALL tests are green.

1. **Review the fix**: Is the code clean?
2. **Consider improvements**:
   - Remove any duplication introduced
   - Improve naming if unclear
   - Simplify if possible
3. **Run tests after each change**
4. **Stay GREEN throughout**

## Output Format

Bug fix progress:
```
Bug Fix: [description]

Phase: [RED|GREEN|REFACTOR]
Action: [what was done]
Tests: X passed, Y failed
Regression Test: [FAILS|PASSES]

[Details if needed]
```

## Completion

When bug is fixed:
```
Bug Fixed: [description]

Summary:
  Regression Test: [test name]
  Root Cause: [brief explanation]
  Fix Applied: [what was changed]
  Files Modified: [list]
  Final Status: GREEN ✓

The bug will not regress - protected by test.
```

## Edge Cases

### Bug Cannot Be Reproduced

If unable to write a failing test:
```
Unable to reproduce bug in tests.

Attempted:
- [test approach 1]
- [test approach 2]

Possible reasons:
- Bug occurs in specific environment
- Bug is intermittent
- Bug description needs clarification

Recommendation: [next steps]
```

### Bug in External Dependency

If bug is in external code:
```
Bug appears to be in external dependency: [package]

Options:
1. Work around the bug in our code
2. Report/fix upstream
3. Pin to different version

Recommended: [approach]
```

### Multiple Related Bugs

If investigation reveals multiple issues:
```
Investigation revealed multiple related issues:
1. [issue 1]
2. [issue 2]
3. [issue 3]

Recommended approach: Fix one at a time with TDD.
Starting with: [most fundamental issue]
```

Begin the TDD bug fix process.
