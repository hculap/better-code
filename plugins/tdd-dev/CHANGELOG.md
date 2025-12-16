# Changelog

All notable changes to this project will be documented in this file.

## [0.1.9] - 2025-12-12

### Fixed
- **Critical**: Hooks now properly load - added `hooks` field to `plugin.json`
- **Critical**: UserPromptSubmit hook no longer uses invalid `matcher` field
- PreToolUse hook now outputs blocking messages to stderr (per Claude Code docs)
- PostToolUse hook uses correct `tool_response` input format
- Agent tools format changed from JSON array to comma-separated string
- Exit code detection for test pass/fail with output heuristics fallback

### Added
- `user-prompt-submit.sh` - Injects TDD context for every user prompt when mode is active
- Cross-platform file locking using `mkdir` (works on macOS without `flock`)
- Additional test file patterns: `*.stories.*`, `*.e2e.*`, `cypress/`, `playwright/`, `__mocks__/`
- `jq` dependency checks in all hook scripts (graceful degradation)

### Changed
- Replaced prompt-based hooks with command-based shell scripts for reliability
- Narrowed config file allowlist (removed `.env`, `.html`, `.css` as they can be source files)
- `ExitPlanMode` tool added to tdd-developer agent

### Removed
- Stop hook (TDD enforcement now handled by PreToolUse/PostToolUse)
- Undocumented `color` field from agent definition
- Undocumented `description` field from hooks.json

## [0.1.8] - 2025-12-12

### Added
- Initial TDD plugin with Red→Green→Refactor cycle enforcement
- Slash commands: `/tdd-dev:start`, `/tdd-dev:stop`, `/tdd-dev:feature`, `/tdd-dev:bug`, `/tdd-dev:refactor`
- TDD developer agent for autonomous test-driven development
- Strictness modes: strict, standard, relaxed
