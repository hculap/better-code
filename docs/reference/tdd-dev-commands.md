# tdd-dev Command Reference

This reference provides complete documentation for all commands in the tdd-dev plugin. Each command is documented with its syntax, options, behavior, and examples.

## Quick Reference Table

| Command | Purpose | Key Flags |
|---------|---------|-----------|
| `/tdd-dev:start` | Enable TDD mode with hook enforcement | `--strict`, `--standard`, `--relaxed` |
| `/tdd-dev:stop` | Disable TDD mode and remove hooks | None |
| `/tdd-dev:feature` | Implement a new feature using TDD | `--plan`, `--skip-plan`, `--no-refactor`, strictness flags |
| `/tdd-dev:bug` | Fix a bug using TDD methodology | `--plan`, `--skip-plan`, strictness flags |
| `/tdd-dev:refactor` | Refactor code with test protection | `--plan`, `--skip-plan`, strictness flags |

---

## Strictness Levels

All TDD commands support three strictness levels that control how strictly the test-first approach is enforced:

| Level | Flag | Behavior |
|-------|------|----------|
| **Strict** | `--strict` | Blocks ALL implementation writes until tests exist. Maximum TDD enforcement. Default level. |
| **Standard** | `--standard` | Warns and prompts for confirmation before allowing writes without tests. |
| **Relaxed** | `--relaxed` | Advisory coaching only. No blocking. Gentle reminders to write tests first. |

---

## Planning Modes

Feature, bug, and refactor commands support planning mode control:

| Flag | Behavior |
|------|----------|
| `--plan` | Force planning mode - show plan and require approval before each phase |
| `--skip-plan` | Skip planning entirely, execute directly without approval |
| (default) | Ask user whether to use planning mode |

When planning is enabled, the agent will enter Claude Code's native plan mode before:
1. **Test Phase**: Shows planned test structure and assertions
2. **Implementation Phase**: Shows planned code changes and files to modify

---

## Commands

### /tdd-dev:start

Enable TDD mode with automatic hook-based enforcement.

#### Synopsis

```
/tdd-dev:start [--strict | --standard | --relaxed]
```

#### Description

Activates TDD mode for the current session. When enabled, hooks intercept file write operations and enforce the test-first development pattern according to the specified strictness level.

This command:
1. Creates the state file `.claude/.tdd-mode-active` to track TDD mode
2. Activates PreToolUse hooks that intercept `Write` and `Edit` operations
3. Enforces test-before-implementation workflow based on strictness

The hooks remain active until `/tdd-dev:stop` is called or the session ends.

#### Options

| Option | Description |
|--------|-------------|
| `--strict` | Block all implementation file writes until corresponding tests exist (default) |
| `--standard` | Warn and prompt for confirmation |
| `--relaxed` | Show advisory coaching without blocking writes |

#### Examples

**Enable TDD mode with default (strict) strictness:**
```
/tdd-dev:start
```

Output:
```
TDD Dev Mode: ACTIVE

Configuration:
  Strictness: strict
  Test Command: npm test
```

**Enable standard TDD enforcement:**
```
/tdd-dev:start --standard
```

**Enable relaxed mode for exploratory work:**
```
/tdd-dev:start --relaxed
```

#### Related Commands

- `/tdd-dev:stop` - Disable TDD mode
- `/tdd-dev:feature` - Implement features with TDD
- `/tdd-dev:bug` - Fix bugs with TDD
- `/tdd-dev:refactor` - Refactor with test protection

---

### /tdd-dev:stop

Disable TDD mode and remove enforcement hooks.

#### Synopsis

```
/tdd-dev:stop
```

#### Description

Deactivates TDD mode for the current session. This command:
1. Removes the `.claude/.tdd-mode-active` state file
2. Disables PreToolUse hooks that enforce test-first development
3. Returns to normal development mode without TDD enforcement

After running this command, file writes proceed without test-first validation.

#### Options

This command accepts no options.

#### Examples

**Disable TDD mode:**
```
/tdd-dev:stop
```

Output:
```
TDD Dev Mode: DISABLED
```

#### Related Commands

- `/tdd-dev:start` - Enable TDD mode

---

### /tdd-dev:feature

Implement a new feature using strict TDD methodology.

#### Synopsis

```
/tdd-dev:feature [--plan | --skip-plan] [--strict | --standard | --relaxed] [--no-refactor] [--file <path>] "<description>"
```

#### Description

Guides implementation of a new feature following the TDD Red-Green-Refactor cycle:

1. **Discovery Phase** (unless `--skip-plan`):
   - Analyze existing codebase structure
   - Identify affected components
   - Plan test and implementation strategy

2. **Red Phase**: Write failing tests first
   - Create test files defining expected behavior
   - Verify tests fail for the right reasons

3. **Green Phase**: Implement minimum code to pass
   - Write only enough implementation to make tests pass
   - Focus on correctness over elegance

4. **Refactor Phase** (unless `--no-refactor`): Improve while keeping tests green
   - Clean up code structure
   - Eliminate duplication
   - Ensure all tests still pass

#### Options

| Option | Description |
|--------|-------------|
| `--plan` | Force discovery and planning phase |
| `--skip-plan` | Skip directly to TDD implementation |
| `--no-refactor` | Stop after green phase, skip refactoring |
| `--file <path>` | Target specific test or source file |
| `--strict` | Block all implementation writes until tests exist (default) |
| `--standard` | Warn and prompt for confirmation |
| `--relaxed` | Advisory coaching only |

#### Arguments

| Argument | Description |
|----------|-------------|
| `<description>` | Description of the feature to implement (quoted string) |

#### Examples

**Implement a feature with planning:**
```
/tdd-dev:feature --plan "Add user authentication with JWT tokens"
```

**Quick feature implementation without planning:**
```
/tdd-dev:feature --skip-plan "Add email validation to signup form"
```

**Strict TDD enforcement:**
```
/tdd-dev:feature --strict "Implement shopping cart checkout"
```

**Stop after tests pass (no refactor):**
```
/tdd-dev:feature --no-refactor "Add pagination to user list"
```

**Combined flags:**
```
/tdd-dev:feature --plan --strict "Add payment processing integration"
```

#### Related Commands

- `/tdd-dev:start` - Enable persistent TDD mode
- `/tdd-dev:bug` - Fix bugs with TDD
- `/tdd-dev:refactor` - Refactor with test protection

---

### /tdd-dev:bug

Fix a bug using TDD methodology with regression test protection.

#### Synopsis

```
/tdd-dev:bug [--plan | --skip-plan] [--strict | --standard | --relaxed] [--file <path>] "<description>"
```

#### Description

Guides bug fixing using a TDD approach that ensures the bug cannot regress:

1. **Discovery Phase** (unless `--skip-plan`):
   - Reproduce and understand the bug
   - Identify root cause
   - Plan regression test strategy

2. **Red Phase**: Write a failing test that reproduces the bug
   - Create a test that fails due to the bug
   - Verify the test captures the exact failure condition

3. **Green Phase**: Fix the bug
   - Implement the minimum fix to make the test pass
   - Verify the fix addresses the root cause

4. **Refactor Phase**: Clean up the fix
   - Improve code quality if needed
   - Ensure all existing tests still pass
   - The new regression test protects against future regressions

#### Options

| Option | Description |
|--------|-------------|
| `--plan` | Force discovery and root cause analysis phase |
| `--skip-plan` | Skip directly to regression test creation |
| `--file <path>` | Target specific file containing the bug |
| `--strict` | Block all implementation writes until regression test exists (default) |
| `--standard` | Warn and prompt for confirmation |
| `--relaxed` | Advisory coaching only |

#### Arguments

| Argument | Description |
|----------|-------------|
| `<description>` | Description of the bug to fix (quoted string) |

#### Examples

**Fix a bug with investigation phase:**
```
/tdd-dev:bug --plan "Users can submit forms with invalid email addresses"
```

**Quick bug fix when cause is known:**
```
/tdd-dev:bug --skip-plan "Fix null pointer exception in user lookup"
```

**Strict enforcement for critical bugs:**
```
/tdd-dev:bug --strict --plan "Payment calculation returns incorrect totals"
```

**Target a specific file:**
```
/tdd-dev:bug --file src/services/auth.ts "Session token not refreshing"
```

#### Related Commands

- `/tdd-dev:start` - Enable persistent TDD mode
- `/tdd-dev:feature` - Implement features with TDD
- `/tdd-dev:refactor` - Refactor with test protection

---

### /tdd-dev:refactor

Refactor code safely with full test protection.

#### Synopsis

```
/tdd-dev:refactor [--plan | --skip-plan] [--strict | --standard | --relaxed] [--file <path>] "<description>"
```

#### Description

Guides code refactoring while maintaining test coverage as a safety net:

1. **Discovery Phase** (unless `--skip-plan`):
   - Analyze current code structure
   - Identify refactoring scope and approach
   - Verify existing test coverage is adequate

2. **Verify Phase**: Ensure tests pass before changes
   - Run existing test suite
   - Add tests for uncovered code paths if needed
   - Establish baseline for refactoring safety

3. **Refactor Phase**: Make incremental changes
   - Apply refactoring in small, testable steps
   - Run tests after each change
   - Maintain green test suite throughout

4. **Validate Phase**: Confirm refactoring success
   - Verify all tests still pass
   - Confirm behavioral equivalence
   - Review code quality improvements

#### Options

| Option | Description |
|--------|-------------|
| `--plan` | Force discovery and coverage analysis phase |
| `--skip-plan` | Skip directly to refactoring |
| `--file <path>` | Target specific file to refactor |
| `--strict` | Block all writes until adequate test coverage exists (default) |
| `--standard` | Warn and prompt for confirmation |
| `--relaxed` | Advisory coaching only |

#### Arguments

| Argument | Description |
|----------|-------------|
| `<description>` | Description of the refactoring to perform (quoted string) |

#### Examples

**Refactor with coverage analysis:**
```
/tdd-dev:refactor --plan "Extract authentication logic into separate service"
```

**Quick refactoring when coverage is known:**
```
/tdd-dev:refactor --skip-plan "Rename UserManager to UserService"
```

**Strict mode for risky refactoring:**
```
/tdd-dev:refactor --strict --plan "Restructure database access layer"
```

**Target a specific file:**
```
/tdd-dev:refactor --file src/utils/helpers.ts "Split into smaller modules"
```

**Large-scale refactoring:**
```
/tdd-dev:refactor --plan "Convert callbacks to async/await throughout codebase"
```

#### Related Commands

- `/tdd-dev:start` - Enable persistent TDD mode
- `/tdd-dev:feature` - Implement features with TDD
- `/tdd-dev:bug` - Fix bugs with TDD

---

## State Management

The plugin maintains state in the `.claude/` directory:

| File | Purpose |
|------|---------|
| `.claude/.tdd-mode-active` | Tracks whether TDD mode is enabled, strictness, and test command |
| `.claude/.tdd-cycle-state` | Tracks current TDD phase (red/green/refactor) |

The `.tdd-mode-active` file contains:
```json
{
  "active": true,
  "activatedAt": "2024-01-15T10:30:00Z",
  "strictness": "strict",
  "testCommand": "npm test"
}
```

These files are created by `/tdd-dev:start` and removed by `/tdd-dev:stop`.

---

## Hook Behavior

When TDD mode is active, hooks intercept operations:

| Hook | Trigger | Behavior |
|------|---------|----------|
| UserPromptSubmit | Every user prompt | Injects TDD context when mode is active |
| PreToolUse (Write\|Edit) | File writes | Validates against TDD rules based on strictness |
| PostToolUse (Bash) | Test runs | Detects test results and manages phase transitions |

### Strictness Enforcement

| Hook Trigger | Strict | Standard | Relaxed |
|--------------|--------|----------|---------|
| Write to source file | Block without failing test | Ask for confirmation | Approve with coaching |
| Write to test file | Always allowed | Always allowed | Always allowed |
| Write to config/docs | Always allowed | Always allowed | Always allowed |
| Incomplete TDD cycle | Block | Approve with warning | Approve with tip |

---

## Workflow Recommendations

### Starting a New Project
```
/tdd-dev:start --strict
```
Use strict mode to establish good TDD habits from the beginning.

### Working on Established Codebase
```
/tdd-dev:start --standard
```
Standard mode allows flexibility while encouraging test-first development.

### Exploratory Development
```
/tdd-dev:start --relaxed
```
Relaxed mode provides reminders without blocking rapid prototyping.

### Temporary TDD for Specific Tasks
Use task-specific commands (`/tdd-dev:feature`, `/tdd-dev:bug`, `/tdd-dev:refactor`) without `/tdd-dev:start` for one-off TDD workflows.

---

## See Also

- [Configuration Reference](./configuration.md) - Full configuration options
- [Your First TDD Session](../tutorials/first-tdd-session.md) - Step-by-step tutorial
- [How to Customize TDD Strictness](../how-to/tdd-strictness.md) - Choosing the right enforcement level
