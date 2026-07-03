#!/bin/bash

#SERVER-HEALTH-MONITOR

DISK_WARN=80
CPU_WARN=85
RAM_WARN=90
LOG_FILE="/var/log/health-monitor-log"
SERVICES="apache2 mysql ssh cron"

#COLOURS SHOWING THE ERRORS, WARNING, STATUS AND HEADERS 

RED='\033[0;31m'    # for errors/critical
 YELLOW='\033[1;33m' # for warnings
 GREEN='\033[0;32m'  # for OK status
 CYAN='\033[0;36m'   # for section headers
 NC='\033[0m'        # NC = No Color (resets color)

print_header() {
echo -e "${CYAN}  ▶ $1${NC}"
}

#FUNCTION 1: CHECKING THE DISK SPACE

check_disk() {
print_header "Disk Space Check"
DISK_USAGE=$(df -h / | awk 'NR==2 {gsub(/%/,""); print $5}')
if [ "$DISK_USAGE" -gt "$DISK_WARN" ]; then
  echo -e " ${RED}[CRITICAL] DISK USAGE : ${DISK_USAGE}%  - TAKE ACTION NOW ${NC}"
else
echo -e "{ ${GREEN}[OK] DISK USAGE : ${DISK_USAGE}%  - (THRESHOLD : ${DISK_WARN}% ${NC})}"
fi
echo ""
df -h | grep -vE 'tmpfs|udev'
}

# FUNCTION 2 : CHECKING THE RAM USAGE

check_ram() {
    print_header "RAM Usage Check"

    RAM_USAGE=$(free | awk '/Mem:/ {printf "%.0f", ($3/$2)*100}')
    RAM_TOTAL=$(free -h | awk '/Mem:/ {print $2}')
    RAM_USED=$(free -h | awk '/Mem:/ {print $3}')

    if [ "$RAM_USAGE" -gt "$RAM_WARN" ]; then
        echo -e "${RED}[CRITICAL] RAM USAGE: ${RAM_USAGE}%${NC}"
    else
        echo -e "${GREEN}[OK] RAM USAGE: ${RAM_USAGE}%${NC}"
    fi
}

# FUNCTION 3 : CHECKING LOGS

check_logs() {
print_header "RECENT ERRORS (LAST 1 HOUR)"
ERROR_COUNT=$(journalctl --since "1 hour ago" -p err --no-pager | wc -l)
if [ "$ERROR_COUNT" -gt 10 ]; then
     echo -e "${RED}[CRITICAL] $ERROR_COUNT errors has been counted in last hour ${NC}"
else
     echo -e "${GREEN}[OK] $ERROR_COUNT errors has been counted in last hour ${NC}"
fi 
}


# FUNCTION 4 : CHECKING SECURITY 
check_security() {
print_header "CHECKING FAILED LOGIN ATTEMPTS"
FAILED_LOGINS=$(grep -c 'Failed password' /var/log/auth.log 2>/dev/null || echo 0)
echo "Failed login attempts = $FAILED_LOGINS "
echo "Top Attacking IPs : "
grep -c 'Failed Password' /var/log/auth.log 2>/dev/null | \
awk '{print $11}' | \
sort | uniq -c | sort -rn | head -3 | \
awk '{print "  " $2 ": "$1 "attempts "}'
}

TIMESTAMP=$(date '+%Y-%m-%d %H:%M:%S')
HOSTNAME=$(hostname)

echo -e "${CYAN}"
 echo "  ╔═══════════════════════════════════════╗"
 echo "  ║   SERVER HEALTH MONITOR               ║"
 echo "  ║   Server: $HOSTNAME"
 echo "  ║   Time:   $TIMESTAMP"
 echo "  ╚═══════════════════════════════════════╝"
 echo -e "${NC}"

check_disk
check_ram
check_logs
check_security


echo 
 echo -e "${CYAN}Report saved to: $LOG_FILE${NC}"
 $0 >> "$LOG_FILE" 2>&1

echo -e "${GREEN} SERVER-HEALTH-CHECKUP COMPLETED ${NC}"



