#!/bin/bash

# Code Standards Hook - Deterministic check for source file modifications
# Returns JSON that Claude Code interprets for continuation behavior

# Read tool result from stdin
TOOL_RESULT=$(cat)

# Extract file path from tool result
# The tool result contains the file path that was modified
FILE_PATH=$(echo "$TOOL_RESULT" | grep -oE '"file_path":\s*"[^"]+"' | sed 's/"file_path":\s*"//' | sed 's/"$//' | head -1)

# If no file path found, try alternative patterns
if [ -z "$FILE_PATH" ]; then
  FILE_PATH=$(echo "$TOOL_RESULT" | grep -oE '/[^"[:space:]]+\.(ts|tsx|js|jsx|py|go|java|rb|rs|php|swift|kt|cs|md|json|txt|yaml|yml|sh)' | head -1)
fi

# If still no file path, exit silently
if [ -z "$FILE_PATH" ]; then
  echo '{}'
  exit 0
fi

# Get file extension (lowercase)
EXT="${FILE_PATH##*.}"
EXT=$(echo "$EXT" | tr '[:upper:]' '[:lower:]')

# Check if it's a source code file
case "$EXT" in
  ts|tsx|js|jsx|py|go|java|rb|rs|php|swift|kt|cs)
    # Source file - check if code-standards is enabled
    SETTINGS_FILE=".claude/code-standards.local.md"

    if [ -f "$SETTINGS_FILE" ]; then
      # Check for active_analysis: true in YAML frontmatter
      if grep -q "active_analysis:.*true" "$SETTINGS_FILE" 2>/dev/null; then
        echo '{"systemMessage": "Consider running /code-standards:check on this file."}'
        exit 0
      fi
    fi

    # Not enabled - silent exit
    echo '{}'
    ;;
  *)
    # Not a source file - silent exit
    echo '{}'
    ;;
esac
