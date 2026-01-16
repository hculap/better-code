# CLAUDE.md - Code Standards Plugin

Developer guidance for maintaining and extending the code-standards plugin.

## Component Overview

| Type | File | Purpose |
|------|------|---------|
| Command | `commands/check.md` | Analyze files against thresholds, report violations |
| Command | `commands/checklist.md` | Output review checklist for copy/paste |
| Command | `commands/config.md` | View/edit settings in `.claude/code-standards.local.md` |
| Command | `commands/fix.md` | Auto-refactor to fix violations |
| Command | `commands/init.md` | Interactive setup wizard |
| Agent | `agents/code-standards-enforcer.md` | Active analysis triggered by PostToolUse hook |
| Skill | `skills/code-standards/SKILL.md` | Core knowledge: principles, thresholds, patterns |
| Reference | `skills/code-standards/references/language-thresholds.md` | Per-language size limits |
| Reference | `skills/code-standards/references/refactoring-patterns.md` | Common refactoring techniques |
| Hook | `hooks/hooks.json` | PostToolUse hook for active analysis |

## Canonical Thresholds

These are the authoritative threshold values used throughout the plugin:

| Metric | Soft Limit (Warning) | Hard Limit (Critical) |
|--------|----------------------|-----------------------|
| File LOC | 400 | 800 |
| Function LOC | 50 | 80 |
| Complexity | 15 | 20 |

**Note:** Language-specific thresholds in `references/language-thresholds.md` may override these defaults. For example, TypeScript uses stricter limits (600/60) due to its emphasis on small, composable modules.

## Settings File Format

Settings are stored in `.claude/code-standards.local.md` with YAML frontmatter:

```yaml
---
enabled: true
active_analysis: true
languages: [typescript, python, go]
thresholds:
  file_loc: 400
  function_loc: 50
  complexity: 15
---

Optional markdown content below the frontmatter for project-specific notes.
```

### Settings Precedence

1. Command flags (highest priority)
2. Project settings: `.claude/code-standards.local.md`
3. Plugin defaults (lowest priority)

## Hook Behavior

The PostToolUse hook in `hooks/hooks.json` triggers after Write/Edit operations:

1. **Check settings file**: Look for `.claude/code-standards.local.md` with `active_analysis: true`
   - If missing or not enabled → return empty JSON `{}` (silent, no interruption)
2. **Check file extension**: Must be a recognized source file
   - If not a source file → return empty JSON `{}` (silent, no interruption)
3. **Suggest analysis**: If all checks pass, return `{"systemMessage": "..."}` to suggest using the code-standards-enforcer agent

**Important**: The hook must return ONLY valid JSON to avoid interrupting the main agent's workflow. Never output explanatory text.

Recognized source extensions: `.ts`, `.tsx`, `.js`, `.jsx`, `.py`, `.go`, `.java`, `.rb`, `.rs`, `.php`, `.swift`, `.kt`, `.cs`

## Testing

Test the plugin locally:

```bash
# From repository root
claude --plugin-dir plugins/code-standards

# Test commands
/code-standards:init
/code-standards:check src/
/code-standards:config
/code-standards:checklist
```

### Test Scenarios

| Scenario | Expected Behavior |
|----------|-------------------|
| `check` with valid path | Analyzes files, reports violations in table format |
| `check` with invalid path | Reports path not found |
| `check` with empty directory | Reports no files found |
| `config` view mode | Displays current settings |
| `config` edit mode | Updates specified setting |
| `init` fresh setup | Creates settings file with user choices |
| `init --reconfigure` | Overwrites existing settings |
| Hook: source file edit (active) | Returns JSON with systemMessage suggesting enforcer agent |
| Hook: source file edit (inactive) | Returns empty JSON `{}`, no interruption |
| Hook: non-source file edit | Returns empty JSON `{}`, no interruption |
| Hook: missing settings file | Returns empty JSON `{}`, no interruption |

## File Naming Conventions

- Commands: lowercase with hyphens, `.md` extension
- Agents: lowercase with hyphens, `.md` extension
- Skills: `SKILL.md` (uppercase) in topic directory
- References: lowercase with hyphens in `references/` subdirectory
