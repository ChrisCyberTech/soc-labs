# 🧪 Lab 4 — Network Traffic Analysis with Wireshark + Nmap

**Goal:** Capture and analyze basic network traffic while scanning a Windows domain controller (DC01) from a Windows workstation VM. Prove findings with both **Nmap output** and **packet-level evidence** in **Wireshark** (captured on Windows, reviewed on macOS).

---

## 🎯 Objectives

- Run an Nmap host discovery and SYN port scan against DC01.
- Confirm open vs. closed ports using packet behavior (SYN/ACK vs. RST).
- Identify services with `-sV` and connect results to security impact.
- Save a **pcap** and analyze it on **both** Windows and macOS.

---

## 🧰 Tools Used

- **Wireshark**
  - Windows (live capture)
  - macOS (offline analysis)
- **Nmap** on Workstation01 (PowerShell)
- **UTM Windows VMs**
  - `Workstation01` → `192.168.64.2`
  - `DC01` → `192.168.64.4`

---

## 🗺️ Mini Topology

Workstation01 (192.168.64.2) ---> DC01 (192.168.64.4)
Nmap + Wireshark AD / DNS / LDAP / SMB / WinRM

yaml
Copy code

---

## 🛠️ Commands Used

```powershell
# Confirm IP
ipconfig

# Ping DC01
ping 192.168.64.4

# Host discovery
nmap -sn 192.168.64.4

# SYN scan
nmap -sS 192.168.64.4 -p 1-1024

# Service/version detection (export to file)
nmap -sV 192.168.64.4 | Tee-Object -FilePath C:\Users\Administrator\Desktop\04-11-nmap-sV.txt
Wireshark filters used:

nginx
Copy code
icmp or arp
ip.dst == 192.168.64.4 and tcp.flags.syn == 1 and tcp.flags.ack == 0
ip.src == 192.168.64.4 and tcp.flags.syn == 1 and tcp.flags.ack == 1
ip.src == 192.168.64.4 and tcp.flags.reset == 1
ip.addr == 192.168.64.4
tcp.port == 5985
📷 Evidence (screenshots)
#	File	Description
1	04-01-wireshark-mac.png	Wireshark installed on macOS
2	04-02-wireshark-win.png	Wireshark installed on Workstation01
3	04-03-nmap-version.png	Nmap version check
4	04-04-workstation-ipconfig.png	Workstation01 IP info
5	04-05-ping-dc01.png	Ping DC01 success
6	04-05-wireshark-live.png	Live capture running
7	04-06-nmap-sn.png	nmap -sn host discovery
8	04-07-wireshark-arp.png	ARP request/response
9	04-08-nmap-ss.png	SYN scan output
10	04-08-pcap-saved.png	Saved .pcapng file
11	04-09-wireshark-syn-filter.png	SYN packets filter
12	04-10-wireshark-rst-filter.png	RST (closed ports)
13	04-10-wireshark-synack.png	SYN/ACK (open ports)
14	04-11-nmap-sV.png	nmap -sV output
15	04-12-wireshark-ip-target.png	Filter for DC01 traffic
16	04-12-wireshark-packet-details-svc.png	Packet details showing HTTPAPI
17	04-13-wireshark-macos-pcap-open.png	pcap opened in macOS Wireshark

📁 Raw Evidence Files
File	Path
Lab4_NMapScan_192.168.64.4_2025-11-07.pcapng	./evidence/Lab4_NMapScan_192.168.64.4_2025-11-07.pcapng
04-11-nmap-sV.txt	./evidence/04-11-nmap-sV.txt

🔍 Key Findings
✅ Open ports confirmed by both Nmap & Wireshark
✅ Port 5985 (WinRM) responds with SYN/ACK → remote PowerShell possible
✅ RST packets confirm closed ports (no response fallback)
✅ HTTPAPI server header proves WinRM service
✅ ARP traffic shows host discovery behavior

🛡️ Security Takeaway (beginner level)
Port	Risk	Notes
5985	Medium	Remote PowerShell access over HTTP
139 / 445	Medium	Legacy SMB + file sharing attack surface
389 / 3268	High	LDAP exposed → sensitive AD data queries
53	Low/Medium	DNS poisoning / tunneling if misconfigured

✅ WinRM should use HTTPS (5986)
✅ Restrict access to admin VLAN or jump host
✅ Monitor Event IDs 4624, 4672, 4104 for remote PS activity

