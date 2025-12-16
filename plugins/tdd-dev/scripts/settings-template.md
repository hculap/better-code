# TDD Dev Settings Template

Copy this file to `.claude/tdd-dev.local.md` in your project root to configure TDD Dev plugin settings.

---

```markdown
---
# TDD Dev Plugin Configuration
# Copy to: .claude/tdd-dev.local.md

# Test command to run (auto-detected if not set)
# Examples: "npm test", "pnpm test", "pytest", "go test ./..."
testCommand:

# Strictness mode: strict | standard | relaxed
# - strict: Block implementation without failing test (default)
# - standard: Warn and prompt for confirmation
# - relaxed: Coach but don't enforce
strictness: strict

# Maximum Red→Green iterations before asking to continue
maxIterations: 5

# Source file patterns (hook enforcement applies to these)
sourcePatterns:
  - src/**/*.ts
  - src/**/*.tsx
  - src/**/*.js
  - src/**/*.jsx
  - app/**/*.py
  - lib/**/*.py
  - "*.go"

# Test file patterns (excluded from hook enforcement)
testPatterns:
  - "**/*.test.*"
  - "**/*.spec.*"
  - "**/__tests__/**"
  - tests/**
  - test/**
  - "*_test.go"
  - "test_*.py"
---

# Project-Specific TDD Notes

Add any project-specific testing notes here. This content will be available
to Claude when working on TDD tasks.

## Test Framework

- Framework: [Jest/Vitest/Pytest/Go testing/etc.]
- Config file: [jest.config.js/pytest.ini/etc.]

## Testing Conventions

- Test file location: [co-located/separate tests directory]
- Naming convention: [*.test.ts/*.spec.ts/test_*.py/etc.]

## Special Considerations

- [Any project-specific testing rules or patterns]
- [Integration test setup requirements]
- [Mock/stub conventions]
```

---

## Settings Reference

### testCommand

The command to run tests. If not specified, the plugin auto-detects:
- `package.json` → `npm test` or framework-specific command
- `pyproject.toml` / `pytest.ini` → `pytest`
- `go.mod` → `go test ./...`

### strictness

Controls how strictly TDD rules are enforced:

| Mode | Behavior |
|------|----------|
| `strict` | Block Write/Edit to source files without failing test |
| `standard` | Warn and ask for confirmation before proceeding |
| `relaxed` | Suggest TDD approach but allow any action |

### maxIterations

Number of Red→Green cycles before the agent pauses and asks to continue.
Default: 5

### sourcePatterns

Glob patterns for source files where TDD enforcement applies.
The hook checks these patterns to determine if a file write needs validation.

### testPatterns

Glob patterns for test files. Writes to test files are always allowed
regardless of TDD mode or strictness level.

---

## Global Settings

For user-level defaults that apply to all projects, create:
`~/.claude/tdd-dev.local.md`

Project settings override global settings.
Command flags override both.

---

## Merge Order

Settings are merged in this order (later overrides earlier):
1. Plugin defaults
2. Global settings (`~/.claude/tdd-dev.local.md`)
3. Project settings (`.claude/tdd-dev.local.md`)
4. Command flags (`--strict`, `--relaxed`, etc.)
