# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a monorepo of Claude Code plugins focused on code quality and developer productivity. The marketplace name is `better-code` and contains 5 plugins: tdd-dev, n1-optimizer, readme-writer, doc-master, and code-standards.

## Development Commands

```bash
# Test a plugin locally
claude --plugin-dir plugins/<plugin-name>

# Install from marketplace (for users)
/plugin marketplace add hculap/better-code
/plugin install <plugin-name>
```

## Repository Structure

```
.claude-plugin/marketplace.json   # Plugin registry for marketplace
plugins/
  tdd-dev/                        # TDD enforcement with hooks
  n1-optimizer/                   # Parallel performance analysis (4 agents)
  readme-writer/                  # README generation/auditing
  doc-master/                     # Documentation toolkit (9 agents)
  code-standards/                 # Code quality enforcement
```

## Plugin Architecture

Each plugin follows this structure:

```
plugin-name/
├── .claude-plugin/plugin.json    # Manifest: name, version, description, agents array
├── agents/*.md                   # Autonomous agents with YAML frontmatter
├── commands/*.md                 # Slash commands with YAML frontmatter
├── skills/<topic>/SKILL.md       # Knowledge skills with references/ and examples/
├── hooks/hooks.json              # (optional) Hook configuration
└── README.md
```

### Key File Conventions

- **Agent frontmatter**: `name`, `description` (with `<example>` blocks), `model`, `color`, `tools`
- **Command frontmatter**: `description`, `allowed-tools`, `argument-hint`
- **Skill frontmatter**: `name`, `description` (trigger phrases), `version`
- Use lowercase with hyphens for directories/files (except `SKILL.md`)
- Settings files: `.claude/plugin-name.local.md` with YAML frontmatter

### Plugin Patterns

**tdd-dev**: Uses hooks for enforcement. State stored in `.claude/.tdd-mode-active`. PreToolUse hooks intercept Write/Edit based on strictness level.

**n1-optimizer**: Parallel agent orchestration. The `analyze` command launches 4 agents simultaneously via multiple Task tool calls in one message.

**readme-writer/doc-master**: Single or multiple specialized agents triggered by description patterns. Agents generate/audit documentation.

## Marketplace Registration

When adding a new plugin, update `.claude-plugin/marketplace.json`:

```json
{
  "name": "plugin-name",
  "source": "./plugins/plugin-name",
  "description": "...",
  "version": "0.1.0",
  "author": { "name": "Szymon Paluch" },
  "repository": "https://github.com/hculap/better-code",
  "license": "MIT",
  "keywords": [...]
}
```

## Contributing

File an issue first to discuss proposed changes. Each plugin has its own CLAUDE.md with plugin-specific guidance.
