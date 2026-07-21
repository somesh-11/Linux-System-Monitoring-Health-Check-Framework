#!/bin/bash

# ==========================================
# Linux Process Monitoring Script
# ==========================================

# Create logs directory if it doesn't exist
mkdir -p logs

# Get current date and time
DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M:%S")

echo "=============================================="
echo "        Linux Process Monitor"
echo "=============================================="
echo "Date : $DATE"
echo "Time : $TIME"
echo "=============================================="

# Save report header
{
echo "=============================================="
echo "Linux Process Monitoring Report"
echo "Date : $DATE"
echo "Time : $TIME"
echo "=============================================="
} >> logs/system_report.log

# Total Running Processes
TOTAL_PROCESSES=$(ps -e --no-headers | wc -l)

echo "Total Running Processes : $TOTAL_PROCESSES"

{
echo "Total Running Processes : $TOTAL_PROCESSES"
echo ""
} >> logs/system_report.log

#############################################
# Top 10 CPU Consuming Processes
#############################################

echo ""
echo "Top 10 CPU Consuming Processes"
echo "---------------------------------------------------------------"
printf "%-8s %-15s %-8s %-8s %-20s\n" "PID" "USER" "CPU%" "MEM%" "COMMAND"

ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 11 | while read PID USER CPU MEM CMD
do
    printf "%-8s %-15s %-8s %-8s %-20s\n" "$PID" "$USER" "$CPU" "$MEM" "$CMD"
done

{
echo ""
echo "Top 10 CPU Consuming Processes"
ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 11
echo ""
} >> logs/system_report.log

#############################################
# Top 10 Memory Consuming Processes
#############################################

echo ""
echo "Top 10 Memory Consuming Processes"
echo "---------------------------------------------------------------"
printf "%-8s %-15s %-8s %-8s %-20s\n" "PID" "USER" "CPU%" "MEM%" "COMMAND"

ps -eo pid,user,%cpu,%mem,comm --sort=-%mem | head -n 11 | while read PID USER CPU MEM CMD
do
    printf "%-8s %-15s %-8s %-8s %-20s\n" "$PID" "$USER" "$CPU" "$MEM" "$CMD"
done

{
echo ""
echo "Top 10 Memory Consuming Processes"
ps -eo pid,user,%cpu,%mem,comm --sort=-%mem | head -n 11
echo ""
} >> logs/system_report.log

#############################################
# Zombie Process Check
#############################################

ZOMBIES=$(ps -el | awk '$2=="Z"{count++} END {print count+0}')

echo ""
echo "Zombie Processes : $ZOMBIES"

{
echo "Zombie Processes : $ZOMBIES"
echo ""
} >> logs/system_report.log

#############################################
# Load Average
#############################################

LOAD=$(uptime | awk -F'load average:' '{print $2}')

echo "System Load Average : $LOAD"

{
echo "System Load Average : $LOAD"
echo "=============================================="
echo ""
} >> logs/system_report.log

echo ""
echo "Process monitoring completed successfully."
