#!/bin/bash
# TDD UserPromptSubmit Hook - Injects TDD context when mode is active
# Exit codes: 0 = allow (always), output JSON to add context

# Check jq dependency - allow if not available
command -v jq >/dev/null 2>&1 || exit 0

# Check if TDD mode is active
TDD_ACTIVE_FILE=".claude/.tdd-mode-active"
if [ ! -f "$TDD_ACTIVE_FILE" ]; then
  exit 0  # TDD not active, no context needed
fi

ACTIVE=$(jq -r '.active // false' "$TDD_ACTIVE_FILE" 2>/dev/null || echo "false")
if [ "$ACTIVE" != "true" ]; then
  exit 0  # TDD not active
fi

# Read current TDD state
STRICTNESS=$(jq -r '.strictness // "strict"' "$TDD_ACTIVE_FILE" 2>/dev/null || echo "strict")

STATE_FILE=".claude/.tdd-cycle-state"
if [ -f "$STATE_FILE" ]; then
  PHASE=$(jq -r '.phase // "red"' "$STATE_FILE" 2>/dev/null || echo "red")
else
  PHASE="red"
fi

# Output context for Claude per docs format
cat << EOF
{
  "hookSpecificOutput": {
    "hookEventName": "UserPromptSubmit",
    "additionalContext": "TDD MODE ACTIVE (strictness: $STRICTNESS, phase: $PHASE). For ANY coding request, you MUST use the tdd-developer agent. Write tests BEFORE implementation. Current TDD phase is $PHASE."
  }
}
EOF
exit 0
