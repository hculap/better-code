# How to Customize TDD Strictness Modes

## The Problem

Teams have different TDD maturity levels and project contexts. A new project with a greenfield codebase benefits from strict enforcement, while legacy code maintenance requires flexibility. Choosing the wrong enforcement level creates friction: too strict blocks productivity, too relaxed defeats the purpose of TDD enforcement.

This guide walks you through selecting and configuring the right strictness mode for your situation.

## Understanding the Three Modes

The tdd-dev plugin provides three enforcement levels:

| Mode | Behavior | Hook Action |
|------|----------|-------------|
| **strict** | Blocks non-TDD writes entirely | Rejects file modifications without failing tests |
| **standard** | Prompts before allowing violations | Asks for confirmation, then proceeds |
| **relaxed** | Coaches but allows all writes | Provides TDD guidance without blocking |

## Setting Strictness in Configuration

For persistent settings across sessions, create a configuration file at `.claude/tdd-dev.local.md`:

```markdown
---
strictness: standard
testCommand: npm test
sourcePatterns:
  - "src/**/*.ts"
  - "src/**/*.tsx"
testPatterns:
  - "**/*.test.ts"
  - "**/*.spec.ts"
---

## Team TDD Guidelines

Our team follows strict Red-Green-Refactor for all new features.
```

The `strictness` value in the YAML frontmatter determines default behavior when you run `/tdd-dev:start` without flags.

### Configuration Options

```markdown
---
strictness: strict      # Options: strict, standard, relaxed
testCommand: npm test   # Command to run tests
sourcePatterns:         # Files subject to TDD enforcement
  - "src/**/*.ts"
testPatterns:           # Files always allowed (test files)
  - "**/*.test.ts"
  - "**/*.spec.ts"
---
```

## Overriding Per-Command

Override the configured default using command-line flags:

```bash
# Start with strict enforcement
/tdd-dev:start --strict

# Start with standard prompting
/tdd-dev:start --standard

# Start with coaching-only mode
/tdd-dev:start --relaxed
```

Command-line flags take precedence over the configuration file, allowing you to adjust enforcement for specific tasks without changing your defaults.

## When to Use Each Mode

### Strict Mode

Use for:
- Greenfield projects where TDD discipline is paramount
- Training sessions to build TDD habits
- Code review enforcement in critical paths
- Teams new to TDD who need guardrails

```bash
/tdd-dev:start --strict
```

The plugin blocks any write to implementation files until a failing test exists.

### Standard Mode

Use for:
- Day-to-day development with established TDD practices
- Teams comfortable with TDD but appreciating reminders
- Projects with mixed TDD coverage

```bash
/tdd-dev:start --standard
```

The plugin prompts before allowing non-TDD writes, giving you the choice to proceed or write tests first.

### Relaxed Mode

Use for:
- Legacy codebase maintenance
- Exploratory prototyping and spikes
- Bug fixes in untested code
- Gradual TDD adoption

```bash
/tdd-dev:start --relaxed
```

The plugin provides coaching suggestions without blocking. You receive guidance like: "Consider adding a regression test for this fix."

## Team Configuration Strategy

For team consistency, commit a shared configuration and allow individual overrides:

1. Create `.claude/tdd-dev.local.md` with team defaults
2. Add to `.gitignore` if individuals need local overrides
3. Or commit to enforce team-wide standards

## Troubleshooting

**Strict mode blocks a legitimate write**

Stop TDD mode temporarily, make the exception, then restart:
```bash
/tdd-dev:stop
# make your write
/tdd-dev:start --strict
```

**Standard mode prompts too frequently**

Switch to relaxed mode for exploratory work, then return to standard:
```bash
/tdd-dev:stop
/tdd-dev:start --relaxed
```

**Configuration changes not taking effect**

1. Verify the file path: `.claude/tdd-dev.local.md`
2. Check YAML frontmatter syntax (three dashes, correct indentation)
3. Restart TDD mode: `/tdd-dev:stop` then `/tdd-dev:start`

## See Also

- [tdd-dev Command Reference](../reference/tdd-dev-commands.md)
- [How to Configure Test Patterns](./tdd-test-patterns.md)
- [Understanding TDD Mode and Hook Enforcement](../explanations/tdd-mode-hooks.md)
