# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

N1-Optimizer is a Claude Code plugin that performs parallel performance analysis to identify N+1 queries, inefficient APIs, and suboptimal code patterns across application stacks. It runs 4 specialized agents concurrently to analyze different layers.

## Plugin Usage

Load the plugin locally:
```bash
claude --plugin-dir /path/to/n1-optimizer
```

Run analysis:
```
/n1-optimizer:analyze
```

Validate changes by running the analyze command and confirming all 4 agents (database, backend, frontend, API) launch in parallel and return findings.

## Architecture

```
.claude-plugin/plugin.json    # Plugin metadata
commands/analyze.md           # Main orchestrator - launches 4 parallel agents
agents/
  database-analyzer.md        # N+1 queries, missing indexes, ORM issues
  backend-analyzer.md         # Algorithm complexity, blocking ops, memory
  frontend-analyzer.md        # Re-renders, bundle size, state patterns
  api-analyzer.md             # Over/under-fetching, pagination, caching
skills/performance-patterns/
  SKILL.md                    # Anti-pattern reference guide
```

The `analyze.md` command orchestrates the analysis by:
1. Detecting the target codebase's tech stack
2. Launching all 4 agents IN PARALLEL (single message, multiple Task calls)
3. Waiting for completion via TaskOutput
4. Consolidating results into a severity-grouped report

## File Conventions

- Agent files: `agents/<layer>-analyzer.md` with YAML frontmatter (name, description, tools, model, color)
- Command files: `commands/<action>.md` with YAML frontmatter (description, allowed-tools)
- Skill files: `skills/<topic>/SKILL.md` with YAML frontmatter (name, description, version)
- Use lowercase with hyphens for directories/files (except SKILL.md)
- Keep YAML frontmatter intact when editing

## Severity Classification

- **HIGH**: N+1 queries, O(n²) algorithms, unbounded queries, memory leaks
- **MEDIUM**: Missing eager loading, sequential awaits, minor over-fetching
- **LOW**: Style issues, optional optimizations

## Writing Guidelines

- Use ATX headings, concise bullets, imperative tone
- Focus on actionable performance guidance, not stylistic nitpicks
- Include code examples in suggestions when applicable
- Keep output format consistent: `[SEVERITY] Issue Title` with Location, Pattern, Problem, Suggestion
