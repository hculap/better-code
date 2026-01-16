---
description: Auto-refactor code to fix standards violations (conservative mode)
argument-hint: "[file-or-directory]"
allowed-tools: Read, Write, Edit, Glob, Grep, AskUserQuestion, Bash(wc:*, find:*)
---

# Code Standards Fix

Auto-refactor $ARGUMENTS to fix code standards violations. Uses conservative mode - shows plan first, asks for confirmation before each change.

If no argument provided, analyze and offer to fix violations in the current directory.

## Fix Process

### Step 1: Analyze Violations

First, perform the same analysis as `/code-standards:check` to identify all violations.

Categorize violations by type:
- **File too large** - needs splitting
- **Function too large** - needs extraction
- **High complexity** - needs simplification
- **Mixed responsibilities** - needs separation

### Step 2: Generate Fix Plan

For each violation, propose a specific fix:

```markdown
## Fix Plan

Found 4 violations in $ARGUMENTS. Here's the proposed fix plan:

### 1. Split `src/services/order.ts` (912 LOC → ~300 LOC each)

**Current:** Single file handling all order logic
**Proposed:** Split into 3 files:
- `src/services/order-creation.ts` - createOrder, validateOrder
- `src/services/order-processing.ts` - processOrder, handlePayment
- `src/services/order-fulfillment.ts` - shipOrder, trackOrder

**Impact:**
- Creates 3 new files
- Updates imports in 5 dependent files
- Original file will be deleted

### 2. Extract from `processPayment` (complexity 22 → ~8 each)

**Current:** Large switch statement for payment methods
**Proposed:** Strategy pattern with separate handlers:
- `PaymentProcessor` interface
- `CreditCardProcessor`, `PayPalProcessor`, `BankTransferProcessor`

**Impact:**
- Creates 4 new classes
- Simplifies `processPayment` to dispatcher

### 3. Extract validation from `createUser` (78 LOC → ~25 LOC)

**Current:** Validation mixed with user creation
**Proposed:** Extract to `validateUserData()` function

**Impact:**
- Adds 1 new function
- Reduces `createUser` by ~50 LOC

### 4. Split `formatData` helper (62 LOC → ~20 LOC each)

**Current:** Handles multiple data types in one function
**Proposed:** Split by type:
- `formatUserData()`, `formatOrderData()`, `formatProductData()`

**Impact:**
- Adds 3 new functions
- Original function becomes dispatcher

---

**Total changes:** 3 file splits, 2 function extractions, 8 new functions/classes
```

### Step 3: Confirm Before Each Change

Use AskUserQuestion for each proposed fix:

**Question:** "Apply fix #1: Split order.ts into 3 files?"
- Options: Yes, Skip this fix, Modify approach, Stop fixing

If "Modify approach", ask what changes they want to the proposed fix.

### Step 4: Apply Fixes

**Before applying fixes:**
- Recommend user commits or stashes current changes
- Report: "Tip: Run `git stash` or commit your changes before applying fixes for easy rollback."

For each confirmed fix:

1. **Announce** what's being changed
2. **Create** new files/functions
3. **Update** imports and references
4. **Verify** the change doesn't break anything obvious
5. **Report** what was done

**On failure:**
- Stop immediately and report which step failed
- Do NOT proceed to next fix if previous fix failed
- Report: "Fix failed. Your code may be in a partially modified state. Review changes with `git diff`."

### Step 5: Summary Report

After all fixes:

```markdown
## Fix Summary

**Applied:** 3 of 4 proposed fixes
**Skipped:** 1 fix (user choice)

### Changes Made

| Fix | Status | Files Changed |
|-----|--------|---------------|
| Split order.ts | Applied | Created 3 files, updated 5 imports |
| Extract payment strategies | Applied | Created 4 classes |
| Extract user validation | Applied | Added 1 function |
| Split formatData | Skipped | - |

### New Files Created
- `src/services/order-creation.ts`
- `src/services/order-processing.ts`
- `src/services/order-fulfillment.ts`
- `src/services/payments/processor.ts`
- `src/services/payments/credit-card.ts`
- `src/services/payments/paypal.ts`
- `src/services/payments/bank-transfer.ts`

### Next Steps
1. Run tests to verify changes
2. Review new file organization
3. Consider adding tests for extracted functions
```

## Refactoring Patterns

Reference the skill's `references/refactoring-patterns.md` for detailed patterns:

- **File splitting:** By domain/feature, by data types, by config
- **Function extraction:** Extract method, replace conditionals with polymorphism
- **Complexity reduction:** Guard clauses, extract validation, map/dict lookup

## Safety Measures

- **Never** delete files without creating replacements first
- **Always** update imports after moves
- **Preserve** all existing functionality
- **Create** backups by keeping original until confirmed working
- **Test** by suggesting user run tests after changes
