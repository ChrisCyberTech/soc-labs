# 🧩 SOC Lab 5 – Endpoint Incident Response (Native Windows Tools)

## 🎯 Objective
Simulate and investigate a Windows endpoint compromise **without Sysmon, WEF, or Splunk**.  
Use **native PowerShell and built-in Windows tools** to detect persistence, gather evidence, and document findings as a SOC analyst.

---

## 🧠 Scenario
A suspicious PowerShell script (`setup_persistence.ps1`) was executed on **WORKSTATION01**, creating a scheduled task that maintains persistence and drops a possible malicious binary under `C:\Temp\evil`.  
Your role as the analyst is to:
1. Identify the persistence mechanism.  
2. Inspect active processes, services, and network connections.  
3. Verify startup registry keys.  
4. Compute a file hash for the suspected payload.  
5. Collect artifacts and create an investigation timeline.

---

## 🧰 Tools & Commands Used
| Category | Command / Tool | Purpose |
|-----------|----------------|----------|
| Persistence | `schtasks /query /v` | Enumerate scheduled tasks |
| Process | `tasklist /v` | Identify running processes |
| Network | `netstat -ano` | Inspect active TCP connections |
| Services | `Get-Service` | Review service states |
| Registry | `reg query HKLM/HKCU` | Check Run keys |
| Hashing | `Get-FileHash` | Compute SHA-256 of suspicious binary |
| Prefetch | `dir C:\Windows\Prefetch` | Check execution traces |
| Logs | `Get-EventLog -LogName Security` | Review recent login activity |
| Artifact Collection | `collect_artifacts.ps1` | Export forensic evidence |
| Verification | PowerShell listing commands | Validate collected data |

---

## 🧾 Step-by-Step Investigation

> Tip: images are centered and scaled to fit GitHub.  
> If you want them bigger/smaller, change `width="960"` below.

### 1) Persistence Creation
The attacker script created a scheduled task named **SysUpdateService** to maintain persistence.

<p align="center">
  <img src="screenshots/LAB5_01_setup_persistence_success.png" alt="SysUpdateService created by setup_persistence.ps1" width="960">
</p>

---

### 2) Verify Scheduled Task
Windows Task Scheduler shows the malicious task is present and enabled.

<p align="center">
  <img src="screenshots/LAB5_02_schtasks_list.png" alt="schtasks output showing SysUpdateService" width="960">
</p>

---

### 3) Enumerate Running Processes
A full verbose task list was captured for situational awareness.

<p align="center">
  <img src="screenshots/LAB5_03_tasklist_running_processes.png" alt="tasklist /v output" width="960">
</p>

---

### 4) Network Connections
`netstat -ano` revealed established outbound connections from the host.

<p align="center">
  <img src="screenshots/LAB5_04_netstat_connections.png" alt="netstat -ano output" width="960">
</p>

---

### 5) Services Status
Enumerated Windows services to rule out rogue service persistence.

<p align="center">
  <img src="screenshots/LAB5_05_get_service_list.png" alt="Get-Service output" width="960">
</p>

---

### 6) Registry – System Run Key (HKLM)
Global startup entries checked; only legitimate entries present.

<p align="center">
  <img src="screenshots/LAB5_06_reg_run_hklm.png" alt="HKLM Run key query" width="960">
</p>

---

### 7) Registry – User Run Key (HKCU)
User startup entries confirmed as expected (OneDrive, Edge).

<p align="center">
  <img src="screenshots/LAB5_07_reg_run_hkcu.png" alt="HKCU Run key query" width="960">
</p>

---

### 8) Hash Suspicious Binary
SHA-256 hash of `evil.exe` generated for reference and IOC sharing.

<p align="center">
  <img src="screenshots/LAB5_08_hash_evil_exe.png" alt="Get-FileHash for evil.exe" width="960">
</p>

---

### 9) Prefetch Check
No prefetch entry for `evil.exe` → likely not executed (or Prefetch disabled).

<p align="center">
  <img src="screenshots/LAB5_09_prefetch_evidence.png" alt="Prefetch search for evil.exe" width="960">
</p>

---

### 10) Security Event Logs
Recent logon activity provides timeline context (4624/4625/4800/4801).

<p align="center">
  <img src="screenshots/LAB5_10_eventlog_security.png" alt="Security event log entries" width="960">
</p>

---

### 11) Artifact Collection
Collected process, network, service, and registry data for analysis.

<p align="center">
  <img src="screenshots/LAB5_11_collect_artifacts_success.png" alt="collect_artifacts.ps1 output" width="960">
</p>

---

### 12) Artifact Import Verification
Artifacts validated under `C:\Temp\forensics`.

<p align="center">
  <img src="screenshots/LAB5_12_import_artifacts_success.png" alt="Forensics folder contents verification" width="960">
</p>

## 📚 Screenshots Index

| # | File |
|---|------|
| 1 | `LAB5_01_setup_persistence_success.png` |
| 2 | `LAB5_02_schtasks_list.png` |
| 3 | `LAB5_03_tasklist_running_processes.png` |
| 4 | `LAB5_04_netstat_connections.png` |
| 5 | `LAB5_05_get_service_list.png` |
| 6 | `LAB5_06_reg_run_hklm.png` |
| 7 | `LAB5_07_reg_run_hkcu.png` |
| 8 | `LAB5_08_hash_evil_exe.png` |
| 9 | `LAB5_09_prefetch_evidence.png` |
| 10 | `LAB5_10_eventlog_security.png` |
| 11 | `LAB5_11_collect_artifacts_success.png` |
| 12 | `LAB5_12_import_artifacts_success.png` |

---

## 🧩 Findings Summary
| Category | Observation |
|-----------|--------------|
| **Persistence** | Malicious scheduled task `SysUpdateService` created to maintain access |
| **File Hash** | SHA-256 = `8E1A3617EC1599E798FE8F3995B104D9D6D2E4B57099E44…` |
| **Registry** | No unauthorized startup keys detected |
| **Network** | Outbound TCP connections to multiple external IP addresses |
| **Prefetch** | No execution trace of evil.exe found |
| **Security Logs** | Normal logon/logout activity |

---

## 📦 Artifact Location
C:\Temp\forensics

yaml
---

## 🧮 Timeline Reference
Timeline entries are stored in  
[`docs/timeline_template.csv`](./docs/timeline_template.csv)

---

## ✅ Conclusion
This lab demonstrated a full endpoint incident response workflow **without external logging or SIEM tools**.  
Using only native PowerShell and Windows utilities, the analyst detected persistence, validated system integrity, and performed initial forensic triage—mirroring the capabilities of a first responder operating in a restricted or offline environment.

---

**Created by Chris (M.) | SOC Labs – Endpoint IR Series**