#!/bin/bash

# ==========================================
# Linux SSH Monitoring Script
# ==========================================

mkdir -p logs

DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M:%S")
LOGFILE="logs/system_report.log"

echo "=================================================="
echo "           SSH Login Monitoring"
echo "=================================================="
echo "Date : $DATE"
echo "Time : $TIME"
echo "=================================================="

{
echo "=================================================="
echo "SSH Login Monitoring Report"
echo "Date : $DATE"
echo "Time : $TIME"
echo "=================================================="
} >> "$LOGFILE"

###############################################
# Detect log source
###############################################

if [ -f /var/log/auth.log ]; then
    AUTH_LOG="/var/log/auth.log"
    USE_JOURNAL=false
else
    USE_JOURNAL=true
fi

###############################################
# Failed Login Attempts
###############################################

echo
echo "Failed SSH Login Attempts"
echo "--------------------------------------------------"

{
echo
echo "Failed SSH Login Attempts"
echo "--------------------------------------------------"
} >> "$LOGFILE"

if [ "$USE_JOURNAL" = false ]; then
    FAILED=$(grep "Failed password" "$AUTH_LOG")
else
    FAILED=$(journalctl -u ssh --no-pager | grep "Failed password")
fi

if [ -z "$FAILED" ]; then
    echo "No failed login attempts found."
    echo "No failed login attempts found." >> "$LOGFILE"
else
    echo "$FAILED"
    echo "$FAILED" >> "$LOGFILE"
fi

###############################################
# Successful Logins
###############################################

echo
echo "Successful SSH Logins"
echo "--------------------------------------------------"

{
echo
echo "Successful SSH Logins"
echo "--------------------------------------------------"
} >> "$LOGFILE"

if [ "$USE_JOURNAL" = false ]; then
    SUCCESS=$(grep "Accepted password" "$AUTH_LOG")
else
    SUCCESS=$(journalctl -u ssh --no-pager | grep "Accepted password")
fi

if [ -z "$SUCCESS" ]; then
    echo "No successful SSH logins found."
    echo "No successful SSH logins found." >> "$LOGFILE"
else
    echo "$SUCCESS"
    echo "$SUCCESS" >> "$LOGFILE"
fi

###############################################
# Invalid User Attempts
###############################################

echo
echo "Invalid User Login Attempts"
echo "--------------------------------------------------"

{
echo
echo "Invalid User Login Attempts"
echo "--------------------------------------------------"
} >> "$LOGFILE"

if [ "$USE_JOURNAL" = false ]; then
    INVALID=$(grep "Invalid user" "$AUTH_LOG")
else
    INVALID=$(journalctl -u ssh --no-pager | grep "Invalid user")
fi

if [ -z "$INVALID" ]; then
    echo "No invalid user attempts found."
    echo "No invalid user attempts found." >> "$LOGFILE"
else
    echo "$INVALID"
    echo "$INVALID" >> "$LOGFILE"
fi

###############################################
# Summary
###############################################

FAILED_COUNT=$(echo "$FAILED" | grep -c "Failed password")
SUCCESS_COUNT=$(echo "$SUCCESS" | grep -c "Accepted password")
INVALID_COUNT=$(echo "$INVALID" | grep -c "Invalid user")

echo
echo "=================================================="
echo "Summary"
echo "=================================================="
echo "Failed Logins     : $FAILED_COUNT"
echo "Successful Logins : $SUCCESS_COUNT"
echo "Invalid Users     : $INVALID_COUNT"
echo "=================================================="

{
echo
echo "=================================================="
echo "Summary"
echo "=================================================="
echo "Failed Logins     : $FAILED_COUNT"
echo "Successful Logins : $SUCCESS_COUNT"
echo "Invalid Users     : $INVALID_COUNT"
echo "=================================================="
echo
} >> "$LOGFILE"

echo
echo "SSH monitoring completed successfully."
