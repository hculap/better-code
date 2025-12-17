---
description: Audit README against PRD-README v1 standard
argument-hint: [readme-path]
allowed-tools: Read, Glob, Grep, Bash(git:*, ls:*, test:*, wc:*)
---

Audit a README.md file against the PRD-README v1 standard and provide a detailed report with score.

## Target File

README path: $ARGUMENTS (default: README.md in current directory)

## Step 1: Read and Analyze README

Read the target README file completely.

## Step 2: Run 10 Acceptance Tests

Evaluate each test and record PASS or FAIL:

### Test 1: What Is It? (10-second rule)
**Check:**
- Project name visible immediately
- One-sentence value proposition exists
- Value proposition includes: what it does + for whom
- No unexplained jargon

**Result:** PASS / FAIL
**Issue (if fail):** [specific problem]

---

### Test 2: Is It Maintained? (10-second rule)
**Check:**
- Status indicator present (active/beta/stable/deprecated/unmaintained)
- OR recent commits visible
- OR clear version with date

**Result:** PASS / FAIL
**Issue (if fail):** [specific problem]

---

### Test 3: Quickstart Works (5-minute rule)
**Check:**
- Prerequisites listed with versions
- Install command is copy/pasteable
- Run command is copy/pasteable
- No placeholders requiring user edits (except secrets)

**Result:** PASS / FAIL
**Issue (if fail):** [specific problem]

---

### Test 4: Runnable Example Exists
**Check:**
- At least one complete code example
- Example is syntactically correct
- Example can be copied and run as-is
- Example demonstrates core functionality

**Result:** PASS / FAIL
**Issue (if fail):** [specific problem]

---

### Test 5: Expected Output Shown
**Check:**
- Quickstart shows what success looks like
- Output format is clear
- User knows when they've succeeded

**Result:** PASS / FAIL
**Issue (if fail):** [specific problem]

---

### Test 6: Navigation (10-second rule)
**Check:**
- Can find Installation in ≤10 seconds
- Can find Usage in ≤10 seconds
- Can find Support/Help in ≤10 seconds
- Table of contents if README > 500 lines

**Result:** PASS / FAIL
**Issue (if fail):** [specific problem]

---

### Test 7: License Explicit
**Check:**
- License name stated in README
- Link to LICENSE file exists
- Verify LICENSE file exists

**Result:** PASS / FAIL
**Issue (if fail):** [specific problem]

---

### Test 8: Contribution Route Clear
**Check:**
- Contributing section exists OR
- Explicit statement that contributions not accepted
- If accepting: link to CONTRIBUTING.md or inline instructions

**Result:** PASS / FAIL
**Issue (if fail):** [specific problem]

---

### Test 9: Accessibility
**Check:**
- Headings follow hierarchy (# → ## → ###, no skipping)
- Images have alt text (not empty or just "image")
- Links have descriptive text (not "click here")
- Paragraphs are reasonable length

**Result:** PASS / FAIL
**Issue (if fail):** [specific problem]

---

### Test 10: Appropriate Scope
**Check:**
- README focuses on getting started
- Deep details link elsewhere
- README < 2000 lines
- Not trying to be full API documentation

**Result:** PASS / FAIL
**Issue (if fail):** [specific problem]

---

## Step 3: Calculate Score

Count passed tests: X / 10

## Step 4: Prioritize Issues

Categorize failed tests by priority:

**P0 - Critical (fix immediately):**
- Test 1 fail → users can't understand what it is
- Test 3 fail → users can't try it
- Test 7 fail → license missing = legal risk

**P1 - High (fix soon):**
- Test 2 fail → trust issue
- Test 4 fail → no working examples
- Test 5 fail → success unclear

**P2 - Medium (improve):**
- Test 6 fail → navigation
- Test 8 fail → contribution path

**P3 - Low (polish):**
- Test 9 fail → accessibility
- Test 10 fail → scope

## Step 5: Generate Report

Present audit report in this format:

```
# README Audit Report

**File:** [path]
**Date:** [current date]
**Score:** X / 10

## Summary

[1-2 sentence overall assessment based on score]

## Test Results

### Passed (X tests)
- ✓ [Test name]
- ✓ [Test name]

### Failed (X tests)

#### [Priority] Test X: [Name]
**Issue:** [specific problem found]
**Fix:** [concrete action to resolve]
**Example:** [show before/after if applicable]

## Recommended Actions (Priority Order)

1. [P0] [First fix]
2. [P1] [Second fix]
3. [P2] [Third fix]

## Auto-Fix Available

The following issues can be auto-fixed:
- [ ] [Issue description]
- [ ] [Issue description]

Would you like me to apply these fixes?
```

## Step 6: Offer Auto-Fix

If user requests fixes:
1. Apply fixes in priority order
2. Show each change made
3. Re-run relevant tests to verify
4. Present updated score

For complex issues, explain what manual action is needed.
