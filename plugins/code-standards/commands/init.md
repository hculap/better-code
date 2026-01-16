---
description: Initialize code-standards plugin with interactive setup
argument-hint: "[--reconfigure]"
allowed-tools: Read, Write, Edit, Bash(test:*), Bash(mkdir:*), AskUserQuestion
---

# Code Standards Initialization

Set up the code-standards plugin for this project. Walk the user through configuration options interactively.

## Setup Process

### Step 1: Check Existing Configuration

Check if `.claude/code-standards.local.md` already exists:

```bash
test -f .claude/code-standards.local.md && echo "EXISTS" || echo "NEW"
```

If EXISTS, inform user and ask whether to reconfigure or keep existing settings.

### Step 2: Gather Preferences

Use AskUserQuestion to ask the user about their preferences:

**Question 1 - Languages:**
- Ask: "Which languages should be checked?"
- Options: TypeScript/JavaScript, Python, Go, Java, Ruby, All common languages
- Allow multi-select

**Question 2 - Active Analysis:**
- Ask: "Enable proactive analysis after code edits?"
- Options: Yes (recommended), No

**Question 3 - Thresholds:**
- Ask: "Which threshold strictness level?"
- Options:
  - Relaxed (larger files/functions allowed)
  - Standard (recommended defaults)
  - Strict (smaller limits, stricter complexity)

**Question 4 - CLAUDE.md Integration:**
- Ask: "Add code standards rules to CLAUDE.md?"
- Options: Yes (recommended), No

### Step 3: Create Settings File

Create `.claude/code-standards.local.md` with YAML frontmatter based on user choices.

**Relaxed thresholds:**
```yaml
thresholds:
  file_loc: 600
  function_loc: 80
  complexity: 20
```

**Standard thresholds:**
```yaml
thresholds:
  file_loc: 400
  function_loc: 50
  complexity: 15
```

**Strict thresholds:**
```yaml
thresholds:
  file_loc: 250
  function_loc: 30
  complexity: 10
```

### Step 4: Update CLAUDE.md (if requested)

If user wants CLAUDE.md integration, append a `## Code Standards` section:

```markdown
## Code Standards

This project uses the code-standards plugin for quality enforcement.

### Size Limits
- Files: Target [X] LOC, max [Y] LOC
- Functions: Target [A] LOC, max [B] LOC
- Complexity: Max cyclomatic complexity [N]

### Principles
Follow KISS, DRY, YAGNI, and SRP principles.

### Review Checklist
- [ ] File/function sizes within limits
- [ ] One responsibility per module
- [ ] No silent error handling
- [ ] Tests cover important behavior
```

Adjust the limits based on the user's threshold choice.

### Step 5: Confirm Setup

Summarize what was configured:
- Settings file location
- Active languages
- Threshold level
- Whether CLAUDE.md was updated

Inform user how to:
- Run analysis: `/code-standards:check [path]`
- View settings: `/code-standards:config`
- Get review checklist: `/code-standards:checklist`
