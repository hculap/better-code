# How to Configure TDD Test Patterns

This guide walks you through configuring custom file patterns for the tdd-dev plugin when your project does not follow standard naming conventions or directory structures.

## The Problem: Non-Standard Project Structures

The tdd-dev plugin needs to distinguish between two types of files:

- **Implementation files** (source code that requires tests before writing)
- **Test files** (always allowed to be created or edited)

The default patterns assume a typical JavaScript/TypeScript project with tests named `*.test.*` or `*.spec.*` inside a `src/` directory. If your project uses a different structure, the plugin may block legitimate test files or miss implementation files entirely.

## Understanding the Two Pattern Types

### sourcePatterns

The `sourcePatterns` setting defines which files the TDD enforcement applies to. Files matching these patterns trigger the "write tests first" requirement.

**Default value:** `["src/**/*.ts", "src/**/*.tsx", "app/**/*.py"]`

Only files matching `sourcePatterns` are subject to TDD enforcement. Files outside these patterns are not checked.

### testPatterns

The `testPatterns` setting defines which files are considered test files. These files are **always allowed** to be created or edited, regardless of strictness level.

**Default value:** `["**/*.test.*", "**/*.spec.*", "**/*.stories.*", "**/*.e2e.*", "**/__tests__/**", "**/__mocks__/**", "cypress/**", "playwright/**", "tests/**"]`

Test pattern matching takes priority over source pattern matching. A file that matches both patterns is treated as a test file and is always allowed.

## Creating Your Configuration File

Create the file `.claude/tdd-dev.local.md` in your project root with YAML frontmatter containing your custom patterns:

```markdown
---
strictness: strict
testCommand: npm test
sourcePatterns:
  - "src/**/*.ts"
  - "lib/**/*.ts"
testPatterns:
  - "**/*.test.ts"
  - "**/*.spec.ts"
  - "tests/**"
---

Any additional notes about your TDD workflow can go here.
```

The file must exist before running `/tdd-dev:start` for the settings to take effect.

## Glob Pattern Syntax

Both settings accept glob patterns with standard wildcard syntax:

| Pattern | Meaning |
|---------|---------|
| `*` | Matches any characters except path separators |
| `**` | Matches any characters including path separators (recursive) |
| `?` | Matches exactly one character |
| `{a,b}` | Matches either `a` or `b` |
| `[abc]` | Matches any character in the brackets |

## Example Configurations by Framework

### Jest (JavaScript/TypeScript)

```yaml
sourcePatterns:
  - "src/**/*.{ts,tsx,js,jsx}"
  - "lib/**/*.{ts,tsx,js,jsx}"
testPatterns:
  - "**/*.test.{ts,tsx,js,jsx}"
  - "**/*.spec.{ts,tsx,js,jsx}"
  - "**/__tests__/**"
  - "test/**"
```

### Vitest

```yaml
testCommand: npx vitest run
sourcePatterns:
  - "src/**/*.{ts,tsx}"
testPatterns:
  - "**/*.test.{ts,tsx}"
  - "**/*.spec.{ts,tsx}"
  - "tests/**"
```

### Pytest (Python)

```yaml
testCommand: pytest
sourcePatterns:
  - "src/**/*.py"
  - "app/**/*.py"
testPatterns:
  - "**/test_*.py"
  - "**/*_test.py"
  - "tests/**/*.py"
  - "conftest.py"
```

### RSpec (Ruby)

```yaml
testCommand: bundle exec rspec
sourcePatterns:
  - "app/**/*.rb"
  - "lib/**/*.rb"
testPatterns:
  - "spec/**/*_spec.rb"
  - "spec/spec_helper.rb"
  - "spec/rails_helper.rb"
```

### Go

```yaml
testCommand: go test ./...
sourcePatterns:
  - "**/*.go"
testPatterns:
  - "**/*_test.go"
```

### Django

```yaml
testCommand: python manage.py test
sourcePatterns:
  - "**/models.py"
  - "**/views.py"
  - "**/serializers.py"
  - "**/services/**/*.py"
testPatterns:
  - "**/tests.py"
  - "**/tests/**/*.py"
  - "**/test_*.py"
```

### Cypress (E2E Testing)

```yaml
sourcePatterns:
  - "src/**/*.{ts,tsx}"
testPatterns:
  - "**/*.test.{ts,tsx}"
  - "**/*.spec.{ts,tsx}"
  - "cypress/**/*.cy.{ts,js}"
  - "cypress/support/**"
  - "cypress/fixtures/**"
```

### Playwright

```yaml
sourcePatterns:
  - "src/**/*.{ts,tsx}"
testPatterns:
  - "**/*.test.{ts,tsx}"
  - "**/*.spec.{ts,tsx}"
  - "playwright/**/*.spec.{ts,js}"
  - "e2e/**/*.spec.{ts,js}"
```

## Troubleshooting: My Test Files Are Being Blocked

If the plugin blocks you from editing files you consider test files, follow these steps:

1. **Verify your configuration exists.** Check that `.claude/tdd-dev.local.md` is present and has valid YAML frontmatter with `testPatterns` defined.

2. **Check pattern matching.** Your test file path must match at least one pattern in `testPatterns`. For example, if your tests are in `testing/unit/foo.py`, neither `tests/**` nor `**/test_*.py` will match. Add `testing/**/*.py` to your patterns.

3. **Watch for case sensitivity.** Pattern matching may be case-sensitive on some systems. Ensure your patterns match the actual case of your file paths.

4. **Restart TDD mode.** After changing settings, run `/tdd-dev:stop` followed by `/tdd-dev:start` to reload the configuration.

5. **Debug with explicit patterns.** Temporarily add the exact path of the blocked file to `testPatterns` to confirm the configuration is being read correctly. Then adjust the glob pattern to cover similar files.

If enforcement still does not work as expected, verify that TDD mode is active by checking for the `.claude/.tdd-mode-active` file in your project.

## See Also

- [tdd-dev Command Reference](../reference/tdd-dev-commands.md)
- [How to Customize TDD Strictness](./tdd-strictness.md)
- [Configuration Reference](../reference/configuration.md)
