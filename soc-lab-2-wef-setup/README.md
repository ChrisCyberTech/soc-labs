# SOC Lab 2 – Windows Event Forwarding (WEF) Setup

## 🎯 Objective
Set up Windows Event Forwarding to centralize logs from endpoints into a designated collector (DC01), preparing for SIEM integration in future labs.

## 🧱 Lab Architecture
| Role            | Hostname       | IP Address       | Notes                       |
|-----------------|----------------|------------------|-----------------------------|
| Event Collector | `DC01`         | `192.168.56.102` | Domain Controller + WEC     |
| Event Forwarder | `Workstation01`| `192.168.56.101` | Sysmon installed & running  |

## 🛠️ Key Steps
1. Enable Windows Event Collector service on DC01  
2. Create a Source-Initiated Subscription on DC01  
3. Allow remote Event Viewer access via Firewall and GPO  
4. Configure Workstation01 to forward events  
5. Validate forwarded events in DC01 via Event Viewer  

## 📸 Key Screenshots

### DC01 (Collector)
- `SOC2-01_DC01_Enable_WECSvc.png` – WEC service Automatic + Running
- `SOC2-02_DC01_Create_Subscription.png` – Subscription created (Security + Sysmon)
- `SOC2-03_DC01_Events_Received.png` – Forwarded Events populated

### Workstation01 (Forwarder)
- `SOC2-04_WS01_Configure_WinRM.png` – WinRM listener configured
- `SOC2-05_WS01_GPO_Received.png` – GPO applied confirmation
- `SOC2-06_WS01_Sysmon_Event.png` – Local Sysmon event generated

## 📁 Log Export
- `exports/ForwardedEvents.evtx` – Export of forwarded logs for analysis
