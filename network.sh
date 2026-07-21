#!/bin/bash

# ==========================================
# Linux Network Monitoring Script
# ==========================================

# Create logs directory if it doesn't exist
mkdir -p logs

# Get current date and time
DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M:%S")

# Get Hostname
HOSTNAME=$(hostname)

# Get IP Address
IP_ADDRESS=$(hostname -I | awk '{print $1}')

# Get Default Gateway
GATEWAY=$(ip route | awk '/default/ {print $3}')

# Count Listening Ports
LISTENING_PORTS=$(ss -tuln | tail -n +2 | wc -l)

# Count Established Connections
ESTABLISHED=$(ss -tan state established | tail -n +2 | wc -l)

# Count Logged-in Users
USERS=$(who | wc -l)

# Check Internet Connectivity
if ping -c 2 8.8.8.8 >/dev/null 2>&1
then
    INTERNET="Connected"
else
    INTERNET="Disconnected"
fi

# Display Report
echo "==========================================="
echo "        Linux Network Monitor"
echo "==========================================="
echo "Date                  : $DATE"
echo "Time                  : $TIME"
echo "Hostname              : $HOSTNAME"
echo "IP Address            : $IP_ADDRESS"
echo "Default Gateway       : $GATEWAY"
echo "Internet Status       : $INTERNET"
echo "Listening Ports       : $LISTENING_PORTS"
echo "Established Sessions  : $ESTABLISHED"
echo "Logged-in Users       : $USERS"
echo "==========================================="

# Save Report
{
echo "==========================================="
echo "Linux Network Monitoring Report"
echo "Date                  : $DATE"
echo "Time                  : $TIME"
echo "Hostname              : $HOSTNAME"
echo "IP Address            : $IP_ADDRESS"
echo "Default Gateway       : $GATEWAY"
echo "Internet Status       : $INTERNET"
echo "Listening Ports       : $LISTENING_PORTS"
echo "Established Sessions  : $ESTABLISHED"
echo "Logged-in Users       : $USERS"
echo "==========================================="
echo ""
} >> logs/system_report.log

# Show Listening Ports
echo ""
echo "Listening Ports"
echo "----------------------------"
ss -tuln

# Show Active Connections
echo ""
echo "Established Connections"
echo "----------------------------"
ss -tan state established

echo ""
echo "Network monitoring completed."
