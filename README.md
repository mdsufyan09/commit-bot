# GitHub Commit Bot (macOS)

A lightweight GitHub commit bot for macOS that automatically creates **one commit per day** while I am logged into my Mac.

This setup is based on the original Commit Bot project but modified for native macOS usage, including network handling and hourly LaunchAgent scheduling.

---

# Features

- Native macOS (LaunchAgent)
- No cron
- No SleepWatcher
- No Accessibility/Input Monitoring permissions
- Lightweight hourly checks
- One commit per day
- Automatically pushes to GitHub
- Starts automatically after login
- Waits for GitHub/network availability before running
- Works on Intel Macs and Apple Silicon Macs

---

# How it works

When I log into macOS:

LaunchAgent
↓
run.sh
↓
Checks if GitHub is reachable
↓
If network is unavailable → Wait and retry
↓
bot.sh
↓
Checks if today's commit already exists
↓
If YES → Exit
If NO  → Commit + Push

The LaunchAgent checks once every **1 hour** while the user is logged in.

The bot itself only creates **one commit per calendar day**.

The bot only commits between **9:00 AM and 2:00 AM**.

---

# Installation

## 1. Create a development folder

    mkdir -p ~/Developer
    cd ~/Developer

---

## 2. Clone the repository

    git clone https://github.com/mdsufyan09/commit-bot.git
    cd commit-bot

---

## 3. Make bot.sh executable

    chmod +x bot.sh

---

## 4. Make run.sh executable

    chmod +x run.sh

run.sh automatically detects the location of the repository, so it does not require a hard-coded username or repository path.

---

## 5. Create LaunchAgent

Location:

    ~/Library/LaunchAgents/com.mdsufyan.commitbot.plist

Create it:

    nano ~/Library/LaunchAgents/com.mdsufyan.commitbot.plist

Use the following configuration:

    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN"
    "http://www.apple.com/DTDs/PropertyList-1.0.dtd">

    <plist version="1.0">
    <dict>

        <key>Label</key>
        <string>com.mdsufyan.commitbot</string>

        <key>ProgramArguments</key>
        <array>
            <string>/Users/YOUR_USERNAME/Developer/commit-bot/run.sh</string>
        </array>

        <key>RunAtLoad</key>
        <true/>

        <key>StartInterval</key>
        <integer>3600</integer>

        <key>WorkingDirectory</key>
        <string>/Users/YOUR_USERNAME/Developer/commit-bot</string>

        <key>StandardOutPath</key>
        <string>/tmp/commitbot.log</string>

        <key>StandardErrorPath</key>
        <string>/tmp/commitbot.err</string>

    </dict>
    </plist>

Replace YOUR_USERNAME with your macOS username.

Validate the configuration:

    plutil -lint ~/Library/LaunchAgents/com.mdsufyan.commitbot.plist

Load the LaunchAgent:

    launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.mdsufyan.commitbot.plist

Verify:

    launchctl list | grep com.mdsufyan.commitbot

---

# Test

Run manually:

    launchctl kickstart -k gui/$(id -u)/com.mdsufyan.commitbot

You can also test the complete script directly:

    ./run.sh

Logs:

    cat /tmp/commitbot.log
    cat /tmp/commitbot.err

Check LaunchAgent status:

    launchctl list | grep com.mdsufyan.commitbot

The bot should create at most **one commit per calendar day**.

---

# Updating

To modify the bot:

    nano bot.sh

To modify the network launcher:

    nano run.sh

After modifying either script, make sure it is executable:

    chmod +x bot.sh
    chmod +x run.sh

If the LaunchAgent configuration was changed, reload it:

    launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.mdsufyan.commitbot.plist

Then:

    launchctl bootstrap gui/$(id -u) ~/Library/LaunchAgents/com.mdsufyan.commitbot.plist

Verify:

    launchctl list | grep com.mdsufyan.commitbot

---

# Uninstall

Unload the LaunchAgent:

    launchctl bootout gui/$(id -u) ~/Library/LaunchAgents/com.mdsufyan.commitbot.plist

Delete LaunchAgent:

    rm ~/Library/LaunchAgents/com.mdsufyan.commitbot.plist

Delete repository:

    rm -rf ~/Developer/commit-bot

---

# What happens to my commits?

### If I delete the local folder

✅ Automation stops.

✅ Existing commits remain on GitHub.

---

### If I delete the LaunchAgent

✅ Automation stops.

✅ Existing commits remain.

---

### If I delete the GitHub repository

❌ The repository disappears.

❌ All commits inside that repository disappear.

❌ They will also disappear from the GitHub contribution graph because the repository no longer exists.

---

# Privacy

This bot:

- does not read files outside its own repository
- does not collect personal information
- only appends timestamps to output.txt
- only pushes commits to my GitHub repository

No third-party services are used.

---

# Notes

This bot only creates contribution activity.

It does not replace genuine development work.

The best GitHub profile still comes from meaningful commits to real projects.

