#!/bin/bash
# TDD PostToolUse Hook - Detects test runs and updates cycle state
# Exit codes: 0 = always (PostToolUse cannot block)

# Check jq dependency - allow if not available
command -v jq >/dev/null 2>&1 || exit 0

# Read JSON input from stdin
INPUT=$(cat)

# Parse input - per Claude Code docs, PostToolUse receives:
# { "tool_name": "...", "tool_input": {...}, "tool_response": {...}, "tool_use_id": "..." }
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // empty' 2>/dev/null)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty' 2>/dev/null)

# tool_response for Bash contains the output - try multiple formats
# Format 1: Direct string response
TOOL_RESPONSE=$(echo "$INPUT" | jq -r '.tool_response // empty' 2>/dev/null)

# Format 2: If tool_response is an object, try to get stdout/output fields
if [ -z "$TOOL_RESPONSE" ] || [ "$TOOL_RESPONSE" = "null" ]; then
  TOOL_RESPONSE=$(echo "$INPUT" | jq -r '.tool_response.stdout // .tool_response.output // .tool_response.content // empty' 2>/dev/null)
fi

# Format 3: Try to stringify the entire tool_response if it's an object
if [ -z "$TOOL_RESPONSE" ] || [ "$TOOL_RESPONSE" = "null" ]; then
  TOOL_RESPONSE=$(echo "$INPUT" | jq -r 'if .tool_response | type == "object" then (.tool_response | tostring) else empty end' 2>/dev/null)
fi

# Extract exit code from tool_response (Bash tool includes exit status)
# Try multiple field names: exitCode, exit_code, code
EXIT_CODE=$(echo "$INPUT" | jq -r '.tool_response.exitCode // .tool_response.exit_code // .tool_response.code // empty' 2>/dev/null)

# Check if TDD mode is active
TDD_ACTIVE_FILE=".claude/.tdd-mode-active"
if [ ! -f "$TDD_ACTIVE_FILE" ]; then
  exit 0  # TDD not active
fi

ACTIVE=$(jq -r '.active // false' "$TDD_ACTIVE_FILE" 2>/dev/null || echo "false")
if [ "$ACTIVE" != "true" ]; then
  exit 0  # TDD not active
fi

# Only process Bash tool
if [ "$TOOL_NAME" != "Bash" ]; then
  exit 0
fi

# Check if this looks like a test command
# Common test runners
if ! [[ "$COMMAND" =~ (npm[[:space:]]+(run[[:space:]]+)?test|npx[[:space:]]+(jest|vitest|mocha)|yarn[[:space:]]+(run[[:space:]]+)?test|pnpm[[:space:]]+(run[[:space:]]+)?test|pytest|py\.test|python[[:space:]]+-m[[:space:]]+pytest|go[[:space:]]+test|cargo[[:space:]]+test|mix[[:space:]]+test|bundle[[:space:]]+exec[[:space:]]+rspec|rspec|rake[[:space:]]+(test|spec)|phpunit|dotnet[[:space:]]+test|mvn[[:space:]]+(test|verify)|gradle[[:space:]]+test) ]]; then
  exit 0  # Not a test command
fi

STATE_FILE=".claude/.tdd-cycle-state"
LOCK_DIR="$STATE_FILE.lock"

# Helper function for atomic state file updates with portable locking
# Uses mkdir (atomic on all POSIX systems, works on macOS)
update_state() {
  local jq_filter="$1"
  local i=0
  # Try to acquire lock with timeout
  while ! mkdir "$LOCK_DIR" 2>/dev/null; do
    sleep 0.1
    i=$((i + 1))
    if [ $i -ge 50 ]; then  # 5 second timeout
      return 1
    fi
  done
  jq "$jq_filter" "$STATE_FILE" > "$STATE_FILE.tmp" && mv "$STATE_FILE.tmp" "$STATE_FILE"
  rmdir "$LOCK_DIR" 2>/dev/null
}

if [ ! -f "$STATE_FILE" ]; then
  # Create initial state if it doesn't exist
  echo '{"phase":"red","testFilesWritten":[],"testsRan":false,"testsFailed":false}' > "$STATE_FILE"
fi

CURRENT_PHASE=$(jq -r '.phase // "red"' "$STATE_FILE" 2>/dev/null || echo "red")

# Determine if tests passed or failed
# Primary: Use exit code (non-zero = failure)
# Fallback: Output heuristics (for cases where exit code is unavailable)
TESTS_FAILED=false

# Primary check: Exit code from Bash tool
if [ -n "$EXIT_CODE" ] && [ "$EXIT_CODE" != "null" ] && [ "$EXIT_CODE" != "0" ]; then
  TESTS_FAILED=true
elif [ -n "$EXIT_CODE" ] && [ "$EXIT_CODE" = "0" ]; then
  TESTS_FAILED=false
else
  # Fallback: Output heuristics when exit code is unavailable
  # Check for failure patterns in tool_response
  if echo "$TOOL_RESPONSE" | grep -qiE "(FAIL[[:space:]]|FAILED|✗|✘|AssertionError|expect.*received|Expected.*Received|[1-9][0-9]* (failed|failures)|error:|Error:|not ok)"; then
    TESTS_FAILED=true
  fi

  # Check for explicit pass signals that override
  if echo "$TOOL_RESPONSE" | grep -qiE "(All tests passed|0 failures|0 failed|Tests:[[:space:]]+[0-9]+[[:space:]]+passed,[[:space:]]+0[[:space:]]+failed)"; then
    # Only if no clear failure indicators
    if ! echo "$TOOL_RESPONSE" | grep -qE "^[[:space:]]*(FAIL|FAILED)[[:space:]]"; then
      TESTS_FAILED=false
    fi
  fi
fi

# Update state with locking
update_state ".testsRan = true | .testsFailed = $TESTS_FAILED"

# Phase transitions and output proper JSON with additionalContext
CONTEXT_MSG=""
if [ "$CURRENT_PHASE" = "red" ] && [ "$TESTS_FAILED" = "true" ]; then
  update_state '.phase = "green"'
  CONTEXT_MSG="TDD Phase: RED → GREEN. Tests failed as expected. You can now implement the minimal code to make them pass."
elif [ "$CURRENT_PHASE" = "green" ] && [ "$TESTS_FAILED" = "false" ]; then
  update_state '.phase = "refactor"'
  CONTEXT_MSG="TDD Phase: GREEN → REFACTOR. Tests passed! You can now optionally refactor while keeping tests green."
elif [ "$CURRENT_PHASE" = "green" ] && [ "$TESTS_FAILED" = "true" ]; then
  CONTEXT_MSG="TDD Phase: GREEN (tests still failing). Keep implementing until tests pass."
elif [ "$CURRENT_PHASE" = "refactor" ] && [ "$TESTS_FAILED" = "true" ]; then
  update_state '.phase = "green"'
  CONTEXT_MSG="TDD Phase: REFACTOR → GREEN (regression!). Refactoring broke tests. Fix them before continuing."
fi

# Output JSON with additionalContext per Claude Code docs
if [ -n "$CONTEXT_MSG" ]; then
  cat << EOF
{
  "hookSpecificOutput": {
    "hookEventName": "PostToolUse",
    "additionalContext": "$CONTEXT_MSG"
  }
}
EOF
fi

exit 0
