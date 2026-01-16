# Code Standards Plugin

Enforce practical code quality standards with concrete "rules of thumb" - actionable thresholds rather than philosophy.

## Features

- **Size Limits**: File LOC, function length, cyclomatic complexity thresholds
- **Best Practices**: KISS, DRY, YAGNI, SRP enforcement
- **Language-Aware**: Tailored thresholds for TypeScript, Python, Go, Java, Ruby, and more
- **Active Analysis**: Optional proactive checking after every edit
- **Review Checklist**: Quick validation checklist for code reviews

## Installation

```bash
/plugin marketplace add hculap/better-code
/plugin install code-standards
```

## Commands

| Command | Description |
|---------|-------------|
| `/code-standards:init` | Interactive setup wizard |
| `/code-standards:check [path]` | Analyze files against thresholds |
| `/code-standards:checklist` | Output review checklist for copy/paste |
| `/code-standards:config` | View/edit current settings |
| `/code-standards:fix [path]` | Auto-refactor to fix violations |

## Quick Start

1. Run `/code-standards:init` to configure the plugin
2. Choose your languages and threshold strictness level
3. Enable active analysis for proactive checking (optional)
4. Use `/code-standards:check` for on-demand analysis

## Configuration

Settings are stored in `.claude/code-standards.local.md`:

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
```

### Threshold Levels

> **Note:** These are the soft limit (warning) values for each strictness level. Hard limits are 2x the soft limits.

| Level | File LOC | Function LOC | Complexity |
|-------|----------|--------------|------------|
| Relaxed | 600 | 80 | 20 |
| Standard | 400 | 50 | 15 |
| Strict | 250 | 30 | 10 |

## Troubleshooting

### Active analysis not triggering

1. Verify settings file exists: `.claude/code-standards.local.md`
2. Check that `active_analysis: true` is set in YAML frontmatter
3. Ensure the modified file has a recognized source code extension

### Invalid YAML warning

Run `/code-standards:init --reconfigure` to regenerate the settings file with valid YAML.

### Thresholds seem wrong for my language

The plugin uses language-specific thresholds. Check the skill reference for per-language details, or customize thresholds in your settings file.

## License

MIT
