#!/bin/bash
  ########################################################
  # SCRIPT:  backup.sh
  # PURPOSE: Back up a folder with a timestamped filename
  # AUTHOR:  Abdullah — Cloud Engineer
  # USAGE:   bash backup.sh
  ########################################################

  # ─── CONFIGURATION (change these for each client) ───
 SOURCE_DIR="/home/abdullah-afzal/day-by-day-practice/day-5/myapp"
 BACKUP_DIR="/home/abdullah-afzal/day-by-day-practice/day-5/backups"
 LOG_FILE="/home/abdullah-afzal/day-by-day-practice/day-5/backup.log"
 APP_NAME="myapp"

 # ─── TIMESTAMP — format: myapp-2024-06-24_02-00-01 ──
 TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
 # date '+%Y-%m-%d_%H-%M-%S' formats current date+time
 # %Y = year (2024), %m = month (06), %d = day (24)
 # %H = hour (02), %M = minute (00), %S = second (01)

 BACKUP_FILENAME="${APP_NAME}-${TIMESTAMP}.tar.gz"
 BACKUP_PATH="${BACKUP_DIR}/${BACKUP_FILENAME}"

 # ─── HELPER: log a message with timestamp ───────────
 log() {
     echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
     # tee -a writes to BOTH the terminal AND the log file
 }

 # ─── STEP 1: Make sure backup directory exists ───────
 if [ ! -d "$BACKUP_DIR" ]; then
     mkdir -p "$BACKUP_DIR"
     log "Created backup directory: $BACKUP_DIR"
 fi

 # ─── STEP 2: Make sure source directory exists ───────
 if [ ! -d "$SOURCE_DIR" ]; then
     log "ERROR: Source directory not found: $SOURCE_DIR"
     exit 1   # exit code 1 = something went wrong
 fi

 # ─── STEP 3: Create the compressed backup ────────────
 log "Starting backup of $SOURCE_DIR"
 log "Backup file: $BACKUP_FILENAME"

 tar -czf "$BACKUP_PATH" "$SOURCE_DIR"
 # tar -czf = Create Compressed (gzip) File
 # "$BACKUP_PATH" = output file name
 # "$SOURCE_DIR" = folder to compress

 # ─── STEP 4: Check if backup succeeded ───────────────
 if [ $? -eq 0 ]; then
     # $? = exit code of LAST command (0 = success, anything else = error)
     BACKUP_SIZE=$(du -sh "$BACKUP_PATH" | awk '{print $1}')
     log "SUCCESS: Backup completed — size: $BACKUP_SIZE"
     log "Saved to: $BACKUP_PATH"
 else
     log "ERROR: Backup FAILED! Check disk space or permissions."
     exit 1
 fi

 log "─────────────────────────────────────"
