---
name: setup
description: Configure documentation standard (Diátaxis, Traditional, or Custom)
argument-hint: "[--reset]"
allowed-tools: ["Read", "Write", "Glob", "WebFetch", "AskUserQuestion"]
---

# Documentation Standards Setup

Configure the documentation framework for this project. First-run setup or reconfiguration of existing settings.

## Process

### Step 1: Check Existing Configuration

Read `.claude/doc-master.local.md` if it exists to check current settings.

### Step 2: Framework Selection

If no existing configuration or `--reset` flag provided, ask the user to choose:

1. **Diátaxis (Recommended)** - Modern four-quadrant approach
   - Tutorials (learning-oriented)
   - How-to guides (task-oriented)
   - Explanations (understanding-oriented)
   - Reference (information-oriented)
   - Best for: Products with diverse user bases, growing documentation

2. **Traditional** - Hierarchical structure
   - Overview
   - Getting Started
   - API Reference
   - Examples
   - FAQ
   - Best for: Developer tools, API-first projects, smaller codebases

3. **Custom** - Organization-specific standards
   - User provides source (local folder or URL)
   - Agent analyzes and creates rules
   - Best for: Teams with existing documentation standards

### Step 3: Custom Standards Setup (if selected)

If user selects Custom:

1. Ask for source location:
   - Local folder path (e.g., `/path/to/standards/`)
   - URL (e.g., `https://docs.company.com/style-guide`)

2. Fetch and analyze source materials:
   - For local folder: Read all markdown files
   - For URL: Fetch content with WebFetch

3. Extract rules for:
   - Writing style and voice
   - Document structure requirements
   - Terminology preferences
   - Quality criteria
   - Templates

4. Generate comprehensive rules in the configuration file

### Step 4: Proactive Agents Configuration

Ask user if documentation agents should trigger proactively:
- **Yes (default)**: Agents auto-trigger when user asks to document backend, frontend, API, etc.
- **No**: User must explicitly request doc-master agents

### Step 5: Save Configuration

Write configuration to `.claude/doc-master.local.md`:

```yaml
---
standard: diataxis | traditional | custom
proactive_agents: true | false
custom_source: null | /path | https://url
---

# Project Documentation Notes

[For custom: Include extracted rules and style guide]
[For all: Space for project-specific notes]
```

### Step 6: Confirmation

Display summary:
- Selected framework
- Agent behavior setting
- Custom source (if applicable)
- How to change settings: `/doc-master:setup --reset`

## Example Interactions

**First-time setup:**
```
User: /doc-master:setup
Assistant: Let me help you configure documentation standards for this project.
[Asks framework selection question]
[Asks proactive agents question]
[Creates configuration file]
```

**Reconfiguration:**
```
User: /doc-master:setup --reset
Assistant: I'll help you reconfigure your documentation standards.
Current setting: Diátaxis
[Offers new selection]
```

## Tips

- Diátaxis works best for most projects - start there if unsure
- Custom standards require well-organized source materials
- Proactive agents save time for documentation-heavy work
- Settings can be changed anytime with `--reset` flag
