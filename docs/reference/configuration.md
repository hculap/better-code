# Configuration Reference

This reference documents all configuration options for better-code plugins. Each plugin uses markdown-based settings files with YAML frontmatter for configuration.

## Overview of Configuration System

All better-code plugins use a consistent configuration approach:

- **Settings files** are stored in `.claude/<plugin-name>.local.md`
- **Format**: YAML frontmatter within a markdown file
- **Scope**: Settings are project-specific by default
- **Precedence**: Project settings override plugin defaults

### Settings File Structure

```markdown
---
key1: value1
key2: value2
---

Optional markdown content for notes or documentation.
```

### Settings File Locations

| Plugin | Settings File Path |
|--------|-------------------|
| tdd-dev | `.claude/tdd-dev.local.md` |
| doc-master | `.claude/doc-master.local.md` |
| n1-optimizer | No settings file (command-based) |
| readme-writer | No settings file (command-based) |

---

## tdd-dev Configuration

The tdd-dev plugin has the most extensive configuration options for controlling TDD enforcement behavior.

### Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `testCommand` | string | `npm test` | Command to run tests. Supports any test runner. |
| `strictness` | string | `strict` | Enforcement level for the red-green-refactor cycle. |
| `maxIterations` | integer | `5` | Maximum number of times to iterate on fixing failing tests. |
| `sourcePatterns` | array | `["src/**/*.ts", "src/**/*.js", "lib/**/*.ts", "lib/**/*.js"]` | Glob patterns for source files that require test-first changes. |
| `testPatterns` | array | `["**/*.test.ts", "**/*.spec.ts", "**/*.test.js", "**/*.spec.js", "test/**/*", "tests/**/*", "__tests__/**/*"]` | Glob patterns for test files. |

### Strictness Levels

| Level | Behavior |
|-------|----------|
| `strict` | (Default) Requires failing tests before any source modification. Enforces red-green-refactor cycle. |
| `standard` | Allows source modifications but prompts to write tests first. Softer enforcement. |
| `relaxed` | Monitors changes and suggests tests when appropriate. No blocking. |

### Example Configuration

```markdown
---
testCommand: npm run test:unit
strictness: standard
maxIterations: 3
sourcePatterns:
  - "src/**/*.ts"
  - "lib/**/*.ts"
testPatterns:
  - "**/*.test.ts"
  - "**/*.spec.ts"
---

## Project Notes

Using standard strictness for legacy codebase migration.
```

### Common testCommand Values

| Framework | testCommand Value |
|-----------|------------------|
| Jest | `npm test` or `npx jest` |
| Vitest | `npm run test` or `npx vitest run` |
| Mocha | `npm test` or `npx mocha` |
| pytest | `pytest` |
| RSpec | `bundle exec rspec` |
| Go | `go test ./...` |
| Cargo | `cargo test` |

---

## doc-master Configuration

The doc-master plugin supports configuration for documentation standards and agent behavior.

### Configuration Options

| Option | Type | Default | Description |
|--------|------|---------|-------------|
| `standard` | string | `diataxis` | Predefined documentation standard to use. |
| `proactive_agents` | boolean | `true` | Whether agents run automatically on relevant prompts. |
| `custom_source` | string | `null` | Path to custom documentation guidelines. |

### Standard Values

| Value | Description |
|-------|-------------|
| `diataxis` | Uses the Diataxis documentation framework (tutorials, how-to guides, explanations, references). |
| `traditional` | Uses traditional documentation structure (overview, getting started, API reference, examples, FAQ). |
| `custom` | Uses guidelines from `custom_source` path. |

### Example Configuration

```markdown
---
standard: diataxis
proactive_agents: true
custom_source: null
---

## Documentation Notes

Following Diataxis framework for all documentation.
```

### Proactive Agents Behavior

When `proactive_agents: true` (default):
- Agents automatically activate based on prompt patterns
- API documentation agent triggers on API-related prompts
- Backend documentation agent triggers on service-related prompts
- README generation triggers on relevant context

When `proactive_agents: false`:
- Agents only run when explicitly called via commands
- Use `/doc-master:generate`, `/doc-master:audit`, etc.

---

## n1-optimizer Configuration

The n1-optimizer plugin operates via commands and does not use a settings file. All configuration is passed at runtime.

### Runtime Options

| Option | Passed Via | Description |
|--------|-----------|-------------|
| Target path | Command argument | File or directory to analyze. Defaults to current directory. |

### Command Usage

```
/n1-optimizer:analyze [path]
```

| Argument | Required | Default | Description |
|----------|----------|---------|-------------|
| `path` | No | `.` (current directory) | Path to analyze for N+1 queries and performance issues. |

### No Persistent Configuration

The n1-optimizer is designed for on-demand analysis without persistent settings. Each analysis:
- Spawns 4 parallel agents
- Analyzes the specified codebase
- Produces a unified report
- Does not store state between runs

---

## readme-writer Configuration

The readme-writer plugin operates via commands and does not use a settings file.

### Runtime Options

| Option | Passed Via | Description |
|--------|-----------|-------------|
| Target path | Command argument | Path to generate or audit README for. |

### Command Usage

**Generate README:**
```
/readme-writer:generate [path]
```

**Audit existing README:**
```
/readme-writer:audit [path]
```

| Argument | Required | Default | Description |
|----------|----------|---------|-------------|
| `path` | No | `.` (current directory) | Directory containing the project to document. |

### No Persistent Configuration

The readme-writer generates documentation based on:
- Analysis of project structure
- Detection of framework and language
- Existing documentation (for audits)
- No stored preferences between runs

---

## Global vs Project Settings

### Project Settings (Recommended)

Store settings in your project's `.claude/` directory:

```
your-project/
  .claude/
    tdd-dev.local.md
    doc-master.local.md
  src/
  package.json
```

**Advantages:**
- Version controlled with project
- Shared across team members
- Project-specific configuration

### Global Settings

For user-level defaults, create settings in `~/.claude/`:

```
~/.claude/
  tdd-dev.local.md
  doc-master.local.md
```

### Settings Precedence

1. **Command flags** - Highest priority (e.g., `--strict`)
2. **Project settings** (`.claude/<plugin>.local.md`)
3. **Global settings** (`~/.claude/<plugin>.local.md`)
4. **Plugin defaults** - Lowest priority

### Creating Settings Files

Settings files are created automatically when you modify plugin settings, or you can create them manually:

```bash
# Create settings directory
mkdir -p .claude

# Create tdd-dev settings
cat > .claude/tdd-dev.local.md << 'EOF'
---
testCommand: npm test
strictness: strict
maxIterations: 5
---
EOF

# Create doc-master settings
cat > .claude/doc-master.local.md << 'EOF'
---
standard: diataxis
proactive_agents: true
---
EOF
```

---

## Configuration Summary

| Plugin | Has Settings File | Key Options |
|--------|------------------|-------------|
| tdd-dev | Yes | testCommand, strictness, maxIterations, sourcePatterns, testPatterns |
| doc-master | Yes | standard, proactive_agents, custom_source |
| n1-optimizer | No | Runtime path argument only |
| readme-writer | No | Runtime path argument only |

---

## Troubleshooting Configuration

### Settings Not Applied

1. Verify the settings file exists at `.claude/<plugin-name>.local.md`
2. Check YAML frontmatter syntax (proper `---` delimiters)
3. Ensure correct file naming (use `.local.md` suffix)

### Invalid Values

| Issue | Resolution |
|-------|-----------|
| Invalid strictness level | Use `strict`, `standard`, or `relaxed` |
| Invalid standard | Use `diataxis`, `traditional`, or specify `custom_source` |
| Glob pattern not matching | Test patterns with tools like `glob` or `find` |

### Viewing Current Settings

Plugin commands display current configuration when run:

```
/tdd-dev:start
```

This shows the active strictness level and test command being used.
