---
description: View or edit current code-standards settings
argument-hint: [set key=value]
allowed-tools: Read, Write, Edit, AskUserQuestion
---

# Code Standards Configuration

View or modify current code-standards settings.

## Usage Modes

### View Mode (no arguments)

If $ARGUMENTS is empty, display current configuration:

1. Read `.claude/code-standards.local.md`
2. Parse YAML frontmatter
3. Display in readable format:

```markdown
## Current Code Standards Configuration

**Status:** Enabled/Disabled
**Active Analysis:** Yes/No

### Languages
- TypeScript/JavaScript
- Python
- Go

### Thresholds
| Metric | Value | Level |
|--------|-------|-------|
| File LOC | 400 | Standard |
| Function LOC | 50 | Standard |
| Complexity | 15 | Standard |

### Integrations
- CLAUDE.md: Yes

### Settings File
Location: `.claude/code-standards.local.md`

To modify, use `/code-standards:config set <key>=<value>`
Or run `/code-standards:init` to reconfigure interactively.
```

If no settings file exists, inform user and suggest running `/code-standards:init`.

### Edit Mode (with arguments)

If $ARGUMENTS contains `set key=value`, modify the setting:

**Supported keys:**
- `enabled` - true/false
- `active_analysis` - true/false
- `file_loc` - number (file LOC threshold)
- `function_loc` - number (function LOC threshold)
- `complexity` - number (complexity threshold)

**Example usage:**
```
/code-standards:config set file_loc=500
/code-standards:config set active_analysis=false
/code-standards:config set complexity=12
```

### Edit Process

1. Read current `.claude/code-standards.local.md`
2. Parse YAML frontmatter
3. Update the specified key
4. Write back the file
5. Confirm the change

**Example output:**
```markdown
Updated `file_loc` from 400 to 500.

New configuration:
- File LOC threshold: 500
- Function LOC threshold: 50
- Complexity threshold: 15
```

### Interactive Edit Mode

If $ARGUMENTS is `edit` or `interactive`, use AskUserQuestion to let user modify settings interactively:

**Question 1:** "What would you like to change?"
- Options: Thresholds, Languages, Active analysis, Everything

Based on selection, ask follow-up questions to update specific settings.

## Error Handling

**No settings file:**
```markdown
No configuration found at `.claude/code-standards.local.md`.

Run `/code-standards:init` to set up the plugin, or create settings manually.
```

**YAML parse error:**
```markdown
Error: Could not parse settings file `.claude/code-standards.local.md`

The YAML frontmatter appears to be malformed. Common issues:
- Missing `---` delimiters
- Invalid indentation
- Unquoted special characters

To fix:
1. Check the file manually for syntax errors
2. Or delete the file and run `/code-standards:init` to recreate it
```

**Write error:**
```markdown
Error: Could not save settings to `.claude/code-standards.local.md`

Please check:
- The `.claude/` directory exists
- You have write permissions
- The disk is not full

Try creating the directory manually: `mkdir -p .claude`
```

**Invalid key:**
```markdown
Unknown setting key: `$KEY`

Valid keys:
- enabled
- active_analysis
- file_loc
- function_loc
- complexity
```

**Invalid value:**
```markdown
Invalid value for `$KEY`: $VALUE

Expected: [type/range]
```
