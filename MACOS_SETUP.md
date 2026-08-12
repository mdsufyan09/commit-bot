I want to create a GitHub Commit Bot for macOS.

Requirements:

- Native macOS solution (LaunchAgent preferred)
- No cron unless absolutely necessary
- No SleepWatcher or third-party utilities
- No Accessibility/Input Monitoring permissions
- One commit per day maximum
- Commit only if today's commit hasn't already been made
- Push automatically to GitHub
- Keep timestamps in output.txt
- Delay about 20 seconds after login so networking is ready
- Repository should live in ~/Developer/commit-bot
- Use LaunchAgent RunAtLoad so it runs when I log into macOS
- No background polling or hourly timers
- Explain every step from cloning the repository to creating the LaunchAgent
- Include uninstall instructions
- Explain what happens to GitHub contribution history if I delete the local folder or delete the GitHub repository
- Ensure the solution follows macOS security best practices and avoids protected folders like Desktop/Documents for automation
