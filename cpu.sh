#!/bin/bash

# ==========================================
# Linux CPU Monitoring Script
# ==========================================

# Create log directory if it doesn't exist
mkdir -p logs

# Get current date and time
DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M:%S")

# Get CPU idle percentage
CPU_IDLE=$(top -bn1 | grep "Cpu(s)" | awk '{print $8}' | cut -d'.' -f1)

# Calculate CPU usage
CPU_USAGE=$(("100 - CPU_IDLE"))

# Check CPU status
if [ "$CPU_USAGE" -ge 80 ]
 then
    STATUS="CRITICAL"
elif [ "$CPU_USAGE" -ge 60 ]
 then
    STATUS="WARNING"
else
    STATUS="NORMAL"
fi

# Display output
echo "====================================="
echo "       Linux CPU Monitor"
echo "====================================="
echo "Date        : $DATE"
echo "Time        : $TIME"
echo "CPU Usage   : ${CPU_USAGE}%"
echo "CPU Status  : $STATUS"
echo "====================================="

# Save report
{
echo "====================================="
echo "Date        : $DATE"
echo "Time        : $TIME"
echo "CPU Usage   : ${CPU_USAGE}%"
echo "CPU Status  : $STATUS"
echo "====================================="
echo ""
} >> logs/system_report.log
