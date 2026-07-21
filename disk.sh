#!/bin/bash

# ==========================================
# Linux Disk Monitoring Script
# ==========================================

# Create logs directory if it doesn't exist
mkdir -p logs

# Get current date and time
DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M:%S")

echo "=========================================="
echo "         Linux Disk Monitor"
echo "=========================================="
echo "Date : $DATE"
echo "Time : $TIME"
echo "=========================================="

{
echo "=========================================="
echo "Linux Disk Monitoring Report"
echo "Date : $DATE"
echo "Time : $TIME"
echo "=========================================="
} >> logs/system_report.log

# Get all mounted filesystems except tmpfs and devtmpfs
df -h --output=source,size,used,avail,pcent,target | tail -n +2 | grep -vE "tmpfs|devtmpfs" | while read FILESYSTEM SIZE USED AVAIL USEP MOUNT
do

    # Remove % symbol
    USAGE=$(echo "$USEP" | tr -d '%')

    # Check disk usage status
    if [ "$USAGE" -ge 90 ]; then
        STATUS="CRITICAL"
    elif [ "$USAGE" -ge 80 ]; then
        STATUS="WARNING"
    else
        STATUS="NORMAL"
    fi

    echo "Filesystem : $FILESYSTEM"
    echo "Mounted On : $MOUNT"
    echo "Total Size : $SIZE"
    echo "Used Space : $USED"
    echo "Free Space : $AVAIL"
    echo "Usage      : $USEP"
    echo "Status     : $STATUS"
    echo "------------------------------------------"

    {
    echo "Filesystem : $FILESYSTEM"
    echo "Mounted On : $MOUNT"
    echo "Total Size : $SIZE"
    echo "Used Space : $USED"
    echo "Free Space : $AVAIL"
    echo "Usage      : $USEP"
    echo "Status     : $STATUS"
    echo "------------------------------------------"
    } >> logs/system_report.log

done

echo "Disk monitoring completed."
