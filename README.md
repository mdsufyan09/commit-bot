# GitHub Commit Bot (macOS)

A lightweight GitHub commit bot for macOS that automatically creates **one commit per day** when I log into my Mac.

This setup is based on the original Commit Bot project but modified for native macOS usage.

---

# Features

- Native macOS (LaunchAgent)
- No cron
- No SleepWatcher
- No Accessibility/Input Monitoring permissions
- No background polling
- One commit per day
- Automatically pushes to GitHub
- Runs only after login

---

# How it works

When I log into macOS:

LaunchAgent
        ↓
run.sh
        ↓
(wait 20 seconds for network)
        ↓
bot.sh
        ↓
Checks if today's commit already exists
        ↓
If YES → Exit
If NO  → Commit + Push

The bot only commits between **9:00 AM and 2:00 AM**.

---

# Installation

## 1. Create a development folder

```bash
mkdir -p ~/Developer
cd ~/Developer
```

---

## 2. Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/commit-bot.git
cd commit-bot
```

---

## 3. Replace bot.sh

Use the modified bot.sh.

Make executable:

```bash
chmod +x bot.sh
```

---

## 4. Create run.sh

```bash
chmod +x run.sh
```

---

## 5. Create LaunchAgent

Location:

```
~/Library/LaunchAgents/com.mdsufyan.commitbot.plist
```

Load it:

```bash
launchctl load ~/Library/LaunchAgents/com.mdsufyan.commitbot.plist
```

Verify:

```bash
launchctl list | grep commitbot
```

---

# Test

Run manually:

```bash
launchctl kickstart -k gui/$(id -u)/com.mdsufyan.commitbot
```

Logs:

```bash
cat /tmp/commitbot.log
cat /tmp/commitbot.err
```

---

# Updating

To modify the bot:

```bash
nano bot.sh
```

Reload LaunchAgent:

```bash
launchctl unload ~/Library/LaunchAgents/com.mdsufyan.commitbot.plist
launchctl load ~/Library/LaunchAgents/com.mdsufyan.commitbot.plist
```

---

# Uninstall

Unload LaunchAgent:

```bash
launchctl unload ~/Library/LaunchAgents/com.mdsufyan.commitbot.plist
```

Delete LaunchAgent:

```bash
rm ~/Library/LaunchAgents/com.mdsufyan.commitbot.plist
```

Delete repository:

```bash
rm -rf ~/Developer/commit-bot
```

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
