# SOC Lab 4 – Network Traffic Analysis with Wireshark + Nmap

## 📌 Overview

In this lab, I used **Nmap** to scan an Active Directory Domain Controller (`DC01`) from a Windows workstation (`WORKSTATION01`) and captured the traffic using **Wireshark**. Both **SYN scan (`-sS`)** and **service detection scan (`-sV`)** were used while analyzing the resulting traffic to determine open/closed ports and fingerprint services.

This lab demonstrates **packet-level validation of port scans**, cross-platform network traffic analysis (Windows to macOS), and foundational SOC skills including **OSINT on services, understanding remote attack surfaces (e.g., WinRM), and using packet inspection to validate discovery activity**.

---

## 🏗️ Architecture Diagram

┌───────────────────────────┐
│ WORKSTATION01 │
│ • Nmap Scanner │
│ • Wireshark Capture │
└─────────────┬─────────────┘
│ (Local subnet 192.168.64.0/24)
▼
┌───────────────────────────┐
│ DC01 (Domain Controller) │
│ • Open ports: 5985, 445, 389, etc. |
│ • Services: WinRM, LDAP, SMB, Kerberos |
└───────────────────────────┘

markdown
Copy code

---

## 🛠️ Tools & Technologies

| Tool/Service         | Purpose |
|----------------------|---------|
| **Nmap**             | Host discovery, SYN scan, service version scan |
| **Wireshark**        | Real-time packet capture and analysis |
| **PowerShell**       | Running Nmap and exporting scan results |
| **UTM (macOS)**      | Virtualized Windows environment for lab |
| **macOS (Host)**     | Analyzed saved `.pcapng` trace using Wireshark |

---

## 🎯 Objectives

- ✅ Perform ARP/ICMP host discovery using `nmap -sn`
- ✅ Execute SYN port scan (`nmap -sS`)
- ✅ Use Wireshark to confirm SYN/ACK (open ports) and RST (closed ports)
- ✅ Fingerprint running services using `nmap -sV`
- ✅ Save packet capture file (`.pcapng`) and review it cross-platform
- ✅ Validate open port **5985 (WinRM)** using both Nmap and packet details

---

## 🔄 Process Summary

1. Installed Wireshark and Nmap on `WORKSTATION01`
2. Verified network connectivity via `ping` and `ipconfig`
3. Started Wireshark capture and ran `nmap -sn` (host discovery)
4. Observed **ARP** packets confirming `DC01` is active
5. Performed SYN scan and confirmed open ports via SYN/ACKs
6. Used `nmap -sV` to gather service fingerprints (e.g., `Microsoft HTTPAPI`)
7. Saved `.pcapng` and opened it on macOS Wireshark for validation

---

## 🖼️ Screenshots

All screenshots are stored under `./screenshots/`:

| #  | Screenshot | Description |
|----|------------|-------------|
| 01 | [04-01-wireshark-mac.png](./screenshots/04-01-wireshark-mac.png) | Wireshark installed on macOS |
| 02 | [04-02-wireshark-win.png](./screenshots/04-02-wireshark-win.png) | Wireshark on Windows VM |
| 03 | [04-03-nmap-version.png](./screenshots/04-03-nmap-version.png) | Nmap version output |
| 04 | [04-04-workstation-ipconfig.png](./screenshots/04-04-workstation-ipconfig.png) | Workstation01 IP info |
| 05 | [04-05-ping-dc01.png](./screenshots/04-05-ping-dc01.png) | Ping successful to DC01 |
| 06 | [04-05-wireshark-live.png](./screenshots/04-05-wireshark-live.png) | Live capture started in Wireshark |
| 07 | [04-06-nmap-sn.png](./screenshots/04-06-nmap-sn.png) | `nmap -sn` (host discovery) |
| 08 | [04-07-wireshark-arp.png](./screenshots/04-07-wireshark-arp.png) | ARP response detected for DC01 |
| 09 | [04-08-nmap-ss.png](./screenshots/04-08-nmap-ss.png) | `nmap -sS` (SYN scan) |
| 10 | [04-08-pcap-saved.png](./screenshots/04-08-pcap-saved.png) | Saved `.pcapng` evidence |
| 11 | [04-09-wireshark-syn-filter.png](./screenshots/04-09-wireshark-syn-filter.png) | SYN packets sent to DC01 |
| 12 | [04-10-wireshark-rst-filter.png](./screenshots/04-10-wireshark-rst-filter.png) | RST packets from closed ports |
| 13 | [04-10-wireshark-synack.png](./screenshots/04-10-wireshark-synack.png) | SYN/ACK for open port 5985 |
| 14 | [04-11-nmap-sV.png](./screenshots/04-11-nmap-sV.png) | Output of `nmap -sV` |
| 15 | [04-12-wireshark-ip-target.png](./screenshots/04-12-wireshark-ip-target.png) | Filtering for only DC01 traffic |
| 16 | [04-12-wireshark-packet-details-svc.png](./screenshots/04-12-wireshark-packet-details-svc.png) | `Microsoft HTTPAPI` header (WinRM) |
| 17 | [04-13-wireshark-macos-pcap-open.png](./screenshots/04-13-wireshark-macos-pcap-open.png) | `.pcapng` file opened on macOS |
[04-03-nmap-version.png](./screenshots/04-03-nmap-version.png)

---

## 🔧 Commands Used

### ✅ Workstation network info & ping
```powershell
ipconfig
ping 192.168.64.4
✅ Host discovery
powershell
Copy code
nmap -sn 192.168.64.4
✅ SYN port scan
powershell
Copy code
nmap -sS 192.168.64.4 -p 1-1024
✅ Service/version detection
powershell
Copy code
nmap -sV 192.168.64.4 | Tee-Object -FilePath C:\Users\Administrator\Desktop\04-11-nmap-sV.txt
✅ Result Verification
ARP and SYN packets showed DC01 is reachable and responding

Port 5985 (WinRM) responded with SYN/ACK and showed Microsoft-HTTPAPI/2.0 in header

RST packets confirmed closed ports during scan

Service detection scan confirmed multiple AD-related services (LDAP, SMB, Kerberos)

.pcapng captured on Windows was successfully opened and analyzed via macOS Wireshark

🧠 What I Learned
How SYN scans work vs. full TCP connections

How open and closed ports can be confirmed via packet analysis

How to capture and interpret ARP, SYN/ACK, and RST in Wireshark

How Nmap's service detection (-sV) reveals useful attacker intel

Basics of validating remote access surface (like WinRM) using packet evidence

