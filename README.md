# 🛡️ SOC Labs – Student Portfolio

This repository contains a collection of hands-on Security Operations Center (SOC) labs I’m completing as part of my beginner cybersecurity journey. Each lab focuses on one practical SOC skill at a time — using real Windows hosts, Sysmon, Event Forwarding (WEF), and eventually a SIEM.

The goal is to learn how to collect, forward, and analyze security logs in a small, controlled lab environment using virtual machines.

---

## 🔍 Lab Overview

| Lab # | Title                                    | Description                                                                                     |
|-------|------------------------------------------|-------------------------------------------------------------------------------------------------|
| 1     | [Local Sysmon Setup](./soc-lab-1-sysmon) | Deployed Sysmon on Workstation01 and explored local event logging under `Microsoft-Windows-Sysmon/Operational` |
| 2     | [WEF + Sysmon (Forwarding)](./soc-lab-2-wef) | Set up Windows Event Forwarding (WEF) from Workstation01 ➜ DC01 to collect and centralize Sysmon logs |
| 3     | SIEM Integration *(coming soon)*          | Forwarded Windows/Sysmon logs into a free SIEM for event analysis and detection writing         |

---

## 🧰 Tools & Technologies

- **Windows 11 Pro** (Workstation01 VM)
- **Windows Server 2025** (DC01 VM)
- **UTM Virtualization** on macOS (ARM-based)
- **Sysmon v15**
- **Windows Event Forwarding / Collector (WEC)**
- **PowerShell** for validation and log queries
- *(Later) SIEM tools like Wazuh, ELK, or Splunk Free*

---

## 🗂️ Repo Structure

```plaintext
/soc-labs
├── soc-lab-1-sysmon
│   ├── README.md
│   └── screenshots/
├── soc-lab-2-wef
│   ├── README.md
│   └── screenshots/
├── soc-lab-3-siem (coming soon)
└── README.md
🧠 Learning Reflection
Each lab will include a small reflection about:

What I learned 🚀

What broke 🔧

What I want to try next 🔍

📌 Next Up
✅ Lab 2 complete
🔜 Lab 3 – Build a free SIEM, ingest forwarded logs, and write detections
🧪 Future ideas: Windows Event Filtering, Threat Hunting, Sigma Rules, etc.

Repository maintained by Chris Mejia (GitHub: ChrisCyberTech)
Created as part of hands-on cybersecurity experience and continuous learning.

yaml

---