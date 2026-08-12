#!/bin/bash

REPO="/Users/suf/Developer/commit-bot"

# Wait until GitHub is reachable
while ! /usr/bin/curl -fsI --max-time 5 https://github.com >/dev/null 2>&1
do
    sleep 10
done

/bin/bash "$REPO/bot.sh"
