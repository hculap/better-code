# better-code

A curated collection of Claude Code plugins focused on code quality and developer productivity.

## Installation

```
/plugin marketplace add hculap/better-code
```

Then install the plugins you want:

```
/plugin install better-code@tdd-dev
/plugin install better-code@n1-optimizer
```

## Plugins

### tdd-dev

Transform Claude Code into a strict TDD practitioner that enforces Red→Green→Refactor cycles.

**Features:**
- Enforces writing tests before implementation
- Tracks TDD cycle state (Red/Green/Refactor)
- Provides TDD-specific commands and workflows

**Usage:**
```
/tdd-dev:start           # Enable TDD mode
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
```
/n1-optimizer:analyze    # Run full performance analysis
```

**Analysis Layers:**
| Agent | Focus |
|-------|-------|
| Database | N+1 queries, missing indexes, inefficient JOINs |
| Backend | Algorithm complexity, blocking ops, memory leaks |
| Frontend | Re-renders, bundle size, state management |
| API | Over-fetching, pagination, endpoint design |

## License

MIT
