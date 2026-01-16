---
description: Analyze files against code standards thresholds
argument-hint: "[file-or-directory]"
allowed-tools: Read, Glob, Grep, Bash(wc:*, find:*)
---

# Code Standards Check

Analyze $ARGUMENTS against code standards thresholds.

If no argument provided, analyze the current directory.

## Analysis Process

### Step 1: Load Settings

Read `.claude/code-standards.local.md` if it exists to get configured thresholds.
If not found, use default thresholds:
- File LOC: 400 (warning), 800 (critical)
- Function LOC: 50 (warning), 80 (critical)
- Complexity: 15 (warning), 20 (critical)

### Step 2: Validate Target Path

If $ARGUMENTS is provided, verify the path exists:

**If path does not exist:**
```
Error: Path not found: `[path]`

Please verify the path exists. Use `/code-standards:check .` to analyze current directory.
```

**If path exists but no source files found in directory:**
```
No analyzable source files found in `[path]`

Supported: *.ts, *.tsx, *.js, *.jsx, *.py, *.go, *.java, *.rb
Excluded: node_modules, vendor, .git, dist, build
```

### Step 3: Identify Target Files

If $ARGUMENTS is a single file, analyze that file.
If $ARGUMENTS is a directory, find all source files:
- TypeScript/JavaScript: `*.ts`, `*.tsx`, `*.js`, `*.jsx`
- Python: `*.py`
- Go: `*.go`
- Java: `*.java`
- Ruby: `*.rb`
- Rust: `*.rs`
- PHP: `*.php`
- Swift: `*.swift`
- Kotlin: `*.kt`
- C#: `*.cs`

Exclude common directories: `node_modules`, `vendor`, `.git`, `dist`, `build`, `__pycache__`

### Step 4: Analyze Each File

For each file:

1. **Count lines of code** (exclude blank lines and comments where possible)
2. **Identify functions/methods** and their line counts
3. **Estimate cyclomatic complexity** based on:
   - `if`, `else`, `elif`, `else if` statements
   - `for`, `while`, `loop` iterations
   - `case`, `when`, `switch` branches
   - `&&`, `||` logical operators
   - `catch`, `except`, `rescue` exception handlers
   - Ternary operators `? :`

### Step 5: Report Violations

Output a structured markdown table:

```markdown
## Code Standards Report

**Target:** $ARGUMENTS
**Files analyzed:** [count]
**Violations found:** [count]

### Violations

| File | Issue | Severity | Line | Suggestion |
|------|-------|----------|------|------------|
| `src/service.ts` | File exceeds 600 LOC (742) | Warning | - | Split by domain responsibility |
| `src/service.ts:45` | Function `processOrder` exceeds 80 LOC (112) | Critical | 45-157 | Extract helper functions |
| `src/utils.ts:89` | Complexity >15 in `handleRequest` (18) | Warning | 89 | Simplify conditionals or extract |

### Summary

- **Critical:** [count] issues (must fix)
- **Warning:** [count] issues (should address)
- **Info:** [count] notes (consider)

### Recommendations

[Based on violations, provide 2-3 specific refactoring suggestions]
```

### Severity Levels

**Critical** (must fix):
- File LOC > hard limit
- Function LOC > hard limit
- Complexity > 20

**Warning** (should address):
- File LOC > soft limit
- Function LOC > soft limit
- Complexity > 15

**Info** (consider):
- Approaching soft limits (>80% of threshold)
- Minor naming issues
- Missing error handling patterns

### Output Example

```markdown
## Code Standards Report

**Target:** src/
**Files analyzed:** 12
**Violations found:** 5

### Violations

| File | Issue | Severity | Line | Suggestion |
|------|-------|----------|------|------------|
| `src/api/users.ts` | File exceeds 400 LOC (523) | Warning | - | Split user CRUD from user validation |
| `src/api/users.ts:156` | `createUser` exceeds 50 LOC (78) | Warning | 156-234 | Extract validation and notification logic |
| `src/services/order.ts` | File exceeds 800 LOC (912) | Critical | - | Split by order lifecycle stages |
| `src/services/order.ts:234` | `processPayment` complexity 22 | Critical | 234 | Use strategy pattern for payment methods |
| `src/utils/helpers.ts:45` | `formatData` exceeds 50 LOC (62) | Warning | 45-107 | Split by data type |

### Summary

- **Critical:** 2 issues (must fix)
- **Warning:** 3 issues (should address)
- **Info:** 0 notes

### Recommendations

1. **Split `order.ts`** into `order-creation.ts`, `order-processing.ts`, and `order-fulfillment.ts`
2. **Refactor `processPayment`** using strategy pattern - each payment method as separate handler
3. **Extract validation** from `createUser` into `user-validation.ts`
```
