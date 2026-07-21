#!/bin/bash

# =====================================================
# Linux System Log Monitoring Script
# =====================================================

mkdir -p logs

DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M:%S")
LOGFILE="logs/system_report.log"

echo "======================================================"
echo "             Linux Log Monitoring"
echo "======================================================"
echo "Date : $DATE"
echo "Time : $TIME"
echo "======================================================"

{
echo "======================================================"
echo "Linux Log Monitoring Report"
echo "Date : $DATE"
echo "Time : $TIME"
echo "======================================================"
} >> "$LOGFILE"

########################################################
# Detect log source
########################################################

if [ -f /var/log/syslog ]; then
    SYSTEM_LOG="/var/log/syslog"
    AUTH_LOG="/var/log/auth.log"
    USE_JOURNAL=false
else
    USE_JOURNAL=true
fi

########################################################
# Helper Function
########################################################

print_section () {

TITLE="$1"
PATTERN="$2"

echo
echo "$TITLE"
echo "------------------------------------------------------"

{
echo
echo "$TITLE"
echo "------------------------------------------------------"
} >> "$LOGFILE"

if [ "$USE_JOURNAL" = false ]; then

    if [ -f "$SYSTEM_LOG" ]; then
        RESULT=$(grep -i "$PATTERN" "$SYSTEM_LOG")
    else
        RESULT=""
    fi

else

    RESULT=$(journalctl --no-pager | grep -i "$PATTERN")

fi

if [ -z "$RESULT" ]; then
    echo "No entries found."
    echo "No entries found." >> "$LOGFILE"
else
    echo "$RESULT"
    echo "$RESULT" >> "$LOGFILE"
fi

}

########################################################
# Error Logs
########################################################

print_section "System Errors" "error"

########################################################
# Warning Logs
########################################################

print_section "System Warnings" "warning"

########################################################
# Failed Services
########################################################

print_section "Failed Services" "failed"

########################################################
# Kernel Messages
########################################################

print_section "Kernel Messages" "kernel"

########################################################
# Disk Errors
########################################################

print_section "Disk Errors" "disk"

########################################################
# OOM Killer
########################################################

print_section "Out Of Memory Events" "oom"

########################################################
# Authentication Failures
########################################################

echo
echo "Authentication Failures"
echo "------------------------------------------------------"

{
echo
echo "Authentication Failures"
echo "------------------------------------------------------"
} >> "$LOGFILE"

if [ "$USE_JOURNAL" = false ]; then

    if [ -f "$AUTH_LOG" ]; then
        AUTH=$(grep "Failed password" "$AUTH_LOG")
    else
        AUTH=""
    fi

else

    AUTH=$(journalctl -u ssh --no-pager | grep "Failed password")

fi

if [ -z "$AUTH" ]; then
    echo "No authentication failures."
    echo "No authentication failures." >> "$LOGFILE"
else
    echo "$AUTH"
    echo "$AUTH" >> "$LOGFILE"
fi

########################################################
# Summary
########################################################

if [ "$USE_JOURNAL" = false ]; then

    ERROR_COUNT=$(grep -ic "error" "$SYSTEM_LOG" 2>/dev/null)
    WARNING_COUNT=$(grep -ic "warning" "$SYSTEM_LOG" 2>/dev/null)
    FAILED_COUNT=$(grep -ic "failed" "$SYSTEM_LOG" 2>/dev/null)
    KERNEL_COUNT=$(grep -ic "kernel" "$SYSTEM_LOG" 2>/dev/null)
    DISK_COUNT=$(grep -ic "disk" "$SYSTEM_LOG" 2>/dev/null)
    OOM_COUNT=$(grep -ic "oom" "$SYSTEM_LOG" 2>/dev/null)

    if [ -f "$AUTH_LOG" ]; then
        SSH_COUNT=$(grep -ic "Failed password" "$AUTH_LOG")
    else
        SSH_COUNT=0
    fi

else

    ERROR_COUNT=$(journalctl --no-pager | grep -ic "error")
    WARNING_COUNT=$(journalctl --no-pager | grep -ic "warning")
    FAILED_COUNT=$(journalctl --no-pager | grep -ic "failed")
    KERNEL_COUNT=$(journalctl --no-pager | grep -ic "kernel")
    DISK_COUNT=$(journalctl --no-pager | grep -ic "disk")
    OOM_COUNT=$(journalctl --no-pager | grep -ic "oom")
    SSH_COUNT=$(journalctl -u ssh --no-pager | grep -ic "Failed password")

fi

echo
echo "======================================================"
echo "Summary"
echo "======================================================"
echo "Errors              : $ERROR_COUNT"
echo "Warnings            : $WARNING_COUNT"
echo "Failed Services     : $FAILED_COUNT"
echo "Kernel Messages     : $KERNEL_COUNT"
echo "Disk Errors         : $DISK_COUNT"
echo "OOM Events          : $OOM_COUNT"
echo "SSH Failed Logins   : $SSH_COUNT"
echo "======================================================"

{
echo
echo "======================================================"
echo "Summary"
echo "======================================================"
echo "Errors              : $ERROR_COUNT"
echo "Warnings            : $WARNING_COUNT"
echo "Failed Services     : $FAILED_COUNT"
echo "Kernel Messages     : $KERNEL_COUNT"
echo "Disk Errors         : $DISK_COUNT"
echo "OOM Events          : $OOM_COUNT"
echo "SSH Failed Logins   : $SSH_COUNT"
echo "======================================================"
echo
} >> "$LOGFILE"

echo
echo "System log monitoring completed successfully."
