#!/usr/bin/env bash

cd "$(dirname "$0")" || exit 1

hour=$(date +%H)

# Only commit between 9 AM and 2 AM
if [ "$hour" -ge 2 ] && [ "$hour" -lt 9 ]; then
    exit 0
fi

today=$(date +"%Y-%m-%d")

# Already committed today?
if grep -q "$today" output.txt 2>/dev/null; then
    exit 0
fi

info="Commit: $(date)"
branch=$(git rev-parse --abbrev-ref HEAD)

echo "$info" >> output.txt

git add output.txt

if ! git commit -m "$info"; then
    exit 1
fi

if ! git push origin "$branch"; then
    echo "Git push failed. Will retry on the next run."
    git reset --soft HEAD~1
    git restore --staged output.txt
    sed -i '' '$d' output.txt
    exit 1
fi

echo "Commit successfully pushed to GitHub."
