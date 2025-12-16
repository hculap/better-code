# Repository Guidelines

## Project Structure & Module Organization
- Root overview lives in `README.md`; plugin metadata is in `.claude-plugin/plugin.json`.
- Command entrypoints sit in `commands/` (currently `commands/analyze.md` orchestrates the four-agent run).
- Agent playbooks live under `agents/` (`*-analyzer.md` files) and define scope, tools, and prompts for each layer.
- Shared references belong in `skills/` (see `skills/performance-patterns/SKILL.md` for anti-pattern guidance).

## Build, Test, and Development Commands
- No build step is required; these Markdown definitions are consumed directly by Claude.
- Load the plugin locally with `claude --plugin-dir /path/to/n1-optimizer`.
- Validate behavior by sending `/n1-optimizer:analyze` in a session and confirming all four analyzers launch in parallel and return findings.
- Optional: run your preferred Markdown linter before submitting to catch formatting mistakes.

## Coding Style & Naming Conventions
- Use ATX headings, concise bullets, and imperative tone (“Analyze…”, “Check…”).
- Keep YAML front matter intact at the top of command/agent files; preserve keys such as `name`, `description`, `tools`, `allowed-tools`, and any examples.
- File naming patterns: `agents/<layer>-analyzer.md`, `commands/<action>.md`, `skills/<topic>/SKILL.md`. Use lowercase with hyphens for directories and files (except `SKILL.md`).
- Favor short, direct sentences tailored to performance analysis; avoid generic AI safety rails or unrelated boilerplate.

## Testing Guidelines
- After editing commands or agents, run the plugin locally and execute `/n1-optimizer:analyze`; verify that database, backend, frontend, and API analyzers all respond and that severities render correctly.
- If you add a new agent or skill, sanity-check links from the orchestrating command and ensure Markdown fences and examples render as expected.

## Commit & Pull Request Guidelines
- Git history is absent; use Conventional Commit style for clarity (e.g., `docs: add agent contributor guide`, `feat: expand frontend analyzer prompts`).
- In PRs, include: a short summary of intent, the files touched, and manual verification notes (e.g., “Ran `/n1-optimizer:analyze` locally; all agents returned results”). Link related issues if applicable.

## Agent-Specific Tips
- Keep instructions actionable and performance-focused (N+1 detection, pagination, memoization, parallelization). Avoid stylistic nitpicks unrelated to performance impact.
- When adjusting severity definitions or outputs, keep the consolidated report format in `commands/analyze.md` in sync so downstream consumers are stable.
