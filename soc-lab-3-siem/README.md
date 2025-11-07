# SOC Lab 3 – Windows Event Forwarding (WEF) + Splunk SIEM Integration

## 📌 Overview

In this lab, I configured **Windows Event Forwarding (WEF)** to collect **Sysmon** and **Security Logon Events** (IDs: `4624`, `4625`, `4634`) from a domain workstation (`WORKSTATION01`) and forward them to a **central Windows Event Collector (DC01)**. These logs were then ingested into **Splunk** using the **Universal Forwarder**, creating a searchable dataset under `index=wef`.

This lab demonstrates skills in **endpoint logging, centralized log forwarding, SIEM integration, and event investigation** — core competencies for SOC Analyst roles.

---

## 🏗️ Architecture Diagram

```
┌───────────────────────────┐
│  WORKSTATION01            │
│  • Sysmon (Event ID 1)    │
│  • Security Logs (4624...)│
└─────────────┬─────────────┘
              │  (WEF HTTP 5985)
              ▼
┌───────────────────────────┐
│  DC01 (WEC + Splunk UF)   │
│  • Forwards to Splunk     │
│  • Subscriptions enabled  │
└─────────────┬─────────────┘
              │
              ▼
┌───────────────────────────┐
│  Splunk Enterprise (DC01) │
│  • index=wef              │
│  • Search & SIEM queries  │
└───────────────────────────┘
```

---

## 🛠️ Tools & Technologies

| Tool/Service         | Purpose |
|----------------------|---------|
| **Sysmon**           | Endpoint event visibility (Process creation, network, etc.) |
| **Windows Event Forwarding (WEF)** | Collect and centralize logs from domain clients |
| **Splunk Enterprise (Local Install)** | SIEM for indexing and searching logs |
| **Splunk Universal Forwarder** | Sends WEF events from DC01 to Splunk |
| **PowerShell**       | Service verification, event testing, gpupdate, etc. |

---

## 🎯 Objectives

- ✅ Set up WEF subscription to collect Sysmon + Security logs
- ✅ Configure Splunk to ingest forwarded Windows logs
- ✅ Verify log delivery end-to-end (Source → WEC → Splunk)
- ✅ Search and analyze logon/logoff events (`4624`, `4625`, `4634`) in Splunk

---

## 🔄 Process Summary

1. **Enabled Data Inputs in Splunk**: `WinEventLog://ForwardedEvents`
2. **Edited `inputs.conf`** to monitor forwarded Windows logs
3. **Restarted Splunk Services** to apply changes
4. **Built WEF subscription on DC01** for Sysmon + Security channels
5. **Forced GP Update + Subscription Sync** on WORKSTATION01
6. **Verified forwarded events via PowerShell and Splunk**

---

## 🖼️ Screenshots

| # | Screenshot | Description |
|---|------------|-------------|
| 1 | `L3-01_Splunk_DataInputs_Page.png` | Verified Splunk Data Inputs for `WinEventLog://ForwardedEvents` |
| 2 | `L3-04_inputs_conf_AfterEdit.png` | Modified `inputs.conf` to accept forwarded Windows logs |
| 3 | `L3-05_Splunk_Restart_Services.png` | Restarted Splunk services after config change |
| 4 | `L3-06_Splunk_Search_Initial_Events.png` | Initial Sysmon events appearing in Splunk |
| 5 | `L3-07_Sysmon_EventID1_Visible.png` | Sysmon Event ID 1 successfully forwarded |
| 6 | `L3-08_Splunk_EventCode_Table.png` | Event counts grouped by `EventCode` in Splunk |
| 7 | `L3-08_WEF_4624_4625_4634_Splunk_Stats.png` | Successful logon/logoff events: 4624, 4625, 4634 |

---

## 🔧 Commands Used

### ✅ WEF Subscription Status (DC01)
```powershell
# List subscriptions
wecutil es

# Review subscription XML
wecutil gs SOC2-WEF /f:xml

# View runtime status
wecutil gr SOC2-WEF
```

### ✅ Force GP & Subscription Refresh (WORKSTATION01)
```powershell
gpupdate /force
schtasks /run /tn "\Microsoft\Windows\EventCollector\SubscriptionManager"
Restart-Service Wecsvc
```

### ✅ Validate Forwarded Logs (DC01)
```powershell
Get-WinEvent -LogName ForwardedEvents -MaxEvents 20 |
  Select TimeCreated, Id, MachineName
```

### ✅ Splunk Queries
```
index=wef source="WinEventLog:ForwardedEvents"
| stats count by host EventCode
```

---

## ✅ Result Verification

- `wecutil gr SOC2-WEF` confirmed forwarded events from `WORKSTATION01`
- Sysmon Event ID 1 appeared in `index=wef` in Splunk
- Security logons (4624, 4634) visible in both PowerShell and Splunk
- End-to-end flow: WORKSTATION01 → WEF → DC01 → Splunk

---

## 🧠 What I Learned

- Configured Windows Event Forwarding in a domain environment
- Understood Splunk’s data input, index, and search pipeline
- Gained experience validating logs via PowerShell and Splunk SPL
- Learned how to troubleshoot WEF subscriptions and log delivery
- Built SIEM visibility for offensive security telemetry (Sysmon) and identity events

---
