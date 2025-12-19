# better-code

A curated collection of Claude Code plugins focused on code quality and developer productivity.

Status: active | [GitHub](https://github.com/hculap/better-code) | [Issues](https://github.com/hculap/better-code/issues)

## Installation

```bash
/plugin marketplace add hculap/better-code
```

You should see:
```
Successfully added marketplace: better-code
```

Then install the plugins you want:

```bash
/plugin install tdd-dev
```

You should see:
```
Installed plugin: tdd-dev
```

Other available plugins:
```bash
/plugin install n1-optimizer
/plugin install readme-writer
/plugin install doc-master
```

## Plugins

### tdd-dev

Transform Claude Code into a strict TDD practitioner that enforces Red→Green→Refactor cycles.

**Features:**
- Enforces writing tests before implementation
- Tracks TDD cycle state (Red/Green/Refactor)
- Provides TDD-specific commands and workflows

**Usage:**
```bash
/tdd-dev:start           # Enable TDD mode
```

Output:
```
TDD Dev Mode: ACTIVE

Configuration:
  Strictness: strict
  Test Command: npm test
```

Other commands:
```bash
/tdd-dev:feature "..."   # Implement feature with TDD
/tdd-dev:bug "..."       # Fix bug with regression test first
/tdd-dev:refactor "..."  # Safe refactoring with test coverage
```

### n1-optimizer

Parallel performance analysis tool that identifies N+1 queries, inefficient APIs, and suboptimal code patterns.

**Features:**
- 4 parallel agents analyze different layers simultaneously
- Detects N+1 queries, O(n²) algorithms, over-fetching
- Auto-detects tech stack and applies appropriate patterns

**Usage:**
```bash
/n1-optimizer:analyze    # Run full performance analysis
```

**Analysis Layers:**
| Agent | Focus |
|-------|-------|
| Database | N+1 queries, missing indexes, inefficient JOINs |
| Backend | Algorithm complexity, blocking ops, memory leaks |
| Frontend | Re-renders, bundle size, state management |
| API | Over-fetching, pagination, endpoint design |

### readme-writer

Generate and audit perfect READMEs using the PRD-README v1 standard.

**Features:**
- Auto-detect project context from codebase analysis
- 9-step README generation process
- 10-point audit with scoring and auto-fix

**Usage:**
```bash
/readme-writer:generate  # Generate README from codebase
/readme-writer:audit     # Audit existing README (score X/10)
```

### doc-master

Comprehensive documentation toolkit with 9 specialized agents for bulletproof software documentation.

**Features:**
- 9 domain-specific documentation agents (API, backend, frontend, database, architecture, tests, user guides, compliance, mobile)
- Supports Diátaxis, Traditional, or Custom documentation frameworks
- Generate and audit documentation for any codebase component

**Usage:**
```bash
/doc-master:setup              # Configure documentation standard
/doc-master:generate "feature" # Generate docs for a feature
/doc-master:audit              # Audit existing documentation
/doc-master:plan               # Create documentation plan
```

**Specialized Agents:**
| Agent | Focus |
|-------|-------|
| api-docs | REST/GraphQL endpoints, schemas, auth |
| backend-docs | Services, data flows, deployment |
| frontend-docs | Components, state, accessibility |
| database-docs | Schema, migrations, queries |
| architecture-docs | System design, ADRs, diagrams |
| test-docs | Test strategy, coverage, plans |
| user-guide-docs | End-user tutorials, help articles |
| compliance-docs | Security, audit, regulatory |
| mobile-docs | iOS/Android, app store requirements |

## Contributing

Issues and pull requests welcome. Please file an issue first to discuss proposed changes.

## License

MIT - see [LICENSE](LICENSE)
