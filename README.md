# 🛡️ SOC Labs – Student Portfolio

This repository contains a collection of hands-on Security Operations Center (SOC) labs that I’m completing as part of my beginner cybersecurity journey. Each lab focuses on one practical SOC skill — using real Windows hosts, Sysmon, Event Forwarding (WEF), and SIEM integration inside a virtual lab environment.

The goal is to learn how to collect, centralize, and analyze security logs in a controlled domain setup using virtual machines.

---

## 🔍 Lab Overview

| Lab # | Title                                               | Description                                                                                          | Status  |
|-------|-----------------------------------------------------|------------------------------------------------------------------------------------------------------|---------|
| 1     | [Local Sysmon Setup](./soc-lab-1-sysmon)            | Installed Sysmon on Workstation01 and explored local operational logs                               | ✅ Done |
| 2     | [WEF + Sysmon (Forwarding)](./soc-lab-2-wef)        | Configured Windows Event Forwarding to collect Sysmon logs from Workstation01 ➜ DC01                | ✅ Done |
| 3     | [WEF + SIEM Integration (Splunk)](./soc-lab-3-siem-wef) | Ingested forwarded Security and Sysmon logs into Splunk index `wef` for querying and detection      | ✅ Done |
| 4     | Network Traffic Analysis *(coming soon)*            | Use Wireshark + Nmap to investigate and analyze suspicious network traffic                          | 🔜 Next |

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
├── soc-lab-2-wef
│   ├── README.md
│   └── screenshots/
├── soc-lab-3-siem-wef
│   ├── README.md
│   └── screenshots/
└── README.md  ← (this file)
🧠 Learning Reflection
Each lab includes a personal reflection section:

🚀 What I learned

🔧 What broke

🔍 What I want to try next

I’m building this portfolio to gain practical cybersecurity experience and prepare for an entry-level role, starting with help desk and working toward SOC Analyst.

📌 Next Up
✅ Lab 3 complete (SIEM integration)

🔜 Lab 4 – Network traffic analysis with Wireshark/Nmap

🧪 Future ideas: Threat hunting with Sigma, Event Filtering, Incident Response logs

Maintained by:
📌 Chris Mejia (GitHub: ChrisCyberTech)