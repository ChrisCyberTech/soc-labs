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

### 01 — Wireshark installed on macOS  
![Wireshark on macOS](./screenshots/04-01-wireshark-mac.png)

### 02 — Wireshark on Workstation01 (Windows VM)  
![Wireshark on Windows VM](./screenshots/04-02-wireshark-win.png)

### 03 — Nmap version output  
![Nmap version output](./screenshots/04-03-nmap-version.png)

### 04 — Workstation01 IP information  
![Workstation01 IP info](./screenshots/04-04-workstation-ipconfig.png)

### 05 — Ping successful to DC01  
![Ping successful to DC01](./screenshots/04-05-ping-dc01.png)

### 06 — Live capture started in Wireshark  
![Wireshark live capture](./screenshots/04-05-wireshark-live.png)

### 07 — Host discovery (`nmap -sn`)  
![nmap -sn host discovery](./screenshots/04-06-nmap-sn.png)

### 08 — ARP response detected for DC01  
![ARP response detected](./screenshots/04-07-wireshark-arp.png)

### 09 — SYN scan (`nmap -sS`)  
![nmap -sS SYN scan](./screenshots/04-08-nmap-ss.png)

### 10 — Saved `.pcapng` evidence  
![Saved pcap evidence](./screenshots/04-08-pcap-saved.png)

### 11 — SYN packets sent to DC01  
![SYN packets in Wireshark](./screenshots/04-09-wireshark-syn-filter.png)

### 12 — RST packets from closed ports  
![RST packet responses](./screenshots/04-10-wireshark-rst-filter.png)

### 13 — SYN/ACK confirming open port (WinRM 5985)  
![SYN/ACK open port](./screenshots/04-10-wireshark-synack.png)

### 14 — Nmap service/version detection  
![nmap -sV result](./screenshots/04-11-nmap-sV.png)

### 15 — Filtered traffic showing DC01 packets  
![IP traffic filter](./screenshots/04-12-wireshark-ip-target.png)

### 16 — Service fingerprint showing `HTTPAPI` header  
![Packet details for WinRM](./screenshots/04-12-wireshark-packet-details-svc.png)

### 17 — `.pcapng` file opened in Wireshark on macOS  
![pcap opened on macOS](./screenshots/04-13-wireshark-macos-pcap-open.png)

---

🔧 Commands Used
🟢 Workstation network info & ping

ipconfig — show IP configuration

ping 192.168.64.4 — verify DC01 is reachable

🟡 Host discovery (Nmap ping scan)

nmap -sn 192.168.64.4 — ARP/ICMP discovery scan

🔵 SYN port scan (ports 1–1024)

nmap -sS 192.168.64.4 -p 1-1024 — half-open SYN scan

🟣 Service & version detection

nmap -sV 192.168.64.4 | Tee-Object -FilePath C:\Users\Administrator\Desktop\04-11-nmap-sV.txt
→ saves scan output to file

✅ Result Verification
Check	Evidence
Host reachable	ARP + ICMP reply from 192.168.64.4
Open port	5985/TCP returned SYN/ACK → OPEN
Service banner	Packet shows Microsoft-HTTPAPI/2.0 → WinRM
Closed ports	Responded with RST flags
Match to Nmap	Packet data matches nmap -sV results
Cross-platform	.pcapng opened on macOS Wireshark
🧠 What I Learned

How SYN scans work vs full TCP handshake

How to confirm open vs closed ports from packet flags

What ARP, SYN, SYN/ACK, and RST look like in Wireshark

How nmap -sV fingerprints map to real packet banners

Why exposed services (WinRM, SMB, LDAP) increase attack surface