# SOC Lab 1 – Sysmon Setup

## 🎯 Objective  
Install, configure, and validate **Sysmon** logging on two Windows endpoints (**Workstation01** and **DC01**) as the foundation for future labs involving Windows Event Forwarding (WEF) and SIEM ingestion.

This lab demonstrates:
- Proper Sysmon deployment and configuration
- Event validation (ProcessCreate, NetworkConnect, DNS Query, etc.)
- Export of raw `.evtx` for offline analysis
- Evidence collection for security portfolio documentation

---

## 🖥️ Machines Used

| Hostname        | OS                  | Role                |
|-----------------|---------------------|---------------------|
| Workstation01   | Windows 11 Pro      | Client Endpoint     |
| DC01            | Windows Server      | Domain Controller   |

---

## ✅ Workstation01 Progress Checklist

| Step | Status | Description |
|------|--------|-------------|
| A1 | ✅ | Created `C:\Tools\Sysmon` and `C:\Lab\SOC1\Evidence` folders |
| A2 | ✅ | Placed Sysmon executable + config file |
| A3 | ✅ | Installed Sysmon using config |
| A4 | ✅ | Verified Sysmon service is running |
| A5 | ✅ | Enabled **Sysmon Operational** event log |
| A6 | ✅ | Captured Sysmon version + config hash |
| A7 | ✅ | Generated test events (ProcessCreate, DNS, NetworkConnect) |
| A8 | ✅ | Exported Sysmon Operational log (`.evtx`) |
| A9 | ✅ | Collected artifacts in Evidence folder |

---

## 🖼️ Key Screenshots (Workstation01)

**Folder Structure Created**  
![Workstation01 Create Folders](./SOC1/Workstation01/Screenshots/SOC1-01_Workstation01_CreateFolders.png)

**Sysmon Install Command Executed Successfully**  
![Workstation01 Install Command](./SOC1/Workstation01/Screenshots/SOC1-03_Workstation01_InstallCommand.png)

**Event Log for Sysmon Enabled & Active**  
![Workstation01 Event Log Enabled](./SOC1/Workstation01/Screenshots/SOC1-05_Workstation01_EventLogEnabled.png)

**Sysmon Version & Config Hash Validated**  
![Workstation01 Sysmon Version](./SOC1/Workstation01/Screenshots/SOC1-06_Workstation01_SysmonVersion.png)

---

## 🗂️ Workstation01 Artifacts

| File | Purpose |
|------|---------|
| `Sysmon-Operational.evtx` | Raw exported Sysmon event log |
| `SysmonVersion.txt` | Output of version + config hash |
| `sysmonconfig.xml` | Config ruleset in effect |
| `testfile.txt` | FileCreate event (trigger file) |

📁 **Location:** `C:\Lab\SOC1\Evidence\`

---

## 🔹 System 2: DC01 (Domain Controller)

### ✅ DC01 Progress Checklist

| Step | Status | Description |
|------|--------|-------------|
| B1 | ✅ | Created `C:\Tools\Sysmon` and `C:\Lab\SOC1\Evidence` folders |
| B2 | ✅ | Placed Sysmon executable + config file |
| B3 | ✅ | Installed Sysmon using config |
| B4 | ✅ | Verified Sysmon service is running |
| B5 | ✅ | Enabled **Sysmon Operational** event log |
| B6 | ✅ | Captured Sysmon version + config hash |
| B7 | ✅ | Generated test events (ProcessCreate, NetworkConnect) |
| B8 | ✅ | Exported Sysmon Operational log |
| B9 | ✅ | Collected artifacts in Evidence folder |

---

## 🖼️ Key Screenshots (DC01)

**Folder Structure Created**  
![DC01 Create Folders](./SOC1/DC01/Screenshots/SOC1-01_DC01_CreateFolders.png)

**Sysmon Install Command Executed Successfully**  
![DC01 Install Command](./SOC1/DC01/Screenshots/SOC1-03_DC01_InstallCommand.png)

**Event Log for Sysmon Enabled & Active**  
![DC01 Event Log Enabled](./SOC1/DC01/Screenshots/SOC1-05_DC01_EventLogEnabled.png)

**Sysmon Version & Config Hash Validated**  
![DC01 Sysmon Version](./SOC1/DC01/Screenshots/SOC1-06_DC01_SysmonVersion.png)

---

## 🗂️ DC01 Artifacts

| File | Description |
|------|-------------|
| `SysmonVersion` | Output of `.\Sysmon64a.exe -c` |
| `testfile.txt` | Trigger file for event logging |
| `Sysmon-Operational.evtx` | Export of Operational log |

📁 **Location:** `C:\Lab\SOC1\Evidence\`

🔎 Note: Sysmon FileCreate (Event ID 11) was filtered out by config on DC01 — not required for this lab.

---

## 📜 Full Screenshot Index

### Workstation01

SOC1-01_Workstation01_CreateFolders.png
SOC1-02_Workstation01_SysmonFiles.png
SOC1-03_Workstation01_InstallCommand.png
SOC1-04_Workstation01_ServiceRunning.png
SOC1-05_Workstation01_EventLogEnabled.png
SOC1-06_Workstation01_SysmonVersion.png
SOC1-07_Workstation01_ConfigDump.png
SOC1-08_Workstation01_TestEvents.png
SOC1-09_Workstation01_ExportedLog.png
SOC1-10_Workstation01_ArtifactsFolder.png

shell
Copy code

### DC01

SOC1-01_DC01_CreateFolders.png
SOC1-02_DC01_SysmonFiles.png
SOC1-03_DC01_InstallCommand.png
SOC1-04_DC01_ServiceRunning.png
SOC1-05_DC01_EventLogEnabled.png
SOC1-06_DC01_SysmonVersion.png
SOC1-07_DC01_ConfigDump.png
SOC1-08_DC01_TestEvents.png
SOC1-09_DC01_ExportedLog.png

yaml
Copy code

---

## 🔜 Next Steps (SOC Lab Series)

| Lab | Title | Focus |
|------|-------|-------|
| SOC Lab 2 | Windows Event Forwarding (WEF) | Forward Sysmon logs from endpoints → DC |
| SOC Lab 3 | SIEM Ingest | Send forwarded logs into SIEM (Splunk, Elastic, LimaCharlie, etc.) |
| SOC Lab 4 | Detection Lab | Write Sigma rules and alert on Sysmon events |

---

🔧 *Built as part of an ongoing security analyst portfolio showcasing endpoint telemetry, defensive monitoring, and detection engineering fundamentals.*
