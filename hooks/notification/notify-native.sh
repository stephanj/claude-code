#!/bin/bash
# Native OS Notification Hook
# Sends a native desktop notification when Claude Code needs your attention.
#
# Setup in ~/.claude/settings.json:
# {
#   "hooks": {
#     "Notification": [
#       {
#         "matcher": "",
#         "hooks": [
#           {
#             "type": "command",
#             "command": "osascript -e 'display notification \"Claude Code needs your attention\" with title \"Claude Code\"'"
#           }
#         ]
#       }
#     ]
#   }
# }
#
# Linux users: Replace the osascript command with:
#   "command": "notify-send 'Claude Code' 'Claude Code needs your attention'"
#
# This hook triggers on any notification event (empty matcher matches all).
# You can customize the matcher to filter specific notification types:
#   - "permission_prompt" - Claude needs permission to run a tool
#   - "idle_prompt" - Claude is waiting for input
#   - "elicitation_dialog" - Claude is asking a question via MCP

# macOS notification
osascript -e 'display notification "Claude Code needs your attention" with title "Claude Code"'
