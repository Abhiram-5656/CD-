#!/bin/bash

WATCH_DIR="C:\Users\HI-HP_PC\Desktop\CD-lab"
cd "$WATCH_DIR" || exit

while inotifywait -r -e modify,create,delete .; do
    echo "File change detected, committing..."
    git add .
    git commit -m "Auto-commit: $(date +"%Y-%m-%d %H:%M:%S")"
    git push origin main
done
