#!/bin/bash
#
# Claude Code Hook: Replace rm with mv /tmp
# ==========================================
# This hook intercepts 'rm' commands and transforms them to 'mv <files> /tmp/'
# providing a safety net against accidental file deletion.
#
# BLOCKED COMMANDS: Dangerous commands like 'rm -rf /*', 'rm -rf /', and 'rm -rf ~'
# are blocked entirely and will not be executed.
#
# Requires: jq

# Read JSON input from stdin
INPUT=$(cat)

# Extract tool name and command
TOOL_NAME=$(echo "$INPUT" | jq -r '.tool_name // ""')

# Only process Bash tool
if [[ "$TOOL_NAME" != "Bash" ]]; then
    exit 0
fi

COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // ""')

# Check if empty
if [[ -z "$COMMAND" ]]; then
    exit 0
fi

# Check if it's an rm command (starts with rm, possibly with leading whitespace)
if [[ "$COMMAND" =~ ^[[:space:]]*(rm[[:space:]]) ]]; then
    # Block extremely dangerous rm commands that should never be executed
    # Matches: rm -rf /*, rm -rf /, rm -rf ~, and variations with different flag orders
    if [[ "$COMMAND" =~ rm[[:space:]]+(-[rfivRI]+[[:space:]]+)*(/\*|/[[:space:]]|~) ]] || \
       [[ "$COMMAND" =~ rm[[:space:]]+-[^[:space:]]*[rf][^[:space:]]*[[:space:]]+(/\*|/[[:space:]]|~) ]]; then
        jq -n \
            --arg reason "BLOCKED: Dangerous rm command detected. Refusing to execute commands that could delete system or home directory." \
            '{
                hookSpecificOutput: {
                    hookEventName: "PreToolUse",
                    permissionDecision: "block",
                    reason: $reason
                }
            }'
        exit 0
    fi
    # Create timestamped trash directory
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    TRASH_DIR="/tmp/rm_trash_${TIMESTAMP}"

    # Extract the files part (everything after rm and its flags)
    # Remove 'rm' and common flags like -r, -f, -rf, -i, -v, etc.
    FILES=$(echo "$COMMAND" | sed -E 's/^[[:space:]]*rm[[:space:]]+(-[rfivRI]+[[:space:]]+|--[a-z-]+[[:space:]]+)*//')

    # Build the new command
    NEW_COMMAND="mkdir -p ${TRASH_DIR} && mv ${FILES} ${TRASH_DIR}/"

    # Output using hookSpecificOutput with updatedInput (correct Claude Code format)
    jq -n \
        --arg cmd "$NEW_COMMAND" \
        '{
            hookSpecificOutput: {
                hookEventName: "PreToolUse",
                permissionDecision: "allow",
                updatedInput: {
                    command: $cmd
                }
            }
        }'
    exit 0
fi

# No transformation needed
exit 0
