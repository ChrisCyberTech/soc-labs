# 🛡️ SOC Labs – Student Portfolio

This repository contains a collection of hands-on Security Operations Center (SOC) labs that I’m completing as part of my beginner cybersecurity journey. Each lab focuses on one practical SOC skill — using real Windows hosts, Sysmon, Event Forwarding (WEF), and SIEM integration inside a virtual lab environment.

The goal is to learn how to collect, centralize, and analyze security logs in a controlled domain setup using virtual machines.

---

## 🔍 Lab Overview

| Lab # | Title | Description |
|-------|-------|-------------|
| 1 | [Local Sysmon Setup](./soc-lab-1-sysmon-setup) | Deployed Sysmon on Workstation01 and explored local event logging under `Microsoft-Windows-Sysmon/Operational` |
| 2 | [WEF + Sysmon (Forwarding)](./soc-lab-2-wef-setup) | Set up Windows Event Forwarding (WEF) from WORKSTATION01 to DC01 and validated via PowerShell + Event Viewer |
| 3 | [Splunk SIEM Ingestion + Log Search](./soc-lab-3-siem-wef) | Installed Splunk, configured Universal Forwarder, ingested WEF logs, and searched EventIDs (4624, 4625, Sysmon 1) |
| 4 | [Network Traffic Analysis (Wireshark + Nmap)](./soc-lab-4-network-traffic-analysis) | Performed host discovery + SYN + service scans while capturing packets in Wireshark to validate open/closed ports |
| 5 | [Endpoint Incident Response (Native Windows Tools)](./soc-lab-5-endpoint-ir) | Simulated Windows endpoint compromise; investigation, artifact collection, and containment performed using native Windows tools and portable utilities. |


---

## 🧰 Tools & Technologies

- **Windows 11 Pro** (Workstation01 VM)
- **Windows Server 2025 / DC01**
- **UTM Virtualization** (ARM-based macOS)
- **Sysmon v15**
- **Windows Event Forwarding / Collector (WEC)**
- **Splunk Enterprise + Universal Forwarder**
- **PowerShell** for system + event validation
- *(Future)* Network tools: **Wireshark**, **Nmap**

---

## 🗂️ Repo Structure

```plaintext
/soc-labs
├── soc-lab-1-sysmon
│   ├── README.md
│   └── screenshots/
│
├── soc-lab-2-wef
│   ├── README.md
│   └── screenshots/
│
├── soc-lab-3-splunk
│   ├── README.md
│   └── screenshots/
│
├── soc-lab-4-wireshark-nmap
│   ├── README.md
│   └── screenshots/
│ 
├── soc-lab-5-endpoint-incident-response
│   ├── README.md
│   └── screenshots/
│
└── README.md   ← main index file
🧠 Learning Reflection Format (per lab)
Each lab includes a reflection section:
```

## 🧠 Learning Reflection Format (per lab)

| Section | Purpose |
|---------|---------|
| 🚀 **What I learned** | Key takeaways and technical skills gained |
| 🔧 **What broke** | Issues, troubleshooting notes, and how I fixed them |
| 🔍 **What I want to try next** | Future improvements, follow-ups, or experiments |

---

## 📌 Roadmap

| Status | Lab | Focus Area |
|--------|-----|------------|
| ✅ | Lab 1 | Sysmon local logging |
| ✅ | Lab 2 | Windows Event Forwarding (WEF) |
| ✅ | Lab 3 | Splunk SIEM ingestion |
| ✅ | Lab 4 | Network traffic analysis (Wireshark + Nmap) |
| 🔜 | Lab 5 | Incident Response & Windows Event logs |

---

## 🧪 Future Ideas

- Threat hunting with Sigma rules  
- Sysmon advanced config tuning  
- PowerShell logging + SRUM artifacts  
- Brute force + detection lab (RDP / WinRM)  
- Active Directory attack path mapping (BloodHound)  
- Incident response log workflow and playbooks

---

## 👤 Maintained by

**Chris Mejia** — GitHub: [ChrisCyberTech](https://github.com/ChrisCyberTech)
