#!/bin/bash

# =====================================================
# Linux System Report Generator
# =====================================================

# Project directories
BASE_DIR=$(cd "$(dirname "$0")" && pwd)

REPORT_DIR="$BASE_DIR/reports"
LOG_DIR="$BASE_DIR/logs"

# Create directories if missing
mkdir -p "$REPORT_DIR"
mkdir -p "$LOG_DIR"


# Date and time
DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M:%S")


# Report file name
REPORT_FILE="$REPORT_DIR/system-report-$DATE.txt"


# Generate Report

{

echo "====================================================="
echo "          Linux System Health Report"
echo "====================================================="

echo ""
echo "Generated Date : $DATE"
echo "Generated Time : $TIME"

echo ""
echo "====================================================="
echo "SYSTEM INFORMATION"
echo "====================================================="

echo "Hostname:"
hostname

echo ""

echo "Kernel Version:"
uname -r


echo ""
echo "Operating System:"
cat /etc/os-release | grep PRETTY_NAME


echo ""
echo "System Uptime:"
uptime



echo ""
echo "====================================================="
echo "CPU INFORMATION"
echo "====================================================="

echo "CPU Model:"
lscpu | grep "Model name"

echo ""

echo "CPU Usage:"
top -bn1 | grep "Cpu(s)"



echo ""
echo "====================================================="
echo "MEMORY INFORMATION"
echo "====================================================="

free -h



echo ""
echo "====================================================="
echo "DISK INFORMATION"
echo "====================================================="

df -h



echo ""
echo "====================================================="
echo "NETWORK INFORMATION"
echo "====================================================="

echo "IP Address:"
hostname -I


echo ""

echo "Network Interfaces:"
ip addr



echo ""
echo "====================================================="
echo "RUNNING SERVICES"
echo "====================================================="

systemctl --type=service --state=running



echo ""
echo "====================================================="
echo "LOGGED IN USERS"
echo "====================================================="

who



echo ""
echo "====================================================="
echo "TOP CPU PROCESSES"
echo "====================================================="

ps aux --sort=-%cpu | head -10



echo ""
echo "====================================================="
echo "TOP MEMORY PROCESSES"
echo "====================================================="

ps aux --sort=-%mem | head -10



echo ""
echo "====================================================="
echo "FAILED SERVICES"
echo "====================================================="

systemctl --failed



echo ""
echo "====================================================="
echo "END OF REPORT"
echo "====================================================="


} > "$REPORT_FILE"



# Display result

echo "=============================================="
echo " Linux Report Generated Successfully"
echo "=============================================="

echo "Report Location:"
echo "$REPORT_FILE"

echo "=============================================="
