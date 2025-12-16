#!/bin/bash
# parse-settings.sh - Extract settings from tdd-dev.local.md
#
# Usage: parse-settings.sh <setting-name> [project-dir]
#
# Examples:
#   parse-settings.sh testCommand
#   parse-settings.sh strictness /path/to/project
#
# Settings file format (.claude/tdd-dev.local.md):
#   ---
#   testCommand: npm test
#   strictness: strict
#   maxIterations: 5
#   ---

set -euo pipefail

SETTING_NAME="${1:-}"
PROJECT_DIR="${2:-${CLAUDE_PROJECT_DIR:-$(pwd)}}"

if [ -z "$SETTING_NAME" ]; then
    echo "Usage: parse-settings.sh <setting-name> [project-dir]" >&2
    exit 1
fi

# Check project settings first, then global
PROJECT_SETTINGS="$PROJECT_DIR/.claude/tdd-dev.local.md"
GLOBAL_SETTINGS="$HOME/.claude/tdd-dev.local.md"

# Function to extract setting from file
extract_setting() {
    local file="$1"
    local setting="$2"

    if [ ! -f "$file" ]; then
        return 1
    fi

    # Extract YAML frontmatter and find setting
    # Handles both "setting: value" and "setting:" followed by list items
    awk -v setting="$setting" '
        BEGIN { in_frontmatter=0; found=0 }
        /^---$/ {
            if (in_frontmatter) exit
            in_frontmatter=1
            next
        }
        in_frontmatter && $0 ~ "^"setting":" {
            found=1
            # Handle inline value
            sub("^"setting":[ ]*", "")
            if ($0 != "") {
                print $0
            }
            next
        }
        in_frontmatter && found && /^  - / {
            # Handle list items
            sub("^  - ", "")
            print
            next
        }
        in_frontmatter && found && /^[^ ]/ && !/^  - / {
            exit
        }
    ' "$file"
}

# Try project settings first
value=$(extract_setting "$PROJECT_SETTINGS" "$SETTING_NAME" || true)

# If not found in project, try global
if [ -z "$value" ] && [ -f "$GLOBAL_SETTINGS" ]; then
    value=$(extract_setting "$GLOBAL_SETTINGS" "$SETTING_NAME")
fi

# Output value if found
if [ -n "$value" ]; then
    echo "$value"
    exit 0
else
    exit 1
fi
