#!/bin/bash

# ==========================================
# Linux Memory Monitoring Script
# ==========================================

# Create logs directory if it doesn't exist
mkdir -p logs

# Get current date and time
DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M:%S")

# Get memory information (in MB)
TOTAL_MEM=$(free -m | awk '/^Mem:/ {print $2}')
USED_MEM=$(free -m | awk '/^Mem:/ {print $3}')
FREE_MEM=$(free -m | awk '/^Mem:/ {print $4}')
AVAILABLE_MEM=$(free -m | awk '/^Mem:/ {print $7}')

# Calculate memory usage percentage
MEM_USAGE=$(( USED_MEM * 100 / TOTAL_MEM ))

# Determine memory status
if [ "$MEM_USAGE" -ge 90 ]; then
    STATUS="CRITICAL"
elif [ "$MEM_USAGE" -ge 75 ]; then
    STATUS="WARNING"
else
    STATUS="NORMAL"
fi

# Display output
echo "====================================="
echo "      Linux Memory Monitor"
echo "====================================="
echo "Date            : $DATE"
echo "Time            : $TIME"
echo "Total Memory    : ${TOTAL_MEM} MB"
echo "Used Memory     : ${USED_MEM} MB"
echo "Free Memory     : ${FREE_MEM} MB"
echo "Available Memory: ${AVAILABLE_MEM} MB"
echo "Memory Usage    : ${MEM_USAGE}%"
echo "Status          : $STATUS"
echo "====================================="

# Save to log file
{
echo "====================================="
echo "Date            : $DATE"
echo "Time            : $TIME"
echo "Total Memory    : ${TOTAL_MEM} MB"
echo "Used Memory     : ${USED_MEM} MB"
echo "Free Memory     : ${FREE_MEM} MB"
echo "Available Memory: ${AVAILABLE_MEM} MB"
echo "Memory Usage    : ${MEM_USAGE}%"
echo "Status          : $STATUS"
echo "====================================="
echo ""
} >> logs/system_report.log
