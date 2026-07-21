# Linux-System-Monitoring-Health-Check-Framework

> A production-inspired Linux monitoring framework built entirely with **Bash Shell Scripting** to automate system health checks, log analysis, service monitoring, and report generation.

![Linux](https://img.shields.io/badge/Linux-Ubuntu-E95420?style=for-the-badge\&logo=ubuntu)
![Bash](https://img.shields.io/badge/Bash-Shell_Scripting-121011?style=for-the-badge\&logo=gnu-bash)
![System Monitoring](https://img.shields.io/badge/System-Monitoring-blue?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

---

# 📖 Overview

System administrators continuously monitor servers to identify resource bottlenecks, detect failed services, investigate authentication attempts, and maintain overall system health.

This project recreates many of those daily operational tasks using native Linux commands and Bash scripting.

Instead of relying on third-party monitoring tools, the framework demonstrates how Linux administrators can automate server health checks using built-in utilities.

---

# 🎯 Objectives

* Automate Linux system health monitoring
* Analyze CPU, memory, disk, and network usage
* Detect abnormal system conditions
* Monitor critical Linux services
* Track SSH login attempts
* Parse system logs
* Generate health reports
* Centralize configuration
* Demonstrate practical Linux administration skills

---

# ✨ Features

## 🖥️ System Monitoring

* CPU Utilization
* Memory Utilization
* Disk Usage
* Filesystem Health
* System Load Average
* Uptime Monitoring

---

## 🌐 Network Monitoring

* IP Address
* Hostname
* Default Gateway
* Internet Connectivity
* Listening Ports
* Active TCP Connections
* Logged-in Users

---

## ⚙️ Process Monitoring

* Running Processes
* Top CPU Consumers
* Top Memory Consumers
* Zombie Process Detection
* Load Average

---

## 🔧 Service Monitoring

Checks important Linux services such as:

* SSH
* Cron
* Docker
* Apache
* Nginx
* MySQL
* NetworkManager

Automatically reports:

* Running
* Stopped
* Failed
* Not Installed

---

## 🔐 SSH Security Monitoring

Detects:

* Failed Login Attempts
* Successful Logins
* Invalid User Attempts

Useful for identifying brute-force login attempts.

---

## 📄 System Log Monitoring

Scans Linux logs for:

* Errors
* Warnings
* Failed Services
* Kernel Messages
* Disk Errors
* Out Of Memory Events
* Authentication Failures

---

## 📊 Report Generation

Automatically creates a detailed health report containing:

* System Information
* CPU Statistics
* Memory Statistics
* Disk Information
* Network Information
* Running Services
* Top Processes
* Logged-in Users

Reports are stored inside:

```text
reports/
```

---

## ⏰ Automation

Supports scheduled execution using Cron.

Example:

```bash
0 * * * * /home/user/linux-monitor-project/monitor.sh
```

Automatically performs periodic monitoring without manual intervention.

---

# 🛠️ Technologies Used

* Bash Shell Scripting
* Linux
* Cron
* Systemd
* Journalctl
* AWK
* Grep
* Sed
* Top
* Free
* DF
* PS
* SS
* IP
* Hostname
* Uptime

---

# 📂 Project Structure

```text
linux-monitor-project/

├── monitor.sh
├── cpu.sh
├── memory.sh
├── disk.sh
├── network.sh
├── process.sh
├── services.sh
├── ssh-monitor.sh
├── log-monitor.sh
├── report.sh
├── config.conf
│
├── logs/
│   ├── system_report.log
│   └── alerts.log
│
├── reports/
│
├── screenshots/
│
└── README.md
```

---

# ⚙️ Installation

Clone the repository

```bash
git clone https://github.com/YOUR_USERNAME/linux-monitor-project.git
```

Enter the project

```bash
cd linux-monitor-project
```

Make every script executable

```bash
chmod +x *.sh
```

Run the monitoring framework

```bash
./monitor.sh
```

---

# ⚙️ Configuration

All monitoring thresholds are stored inside:

```text
config.conf
```

Example:

```bash
CPU_WARNING=60
CPU_CRITICAL=80

MEMORY_WARNING=75
MEMORY_CRITICAL=90

DISK_WARNING=80
DISK_CRITICAL=90
```

No modifications to the monitoring scripts are required.

---

# 📈 Example Output

```text
====================================================

Linux System Monitoring Dashboard

====================================================

CPU Status           : NORMAL
Memory Status        : WARNING
Disk Status          : NORMAL
Network              : Connected
SSH Monitor          : OK
Services             : Running
System Logs          : No Critical Errors

Monitoring Completed Successfully

====================================================
```

---

# 💼 Linux Administration Skills Demonstrated

* Shell Scripting
* Linux System Administration
* Process Management
* Network Administration
* Service Management
* Log Analysis
* System Troubleshooting
* Configuration Management
* Automation
* Cron Scheduling
* Health Reporting
* Performance Monitoring
* Incident Detection

---

# 📚 Linux Commands Used

| Category        | Commands         |
| --------------- | ---------------- |
| CPU             | top, uptime      |
| Memory          | free             |
| Disk            | df               |
| Process         | ps               |
| Network         | ip, ss, hostname |
| Services        | systemctl        |
| Logs            | journalctl, grep |
| Text Processing | awk, sed, cut    |
| Scheduling      | crontab          |

---

# 🚀 Future Enhancements

* Email Notifications
* Telegram Alerts
* Slack Notifications
* HTML Dashboard
* Interactive Terminal Dashboard
* JSON Report Export
* Docker Container Support
* Multi-Server Monitoring
* Email Report Scheduler
* Historical Trend Analysis

---

# 📸 Screenshots

Add screenshots here after completing the project.

```text
screenshots/

dashboard.png

cpu-monitor.png

memory-monitor.png

disk-monitor.png

report.png
```

---

# 🎓 Learning Outcomes

This project strengthened my understanding of:

* Writing modular Bash scripts
* Parsing Linux system information
* Automating administrative tasks
* Monitoring system performance
* Reading authentication and system logs
* Managing Linux services
* Building reusable command-line tools
* Organizing configuration-driven projects

---
📄 License

This project is released under the MIT License.
