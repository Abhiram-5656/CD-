#!/bin/bash

# Directory to monitor
WATCH_DIR="C:\Users\HI-HP_PC\Desktop\CD-lab"

# Change to the repository directory
cd "$WATCH_DIR" || exit

# Run an infinite loop to check for changes
while true; do
    # Check for file changes using git status
    if ! git diff --quiet || ! git diff --cached --quiet || ! git ls-files --others --exclude-standard --quiet; then
        echo "Changes detected, committing..."

        # Add all changes
        git add .

        # Commit with a timestamp message
        git commit -m "Auto-commit: $(date +"%Y-%m-%d %H:%M:%S")"

        # (Optional) Push changes
        git push origin main
    fi

    # Wait for 10 seconds before checking again
    sleep 10
done
