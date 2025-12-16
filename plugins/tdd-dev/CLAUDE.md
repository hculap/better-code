# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a Claude Code plugin that enforces Test-Driven Development (TDD) practices. It transforms Claude from a general code generator into a strict TDD practitioner using the Red→Green→Refactor cycle.

## Development Commands

```bash
# Test the plugin locally
claude --plugin-dir .

# Test settings parser
bash scripts/parse-settings.sh <setting-name> [project-dir]
```

## Architecture

### Plugin Structure

This is a Claude Code plugin following the standard structure:

- **`.claude-plugin/plugin.json`** - Plugin manifest (name, version, description)
- **`commands/`** - Slash commands (`/tdd-dev:start`, `/tdd-dev:stop`, `/tdd-dev:feature`, `/tdd-dev:bug`, `/tdd-dev:refactor`)
- **`agents/tdd-developer.md`** - Autonomous TDD agent triggered on feature/bug requests when TDD mode is active
- **`hooks/hooks.json`** - PreToolUse (Write|Edit) and Stop hooks for TDD enforcement
- **`skills/tdd-methodology/`** - TDD knowledge skill with references and examples

### State Management

TDD mode state is persisted via a flag file:
- **Created by:** `/tdd-dev:start` command
- **Location:** `.claude/.tdd-mode-active`
- **Content:** JSON with `active`, `activatedAt`, `strictness`, `testCommand`
- **Consumed by:** Hooks check this file to determine if enforcement is active

### Settings Resolution

Settings are read from YAML frontmatter in markdown files:
1. Project: `.claude/tdd-dev.local.md`
2. Global: `~/.claude/tdd-dev.local.md`
3. Command flags override both

The `scripts/parse-settings.sh` script parses these files (supports both inline values and list items).

### Hook Behavior

| Strictness | PreToolUse (Write/Edit) | Stop |
|------------|------------------------|------|
| strict | Deny without failing test | Block if cycle incomplete |
| standard | Ask for confirmation | Approve with warning |
| relaxed | Approve with coaching | Approve with tip |

Hooks check `.claude/tdd-dev.local.md` for custom `sourcePatterns`/`testPatterns` before using defaults.

### Command Flow

Commands use `EnterPlanMode` for user approval:
1. Parse arguments (flags, description)
2. Ask user about planning preference (unless `--plan` or `--skip-plan`)
3. If planning: Enter plan mode → Write plan → Exit for approval
4. Execute TDD loop: RED (write failing test) → GREEN (minimal impl) → REFACTOR
