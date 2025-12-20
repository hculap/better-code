# better-code

Claude Code plugins that enforce code quality practices: TDD workflows, performance analysis, and documentation standards.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)
![Status: Active](https://img.shields.io/badge/Status-Active-brightgreen)

**Status:** Active | [Documentation](docs/) | [Issues](https://github.com/hculap/better-code/issues) | [Changelog](https://github.com/hculap/better-code/commits/main)

## What's Included

| Plugin | Version | Purpose |
|--------|---------|---------|
| **tdd-dev** | 0.2.1 | Enforce Red→Green→Refactor TDD cycles |
| **n1-optimizer** | 0.1.3 | Detect N+1 queries and performance issues |
| **readme-writer** | 0.1.0 | Generate/audit READMEs with PRD-README v1 |
| **doc-master** | 0.2.1 | 9 specialized documentation agents |

## Quick Start

**Prerequisites:** Claude Code CLI installed

**Step 1: Add the marketplace**
```bash
/plugin marketplace add hculap/better-code
```

Output:
```
Successfully added marketplace: better-code
```

**Step 2: Install a plugin**
```bash
/plugin install tdd-dev
```

Output:
```
Installed plugin: tdd-dev
```

**Step 3: Use the plugin**
```bash
/tdd-dev:start
```

Output:
```
TDD Dev Mode: ACTIVE

Configuration:
  Strictness: strict
  Test Command: npm test
```

That's it! You're now coding with TDD enforcement.

## Usage

### tdd-dev: Test-Driven Development

Enforces writing tests before implementation code.

```bash
/tdd-dev:start              # Enable TDD mode
/tdd-dev:feature "add auth" # Implement feature with TDD
/tdd-dev:bug "fix #123"     # Fix bug with regression test first
/tdd-dev:refactor           # Safe refactoring verified by tests
/tdd-dev:stop               # Disable TDD mode
```

**Strictness levels:** `strict` (tests required), `standard` (tests encouraged), `relaxed` (minimal enforcement)

### n1-optimizer: Performance Analysis

Runs 4 parallel agents to analyze your codebase for performance issues.

```bash
/n1-optimizer:analyze
```

Output:
```
Analysis Complete

Database Layer: 3 issues found
  HIGH: N+1 query in UserService.getOrders() - src/services/user.ts:45

Backend Layer: 1 issue found
  MEDIUM: Sequential awaits could be parallelized - src/api/reports.ts:23

Frontend Layer: 2 issues found
  HIGH: Missing React.memo on ExpensiveList - src/components/List.tsx:12

API Layer: 1 issue found
  MEDIUM: Missing pagination on /api/products - src/routes/products.ts:8
```

| Agent | Detects |
|-------|---------|
| Database | N+1 queries, missing indexes, unbatched writes |
| Backend | O(n²) algorithms, blocking I/O, memory issues |
| Frontend | Re-render loops, large bundles, missing memoization |
| API | Over-fetching, missing pagination, chatty endpoints |

### readme-writer: README Generation

Generate or audit READMEs following the PRD-README v1 standard.

```bash
/readme-writer:generate      # Generate README from codebase analysis
/readme-writer:audit         # Score existing README (0-10)
```

Audit output:
```
README Audit Score: 7/10

✓ Test 1: What is it? - PASS
✓ Test 2: Is it maintained? - PASS
✗ Test 3: Quickstart works - FAIL (missing expected output)
...
```

### doc-master: Documentation Toolkit

9 specialized agents for comprehensive documentation.

```bash
/doc-master:setup            # Choose framework (Diátaxis/Traditional/Custom)
/doc-master:generate "API"   # Generate API documentation
/doc-master:audit            # Audit existing docs
/doc-master:plan             # Create documentation plan
```

| Agent | Focus |
|-------|-------|
| api-docs | REST/GraphQL endpoints, schemas |
| backend-docs | Services, data flows, deployment |
| frontend-docs | Components, state management |
| database-docs | Schema, migrations, ER diagrams |
| architecture-docs | System design, ADRs |
| test-docs | Test strategy, coverage |
| user-guide-docs | Tutorials, help articles |
| compliance-docs | Security, audit, regulatory |
| mobile-docs | iOS/Android, app stores |

## Documentation

Full documentation available in [docs/](docs/):

- [Getting Started Tutorial](docs/tutorials/getting-started.md)
- [Configuration Reference](docs/reference/configuration.md)
- [TDD Commands Reference](docs/reference/tdd-dev-commands.md)
- [Performance Patterns Reference](docs/reference/n1-optimizer-patterns.md)

## Contributing

Contributions welcome! Please [open an issue](https://github.com/hculap/better-code/issues/new) first to discuss proposed changes.

**Quick steps:**
1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Open a pull request

See individual plugin READMEs for plugin-specific guidance.

## Support

- **Questions:** [Open a discussion](https://github.com/hculap/better-code/discussions)
- **Bugs:** [File an issue](https://github.com/hculap/better-code/issues/new?template=bug_report.md)
- **Feature requests:** [File an issue](https://github.com/hculap/better-code/issues/new?template=feature_request.md)

When reporting bugs, include:
- Plugin name and version
- Claude Code version
- Steps to reproduce
- Expected vs actual behavior

## Security

To report security vulnerabilities, please email the maintainer directly rather than opening a public issue.

## License

MIT License - see [LICENSE](LICENSE) for details.

Copyright (c) 2024 Szymon Paluch
