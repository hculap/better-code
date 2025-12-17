# readme-writer

Generate and audit perfect READMEs using the PRD-README v1 standard.

Status: beta | [Issues](https://github.com/your-repo/readme-writer/issues)

## Overview

This Claude Code plugin helps you create READMEs that reliably produce:

- **Correct adoption decisions** - Readers quickly know if your project fits their needs
- **Fast first success** - Copy/paste path to working result in under 5 minutes
- **Low support burden** - Answers top questions upfront
- **Sustained trust** - Clear status and quality signals
- **Low drift** - Documentation stays accurate

## Features

- **Generate READMEs** - Auto-detect project context and generate documentation following the 9-step PRD-README v1 process
- **Audit READMEs** - Score existing READMEs against 10 acceptance tests with prioritized fixes
- **Auto-fix issues** - Apply recommended improvements automatically
- **Full codebase analysis** - Analyzes package.json, code structure, git history, and existing docs

## Installation

```bash
# Install from plugin directory
cc --plugin-dir /path/to/readme-writer

# Or copy to your plugins directory
cp -r readme-writer ~/.claude/plugins/
```

## Usage

### Generate a README

```bash
/readme-writer:generate
```

Or simply ask:
```
Create a README for this project
```

The plugin will:
1. Analyze your codebase (package.json, structure, git, configs)
2. Determine target reader and job-to-be-done
3. Generate a README following PRD-README v1 standard

### Audit an existing README

```bash
/readme-writer:audit
```

Or ask:
```
Audit my README and tell me what's missing
```

The plugin will:
1. Run 10 acceptance tests
2. Score your README (X/10)
3. Prioritize issues (P0 critical → P3 polish)
4. Offer to auto-fix applicable issues

## The PRD-README v1 Standard

### 9-Step Build Process

0. **Specify target reader and job-to-be-done**
1. **Engineer the top section** (15-30 second scan)
2. **Provide executable quickstart** (< 5 minutes to first success)
3. **Add real usage** (2-4 common workflows)
4. **Progressive disclosure** (link deep details elsewhere)
5. **Include contributor path**
6. **Add support routes**
7. **Make legal/security clear**
8. **Accessibility requirements**
9. **Prevent documentation rot**

### 10 Acceptance Tests

| # | Test | Pass Criteria |
|---|------|---------------|
| 1 | What is it? | Answer in 10 seconds |
| 2 | Maintained? | Status clear in 10 seconds |
| 3 | Quickstart | Works in ≤5 minutes |
| 4 | Runnable example | Copy/pasteable exists |
| 5 | Expected output | Success is clear |
| 6 | Navigation | Find sections in ≤10 seconds |
| 7 | License | Explicit and linked |
| 8 | Contribution | Route is clear |
| 9 | Accessibility | Headings hierarchical |
| 10 | Scope | Links to detailed docs |

## Components

| Type | Name | Description |
|------|------|-------------|
| Skill | prd-readme-standard | PRD-README v1 knowledge base |
| Command | generate | Generate README from codebase analysis |
| Command | audit | Audit README against 10 acceptance tests |
| Agent | readme-analyzer | Autonomous README analysis and generation |

## Contributing

Issues and suggestions welcome. Please file an issue describing the improvement.

## License

MIT
