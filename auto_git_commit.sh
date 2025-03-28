#!/bin/bash

WATCH_DIR=$(pwd)  # Monitor the current directory
SCRIPT_NAME=$(basename "$0")  # Get the script filename

cd "$WATCH_DIR" || exit

echo "🔄 Monitoring directory: $WATCH_DIR for changes..."

while true; do
    # Check if any file has been modified, added, or deleted
    if ! git diff --quiet || ! git diff --cached --quiet || ! git ls-files --others --exclude-standard --quiet; then
        echo "📢 Changes detected!"

        # Add all changes to the staging area
        git add .

        # Create a commit message with timestamp
        COMMIT_MESSAGE="Auto-commit: $(date +"%Y-%m-%d %H:%M:%S")"

        # Check if the script itself was modified
        if git diff --name-only | grep -q "$SCRIPT_NAME"; then
            COMMIT_MESSAGE="Auto-commit (script updated): $(date +"%Y-%m-%d %H:%M:%S")"
        fi

        # Commit the changes
        git commit -m "$COMMIT_MESSAGE"

        echo "✅ Changes automatically staged and committed to Git."
    fi

    # Wait for 10 seconds before checking again
    sleep 10
done
