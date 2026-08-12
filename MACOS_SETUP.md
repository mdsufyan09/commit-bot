I want to create a GitHub Commit Bot for macOS.

Requirements:

- Native macOS solution using LaunchAgent
- No cron
- No SleepWatcher or third-party utilities
- No Accessibility/Input Monitoring permissions
- One commit per day maximum
- Commit only if today's commit hasn't already been made
- Push automatically to GitHub
- Keep timestamps in output.txt
- Wait for GitHub/network availability before running
- Retry every 10 seconds if GitHub is temporarily unreachable
- Repository should live in ~/Developer/commit-bot
- Use LaunchAgent RunAtLoad so it runs when I log into macOS
- Use LaunchAgent StartInterval to check once every hour while the user is logged in
- Do not create duplicate commits when today's commit already exists
- run.sh should automatically detect the repository location instead of using a hard-coded username/path
- Explain every step from cloning the repository to creating the LaunchAgent
- Include testing, logging, updating, and uninstall instructions
- Explain what happens to GitHub contribution history if I delete the local folder or delete the GitHub repository
- Ensure the solution follows macOS security best practices and avoids protected folders like Desktop/Documents for automation
- The solution should work on both Intel Macs and Apple Silicon Macs
