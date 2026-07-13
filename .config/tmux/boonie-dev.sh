#!/bin/bash

# Check if we're inside a tmux session
if [ -n "$TMUX" ]; then
    # Kill current session and detach
    tmux kill-session -t "$(tmux display-message -p '#S')"
fi

# Check if boonie session already exists
if tmux has-session -t boonie 2>/dev/null; then
    # Kill existing boonie session
    tmux kill-session -t boonie
fi

# Create new session named 'boonie' with first window 'serve'
tmux new-session -d -s boonie -n serve

# Split the serve window vertically
tmux split-window -h -t boonie:serve

# Set up left pane - navigate to web directory and run dev server
tmux send-keys -t boonie:serve.1 'cd ~/Dev/boonie-web && bun run dev' C-m

# Set up right pane - navigate to backend directory and run make
tmux send-keys -t boonie:serve.2 'cd ~/Dev/boonie && make run' C-m

# Create additional windows
tmux new-window -t boonie -n web
tmux new-window -t boonie -n backend
tmux new-window -t boonie -n zsh

# Navigate to project directories in additional windows
tmux send-keys -t boonie:web 'cd ~/Dev/boonie-web' C-m
tmux send-keys -t boonie:backend 'cd ~/Dev/boonie' C-m

# Select the first window (serve)
tmux select-window -t boonie:serve

# Attach to the session
tmux attach-session -t boonie