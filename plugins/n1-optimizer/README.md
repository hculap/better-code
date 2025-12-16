# N+1 Optimizer

A Claude Code plugin that runs 4 parallel AI agents to detect N+1 queries, inefficient APIs, and performance anti-patterns across your entire application stack.

It automatically detects your tech stack and identifies:

- **Database issues**: N+1 queries, missing indexes, inefficient JOINs, unbounded queries
- **Backend issues**: O(n²) algorithms, blocking operations, memory leaks, redundant computations
- **Frontend issues**: Unnecessary re-renders, large bundles, missing memoization, render-blocking resources
- **API issues**: Over-fetching, under-fetching, missing pagination, inefficient endpoints

Each issue is classified by impact severity (High/Medium/Low) with specific fix recommendations and file locations.

## Features

- **Parallel Analysis**: 4 specialized agents analyze your codebase simultaneously
- **Multi-Layer Coverage**: Database, Backend, Frontend, and API analysis
- **Impact-Based Severity**: Issues classified as High/Medium/Low based on performance impact
- **Fix Suggestions**: Each issue includes recommended fix approaches
- **Language Agnostic**: Auto-detects tech stack and applies appropriate patterns

## Usage

```
/n1-optimizer:analyze
```

This launches 4 parallel agents that analyze:

| Agent | Focus Areas |
|-------|-------------|
| Database Analyzer | N+1 queries, missing indexes, inefficient JOINs, query patterns |
| Backend Analyzer | Service efficiency, function complexity, business logic issues |
| Frontend Analyzer | Render performance, bundle size, component optimization |
| API Analyzer | Over-fetching, endpoint design, response optimization |

## Output Format

Results are grouped by category with issue counts:

```
## Database Issues (3 High, 2 Medium)
- [HIGH] N+1 query in UserService.getOrders() - src/services/user.ts:45
  Suggestion: Use eager loading with include/join

## API Issues (1 High, 4 Low)
- [HIGH] Over-fetching in /api/users endpoint - src/routes/users.ts:23
  Suggestion: Implement field selection or GraphQL
```

## Installation

```
/plugin marketplace add hculap/n1-optimizer
/plugin install n1-optimizer@n1-optimizer
```

### Local Development

Clone and load directly:

```bash
git clone https://github.com/hculap/n1-optimizer.git
claude --plugin-dir /path/to/n1-optimizer
```
