#!/bin/bash

WATCH_DIR=$(pwd)  # Automatically detects the current directory
SCRIPT_NAME=$(basename "$0")  # Get the script's filename

cd "$WATCH_DIR" || exit

while true; do
    # Check for file changes, including the script itself
    if ! git diff --quiet || ! git diff --cached --quiet || ! git ls-files --others --exclude-standard --quiet; then
        echo "Changes detected, committing..."

        # Add all changes, including the script
        git add .

        # If the script itself is modified, add a special commit message
        if git diff --name-only | grep -q "$SCRIPT_NAME"; then
            git commit -m "Auto-commit (script updated): $(date +"%Y-%m-%d %H:%M:%S")"
        else
            git commit -m "Auto-commit: $(date +"%Y-%m-%d %H:%M:%S")"
        fi

        # (Optional) Push changes
        git push origin main
    fi

    # Wait for 10 seconds before checking again
    sleep 10
done
