# SOC Lab 3 – SIEM Integration with Splunk

## 🎯 Objective

In this lab, I configured a basic SIEM environment using **Splunk Free** to ingest, index, and analyze Windows Sysmon logs that were forwarded using Windows Event Forwarding (WEF) in Lab 2.

This setup simulates a real SOC workflow where log data from endpoints is centralized in a SIEM for security monitoring, detection engineering, and incident investigation.

---

## 🧱 Lab Environment

| Device        | Purpose                             | OS / Version              |
|---------------|-------------------------------------|---------------------------|
| `DC01`        | Domain Controller, Event Collector  | Windows Server 2022       |
| `Workstation01` | Sysmon Event Source                  | Windows 11 Pro            |
| `SIEM01`      | Splunk Server / Indexer             | Splunk Free on Windows    |

---

## 🛠️ Lab Tasks (High-Level)

1. Downloaded and installed Splunk Free on `SIEM01`
2. Configured Splunk receiver/index (`sysmon_index`)
3. Set up Splunk to monitor the `ForwardedEvents` Windows log
4. Created basic Splunk search queries for Sysmon events
5. Confirmed daily log ingestion from `Workstation01` via WEF
6. (Optional) Built a starter Sysmon dashboard inside Splunk

---

## 📂 Repository Structure

```bash
soc-lab-3-siem/
├── README.md           # This file
├── configs/            # Splunk configs (inputs.conf, props.conf, etc.)
├── queries/            # .spl queries used in lab
├── dashboards/         # JSON exports of Splunk dashboards (if created)
├── notes/              # Written steps, troubleshooting, etc.
└── screenshots/
    ├── DC01/           # Screenshots from the domain controller
    ├── Workstation01/  # Screenshots from the endpoint
    └── SIEM/           # Screenshots from the Splunk server
📸 Screenshots (To Add)
#	File Name	Description
1	SOC3-01_SIEM01_SplunkInstall.png	Proof of Splunk installation
2	SOC3-02_SIEM01_DataInputConfigured.png	Data input for ForwardedEvents enabled in Splunk
3	SOC3-03_DC01_ForwardedEvents_Log.png	DC01 showing Sysmon logs still arriving via WEF
4	SOC3-04_SIEM01_SplunkSysmonSearch.png	Splunk query showing Sysmon logs from Workstation01
5	SOC3-05_SIEM01_SimpleDashboard.png	Optional Splunk dashboard (Process Create, DNS, etc.)

🧾 Notes
Splunk Free has a 500MB/day ingest limit, which is fine for lab use.

Make sure to adjust your inputs.conf to point to the correct Windows event log.

🔗 Related Labs
SOC Lab 1 – Sysmon Install

SOC Lab 2 – Windows Event Forwarding

