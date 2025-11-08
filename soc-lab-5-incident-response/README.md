# 🛡️ SOC Lab 5 – Incident Investigation & Response

## 🔍 Overview
This lab simulates a basic security incident on a Windows workstation, detects suspicious activity using Sysmon and WEF logs in Splunk, and demonstrates how to perform analysis and respond as a Tier 1 SOC or Help Desk technician.

---

## 📋 Objectives
- Simulate suspicious PowerShell-based activity
- Collect logs via Windows Event Forwarding (WEF)
- Analyze the incident in Splunk SIEM
- Contain and remediate the issue
- Document the incident response workflow

---

## 📁 Lab Structure
```
soc-lab-5-incident-response/
├── README.md
├── incident_report.md
├── commands/
│   ├── simulate-attack.ps1
│   └── splunk-queries.txt
├── screenshots/
└── logs/
    └── event-exports/
```

---

## 🧪 Next Steps
- Fill in `simulate-attack.ps1` with a test payload or benign PowerShell script
- Capture logs and upload them under `logs/event-exports/`
- Add Splunk search queries to `splunk-queries.txt`
- Add screenshots demonstrating each stage of the incident pipeline
- Complete the detailed incident report in `incident_report.md`

---

> _Created as part of a beginner-friendly SOC and Help Desk training workflow. Designed to mimic real-world incident detection and response procedures._
