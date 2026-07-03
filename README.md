# linux-automation-toolkit
# Server Health Monitor

A Bash script that monitors server health and security metrics.

## Features

- Disk usage monitoring
- RAM usage monitoring
- System error log monitoring
- Failed login attempt detection
- Color-coded terminal output
- Cron job automation support

## Requirements

- Linux
- Bash
- systemd (journalctl)
- cron

## Usage

Make the script executable:

```bash
chmod +x server-health-monitor.sh
```

Run manually:

```bash
./server-health-monitor.sh
```

## Daily Cron Job

Example:

```bash
30 11 * * * /bin/bash /home/abdullah-afzal/server-health-monitor.sh >> /home/abdullah-afzal/health.log 2>&1
```

## Sample Output

The script reports:

- Disk usage
- RAM usage
- Recent system errors
- Failed login attempts

## Screenshots

See the screenshots folder for execution examples and cron configuration.
