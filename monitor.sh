#!/bin/bash

# ======================================================
# Linux System Monitoring Tool
# Main Controller Script
# ======================================================

PROJECT_DIR=$(cd "$(dirname "$0")" && pwd)
LOG_DIR="$PROJECT_DIR/logs"
REPORT_DIR="$PROJECT_DIR/reports"

mkdir -p "$LOG_DIR"
mkdir -p "$REPORT_DIR"

DATE=$(date +"%Y-%m-%d")
TIME=$(date +"%H:%M:%S")

REPORT_FILE="$REPORT_DIR/system-report-$DATE.txt"

clear

echo "=========================================================="
echo "         Linux System Monitoring Dashboard"
echo "=========================================================="
echo "Date : $DATE"
echo "Time : $TIME"
echo "=========================================================="

echo ""
echo "[1/8] CPU Monitoring"
echo "------------------------------------------"
bash "$PROJECT_DIR/cpu.sh"

echo ""
echo "[2/8] Memory Monitoring"
echo "------------------------------------------"
bash "$PROJECT_DIR/memory.sh"

echo ""
echo "[3/8] Disk Monitoring"
echo "------------------------------------------"
bash "$PROJECT_DIR/disk.sh"

echo ""
echo "[4/8] Network Monitoring"
echo "------------------------------------------"
bash "$PROJECT_DIR/network.sh"

echo ""
echo "[5/8] Process Monitoring"
echo "------------------------------------------"
bash "$PROJECT_DIR/process.sh"

echo ""
echo "[6/8] Service Monitoring"
echo "------------------------------------------"
bash "$PROJECT_DIR/services.sh"

echo ""
echo "[7/8] SSH Monitoring"
echo "------------------------------------------"
bash "$PROJECT_DIR/ssh-monitor.sh"

echo ""
echo "[8/8] System Log Monitoring"
echo "------------------------------------------"
bash "$PROJECT_DIR/log-monitor.sh"

#########################################################
# Generate Final Report
#########################################################

{
echo "=========================================================="
echo "         Linux System Monitoring Report"
echo "=========================================================="
echo "Generated On : $DATE $TIME"
echo ""

echo "Hostname"
hostname

echo ""
echo "Kernel Version"
uname -r

echo ""
echo "System Uptime"
uptime

echo ""
echo "CPU Information"
lscpu | grep "Model name"

echo ""
echo "Memory"
free -h

echo ""
echo "Disk"
df -h

echo ""
echo "Network"
hostname -I

echo ""
echo "Logged-in Users"
who

echo ""
echo "=========================================================="

} > "$REPORT_FILE"

echo ""
echo "=========================================================="
echo "Project Finished Successfully"
echo "=========================================================="
echo "Detailed Report Saved To:"
echo "$REPORT_FILE"
echo ""
echo "Logs Directory:"
echo "$LOG_DIR"
echo ""
echo "Monitoring Completed Successfully."
echo "=========================================================="
