#!/bin/bash

# ==========================================
# Linux Service Monitoring Script
# ==========================================

# Create logs directory if it doesn't exist
mkdir -p logs

# Date and Time
DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M:%S")

# List of services to monitor
SERVICES=(
    ssh
    cron
    NetworkManager
    docker
    apache2
    nginx
    mysql
)

echo "======================================================"
echo "           Linux Service Monitoring"
echo "======================================================"
echo "Date : $DATE"
echo "Time : $TIME"
echo "======================================================"

{
echo "======================================================"
echo "Linux Service Monitoring Report"
echo "Date : $DATE"
echo "Time : $TIME"
echo "======================================================"
} >> logs/system_report.log

printf "%-20s %-15s\n" "SERVICE" "STATUS"
echo "------------------------------------------------------"

for SERVICE in "${SERVICES[@]}"
do

    # Check whether service exists
    if systemctl list-unit-files | grep -qw "^${SERVICE}.service"
    then

        # Get current status
        STATUS=$(systemctl is-active "$SERVICE")

        if [ "$STATUS" = "active" ]
        then
            DISPLAY_STATUS="RUNNING"
        elif [ "$STATUS" = "inactive" ]
        then
            DISPLAY_STATUS="STOPPED"
        elif [ "$STATUS" = "failed" ]
        then
            DISPLAY_STATUS="FAILED"
        else
            DISPLAY_STATUS="$STATUS"
        fi

    else
        DISPLAY_STATUS="NOT INSTALLED"
    fi

    printf "%-20s %-15s\n" "$SERVICE" "$DISPLAY_STATUS"

    {
    printf "%-20s %-15s\n" "$SERVICE" "$DISPLAY_STATUS"
    } >> logs/system_report.log

done

echo "------------------------------------------------------"

{
echo "------------------------------------------------------"
echo ""
} >> logs/system_report.log

echo ""
echo "Service monitoring completed successfully."
