# Repository Guidelines

## Project Structure & Modules
- `agents/` – Claude agent definitions (e.g. `tdd-developer.md`).
- `commands/` – slash-command specs such as `feature`, `bug`, `start`, `stop`.
- `hooks/` – hook configuration (e.g. `hooks.json`) that enforces TDD behavior.
- `skills/` – reusable skill docs and references (TDD methodology, examples).
- `scripts/` – helper utilities like `parse-settings.sh` for settings parsing.
- Root files: `README.md` (user-facing docs), `package.json` (metadata only).

## Build, Test, and Development
- There is no build step; the plugin is loaded directly from this directory by Claude Code.
- For local development, run:  
  - `claude --plugin-dir .` – start Claude with this plugin loaded.
- To validate settings parsing:  
  - `bash scripts/parse-settings.sh` – test parsing of `tdd-dev.local.md` content.

## Coding Style & Naming
- Use Markdown for agents, commands, and skills with YAML frontmatter at the top.
- Prefer kebab-case filenames for new commands/agents/skills (e.g. `new-feature.md`).
- Indent YAML and JSON with 2 spaces; keep keys lowercase with hyphen-separated words.
- Keep sections short and scannable; use descriptive headings and bullet lists.

## Testing Guidelines
- This repo has no formal automated test suite; behavior is tested by running Claude with this plugin and exercising commands (`/tdd-dev:start`, `/tdd-dev:feature`, etc.).
- When documenting examples, favor Jest/Vitest and Pytest flows consistent with `skills/tdd-methodology/examples/`.
- For changes that affect hooks or TDD rules, describe an explicit RED→GREEN→REFACTOR scenario in the PR description.

## Commit & Pull Request Guidelines
- Write clear, present-tense commit messages (e.g. `add refactor command docs`, `update tdd-developer workflow`).
- Scope each PR to a small, coherent change: one feature, refactor, or documentation update.
- In PR descriptions, include: purpose, key files touched, any new commands/settings, and how you manually tested with `claude --plugin-dir .`.
- Link related GitHub issues when applicable and mention any follow-up work explicitly.

## Agent-Specific Instructions
- Do not loosen TDD guarantees: no behavior-changing workflow should bypass a failing test in the target project.
- When editing agent or command text, keep guidance concise, opinionated, and strictly aligned with the RED→GREEN→REFACTOR cycle.
