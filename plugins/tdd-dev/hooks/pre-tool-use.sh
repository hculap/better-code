#!/bin/bash
# TDD PreToolUse Hook - Validates Write/Edit operations
# Exit codes: 0 = approve, 2 = block, 1 = error

# Check jq dependency - allow if not available
command -v jq >/dev/null 2>&1 || exit 0

# Read JSON input from stdin
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty' 2>/dev/null)

# If no file path, allow (might be a different tool input format)
if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Check if TDD mode is active
TDD_ACTIVE_FILE=".claude/.tdd-mode-active"
if [ ! -f "$TDD_ACTIVE_FILE" ]; then
  exit 0  # TDD not active, allow
fi

ACTIVE=$(jq -r '.active // false' "$TDD_ACTIVE_FILE" 2>/dev/null || echo "false")
if [ "$ACTIVE" != "true" ]; then
  exit 0  # TDD not active, allow
fi

# Read strictness level
STRICTNESS=$(jq -r '.strictness // "strict"' "$TDD_ACTIVE_FILE" 2>/dev/null || echo "strict")

# Check if this is a test file (allow test files always)
# Common test file patterns
if [[ "$FILE_PATH" =~ \.(test|spec)\. ]] || \
   [[ "$FILE_PATH" =~ \.stories\. ]] || \
   [[ "$FILE_PATH" =~ \.e2e\. ]] || \
   [[ "$FILE_PATH" =~ __tests__/ ]] || \
   [[ "$FILE_PATH" =~ __mocks__/ ]] || \
   [[ "$FILE_PATH" =~ /tests?/ ]] || \
   [[ "$FILE_PATH" =~ cypress/ ]] || \
   [[ "$FILE_PATH" =~ playwright/ ]] || \
   [[ "$FILE_PATH" =~ _test\. ]] || \
   [[ "$FILE_PATH" =~ test_.*\. ]] || \
   [[ "$FILE_PATH" =~ \.test$ ]] || \
   [[ "$FILE_PATH" =~ \.spec$ ]]; then
  # Update state: test file written (with portable file locking)
  STATE_FILE=".claude/.tdd-cycle-state"
  LOCK_DIR="$STATE_FILE.lock"
  if [ -f "$STATE_FILE" ]; then
    # Portable locking using mkdir (atomic on all POSIX systems, works on macOS)
    if mkdir "$LOCK_DIR" 2>/dev/null; then
      trap "rmdir '$LOCK_DIR' 2>/dev/null" EXIT
      jq --arg path "$FILE_PATH" '.testFilesWritten += [$path] | .testFilesWritten |= unique' "$STATE_FILE" > "$STATE_FILE.tmp" && mv "$STATE_FILE.tmp" "$STATE_FILE"
      rmdir "$LOCK_DIR" 2>/dev/null
      trap - EXIT
    fi
  fi
  exit 0  # Allow test file writes
fi

# Check if it's a non-source file (config, docs, etc.) - allow these
# Note: .env, .html, .css excluded as they can be source files in frontend projects
if [[ "$FILE_PATH" =~ \.(json|md|yml|yaml|toml|lock|gitignore|txt|csv|xml)$ ]] || \
   [[ "$FILE_PATH" =~ /\. ]] || \
   [[ "$FILE_PATH" =~ ^\.claude/ ]]; then
  exit 0  # Allow config/doc files
fi

# Source file - check phase
STATE_FILE=".claude/.tdd-cycle-state"
if [ ! -f "$STATE_FILE" ]; then
  if [ "$STRICTNESS" = "strict" ]; then
    echo "TDD BLOCKED: No cycle state file. Write a test first, then run tests to establish the RED phase." >&2
    exit 2  # Block
  fi
  exit 0  # Allow in non-strict modes
fi

PHASE=$(jq -r '.phase // "idle"' "$STATE_FILE" 2>/dev/null || echo "idle")

case "$PHASE" in
  "green"|"refactor")
    exit 0  # Allow source edits in GREEN/REFACTOR phase
    ;;
  "red")
    if [ "$STRICTNESS" = "strict" ]; then
      echo "TDD BLOCKED: Phase is RED. You must:" >&2
      echo "  1. Write a failing test" >&2
      echo "  2. Run the tests to confirm they fail" >&2
      echo "  3. Then implement the source code" >&2
      exit 2  # Block in strict mode
    elif [ "$STRICTNESS" = "standard" ]; then
      echo "TDD Warning: Phase is RED - no failing test confirmed yet." >&2
      exit 0  # Allow but warn in standard mode
    else
      echo "TDD Tip: Consider running your test first to confirm it fails." >&2
      exit 0  # Allow in relaxed mode
    fi
    ;;
  "idle"|*)
    if [ "$STRICTNESS" = "strict" ]; then
      echo "TDD BLOCKED: TDD cycle not started. Use /tdd-dev:feature or /tdd-dev:bug to begin." >&2
      exit 2  # Block in strict mode
    fi
    exit 0  # Allow in non-strict modes
    ;;
esac
