#!/bin/bash
#
# SESSION_NAME="current"
#
# # Check if the session exists, discarding output
# tmux has-session -t "$SESSION_NAME" 2>/dev/null
#
# if [ $? != 0 ]; then
#     # If the session does not exist, create a new one in detached mode
#     tmux new-session -d -s "$SESSION_NAME"
# fi
#
# # Open a new Kitty terminal and attach to the session
# kitty -e tmux attach-session -t "$SESSION_NAME"

SESSION_NAME="current"

# Check if the "current" tmux session already exists
tmux has-session -t "$SESSION_NAME" 2>/dev/null

if [ $? -eq 0 ]; then
    # Session exists, attach to it in a new kitty window
    kitty --single-instance -e tmux attach-session -t "$SESSION_NAME"
else
    # No "current" session found, create a new one and attach to it
    kitty --single-instance -e tmux new-session -s "$SESSION_NAME"
fi
