# Doc Master

Comprehensive documentation toolkit for Claude Code with specialized agents for bulletproof software documentation.

## Features

- **9 Specialized Documentation Agents**: Backend, Frontend, API, Database, Architecture, Tests, User Guides, Compliance, Mobile
- **Multiple Documentation Standards**: Diátaxis (default), Traditional, or Custom
- **Documentation Audit**: Quick checklist or comprehensive report
- **Documentation Planning**: Generate structured documentation plans
- **Proactive Assistance**: Agents trigger automatically when documenting code

## Installation

```bash
claude --plugin-dir /path/to/doc-master
```

Or add to your project's `.claude-plugin/` directory.

## Quick Start

1. Run setup to configure your documentation standard:
   ```
   /doc-master:setup
   ```

2. Audit existing documentation:
   ```
   /doc-master:audit ./docs
   ```

3. Create a documentation plan:
   ```
   /doc-master:plan "user authentication feature"
   ```

4. Generate documentation:
   ```
   /doc-master:generate "payment processing module"
   ```

## Commands

| Command | Description |
|---------|-------------|
| `/doc-master:setup` | Configure documentation standard (Diátaxis, Traditional, Custom) |
| `/doc-master:audit [path]` | Audit documentation quality and coverage |
| `/doc-master:plan [scope]` | Generate documentation plan for project/feature |
| `/doc-master:generate [feature]` | Generate documentation for specific feature |

## Documentation Standards

### Diátaxis (Default)
- **Tutorials**: Learning-oriented, step-by-step lessons
- **How-to Guides**: Task-oriented, problem-solving
- **Explanations**: Understanding-oriented, background/context
- **Reference**: Information-oriented, technical descriptions

### Traditional
- Overview
- Getting Started
- API Reference
- Examples
- FAQ

### Custom
Provide your own documentation standards via:
- Local folder path with markdown files
- URL to fetch standards from web

## Configuration

Settings are stored in `.claude/doc-master.local.md`:

```yaml
---
standard: diataxis
proactive_agents: true
custom_source: null
---
```

## Agents

Agents trigger proactively when you ask to document specific areas:

- **backend-docs**: Backend services, microservices, server logic
- **frontend-docs**: UI components, state management, styling
- **api-docs**: REST/GraphQL endpoints, schemas, authentication
- **database-docs**: Schema design, migrations, queries
- **architecture-docs**: System design, diagrams, ADRs
- **test-docs**: Test strategy, coverage, test plans
- **user-guide-docs**: End-user documentation, tutorials
- **compliance-docs**: Regulatory, security, audit documentation
- **mobile-docs**: iOS/Android specific documentation

## License

MIT
