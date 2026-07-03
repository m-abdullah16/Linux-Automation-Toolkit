# Linux Automation Toolkit

A collection of Linux administration and automation scripts built with Bash.

## Project: Server Health Monitor

The Server Health Monitor is a lightweight Bash-based monitoring tool designed to help Linux administrators track system health, identify potential issues, and improve server reliability.

## Features

- Disk utilization monitoring
- RAM usage monitoring
- System error detection using journalctl
- Failed SSH login attempt tracking
- Color-coded status reporting
- Automated execution via Cron Jobs
- Lightweight and dependency-free

## Technologies Used

- Bash Scripting
- Linux System Administration
- Cron
- systemd (journalctl)
- awk
- grep

## Monitoring Checks

| Check | Description |
|---------|------------|
| Disk Usage | Detects high disk consumption |
| RAM Usage | Reports current memory utilization |
| Error Logs | Counts recent system errors |
| Security Monitoring | Tracks failed login attempts |
| Scheduled Monitoring | Supports automated execution via cron |

## Installation

Clone the repository:

```bash
git clone https://github.com/m-abdullah16/linux-automation-toolkit.git
cd linux-automation-toolkit
```

Make the script executable:

```bash
chmod +x server-health-monitor.sh
```

Run the script:

```bash
./server-health-monitor.sh
```

## Cron Job Automation

Schedule the script to run every day at 11:30 AM:

```bash
30 11 * * * /bin/bash /home/abdullah-afzal/server-health-monitor.sh >> /home/abdullah-afzal/health.log 2>&1
```

Verify Cron Jobs:

```bash
crontab -l
```

## Sample Output

```text
[OK] Disk Usage: 42%
[OK] RAM Usage: 58%
[OK] Recent Errors: 0
[OK] Failed Login Attempts: 2
```

## Screenshots

### Server Health Report

![Server Health Report](screenshots/server-health-report.png)

### Cron Job Configuration

![Cron Configuration](screenshots/cron-setup.png)

## Future Enhancements

- Email alerts for critical events
- CPU utilization monitoring
- Service health monitoring
- Slack/Discord notifications
- Historical log reporting

## Author

**Abdullah Afzal**

Linux Administration • Bash Automation • DevOps Enthusiast

GitHub: https://github.com/m-abdullah16
