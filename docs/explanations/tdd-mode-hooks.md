# Understanding TDD Mode and Hook Enforcement

This explanation explores how the tdd-dev plugin enforces Test-Driven Development discipline through Claude Code's hook system. Rather than simply documenting what the plugin does, we will examine why it works the way it does and how its architectural decisions enable reliable enforcement of TDD principles.

## The Problem of Enforcing Development Discipline

Traditional TDD requires developers to follow a strict cycle: write a failing test, write minimal code to pass it, then refactor. When working with an AI coding assistant, maintaining this discipline becomes challenging because the AI might naturally generate implementation code before tests exist, or skip the "red" phase entirely by writing passing code immediately.

The tdd-dev plugin solves this problem by intercepting Claude's actions at the tool level, preventing violations before they occur rather than detecting them afterward. This approach treats TDD enforcement as a constraint on the system rather than a suggestion to the AI.

## State Management Through Flag Files

The plugin uses a simple but effective state management strategy: a flag file at `.claude/.tdd-mode-active`. When this file exists, TDD mode is active. When it does not exist, TDD mode is inactive.

This design decision offers several advantages:

1. **Persistence** - The state persists across Claude sessions, so restarting the assistant does not accidentally disable TDD enforcement
2. **Simplicity** - Any process can check the state by simply testing for file existence, requiring no inter-process communication or shared memory
3. **Escape hatch** - Users can manually create or delete the file to control TDD mode without using commands

The file contains JSON with session metadata:

```json
{
  "active": true,
  "activatedAt": "2024-01-15T10:30:00Z",
  "strictness": "strict",
  "testCommand": "npm test"
}
```

The `/tdd-dev:start` command creates this file, `/tdd-dev:stop` removes it, and each hook script reads this file to determine whether enforcement should occur.

## The Three-Hook Architecture

Claude Code's hook system allows plugins to intercept events at three critical points, and tdd-dev uses all three:

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        Claude Code Session                               │
│                                                                          │
│  User Prompt ──▶ UserPromptSubmit Hook ──▶ AI Processing                │
│                        │                         │                       │
│                        ▼                         ▼                       │
│              [Inject TDD context]        Tool Invocation                 │
│                                                  │                       │
│                                                  ▼                       │
│                                         PreToolUse Hook                  │
│                                                  │                       │
│                              ┌───────────────────┴───────────────────┐   │
│                              │                                       │   │
│                              ▼                                       ▼   │
│                      [Source file?]                          [Test file?]│
│                              │                                       │   │
│                              ▼                                       │   │
│                      Validate TDD                               Allow    │
│                      requirements                                        │
│                              │                                           │
│                              ▼                                           │
│                     PostToolUse Hook                                     │
│                              │                                           │
│                              ▼                                           │
│                     [Track phase transitions]                            │
│                                                                          │
└─────────────────────────────────────────────────────────────────────────┘
```

### UserPromptSubmit: Contextual Guidance

The first hook fires when the user submits a prompt. When TDD mode is active, the hook prepends guidance to the user's message. This guidance reminds Claude of the current TDD phase and the rules it must follow, effectively injecting the TDD methodology into every interaction without requiring the user to repeat instructions.

This approach works because Claude processes the prepended content as part of the user's message, making TDD principles a first-class concern in every response.

### PreToolUse: The Enforcement Gate

The PreToolUse hook implements the core enforcement logic. It intercepts every attempt to use the Write or Edit tools and applies the TDD rules before the action occurs.

The hook first determines whether the target file is a test file (matching patterns like `*.test.*`, `*.spec.*`, or files in `__tests__` directories) or a source file. Test files are always allowed through because writing tests is the first step in TDD.

For source files, behavior depends on strictness level:

| Strictness | PreToolUse Behavior |
|------------|---------------------|
| **strict** | Deny without failing test - blocks the write entirely |
| **standard** | Ask for confirmation - prompts user before proceeding |
| **relaxed** | Approve with coaching - allows but provides TDD guidance |

The decision to validate on every source file write ensures correctness. This prevents Claude from writing implementation code when no test demands it.

### PostToolUse: Phase Tracking

After a tool executes successfully, the PostToolUse hook records the action and tracks TDD phase transitions. When a test file is written, the plugin notes that we are in the "red" phase. When Bash runs tests, it detects results and manages transitions between Red, Green, and Refactor phases.

This tracking enables better status reporting and supports features like warnings when phases are skipped.

## Why Hook-Based Enforcement Works

The hook architecture provides enforcement that is impossible to bypass through normal interactions. Unlike prompting Claude to follow TDD (which it might forget or misinterpret), hooks operate at the tool level, below the AI's decision-making layer.

Consider the alternative approaches:

- **System prompts** can be ignored or overridden by sufficiently persuasive user messages
- **Custom commands** might be forgotten by users
- **Post-hoc auditing** catches violations too late

Hooks, by contrast, prevent violations from ever occurring. A blocked write operation never touches the filesystem.

This "impossible to violate" property transforms TDD from a guideline into a physical constraint of the development environment, similar to how type systems prevent certain classes of errors at compile time rather than runtime.

## The Command-Hook Relationship

The slash commands and hooks serve complementary roles:

- **Commands** handle state transitions and user interaction, providing a friendly interface for enabling, disabling, and checking TDD mode
- **Hooks** handle enforcement, operating automatically and invisibly once mode is active

This separation allows users to focus on their work while the hooks ensure compliance. A developer using `/tdd-dev:start` does not need to understand the hook architecture; they simply experience a development environment where TDD is the only possible workflow.

## Design Trade-offs

The plugin makes several intentional trade-offs:

| Decision | Prioritizes | Accepts |
|----------|-------------|---------|
| Flag file state | Simplicity, persistence | Manual intervention possible |
| Test pattern matching | Convention | May need configuration for edge cases |
| Strictness levels | Flexibility | Complexity of multiple modes |

These choices reflect a philosophy of making the common case simple and reliable, while accepting that edge cases may require manual intervention (like adjusting patterns in configuration).

## See Also

- [tdd-dev Command Reference](../reference/tdd-dev-commands.md)
- [How to Customize TDD Strictness](../how-to/tdd-strictness.md)
- [Configuration Reference](../reference/configuration.md)
