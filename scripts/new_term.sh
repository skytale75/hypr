#!/bin/bash

SESSION_NAME="current"

# Check if the session exists, discarding output
tmux has-session -t "$SESSION_NAME" 2>/dev/null

if [ $? != 0 ]; then
    # If the session does not exist, create a new one in detached mode
    tmux new-session -d -s "$SESSION_NAME"
fi

# Open a new Kitty terminal and attach to the session
kitty -e tmux attach-session -t "$SESSION_NAME"
