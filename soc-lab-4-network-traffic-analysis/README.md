# 🧪 Lab 4 – Network Traffic Analysis with Wireshark + Nmap

This lab focused on capturing and analyzing basic network traffic using **Wireshark** and **Nmap**. I scanned a Windows domain controller (`DC01`) from my workstation VM and verified the results through both command-line output and packet-level evidence.

---

## 🎯 Objective

- Perform a port scan against `DC01` (`192.168.64.4`) using Nmap.
- Capture the traffic using Wireshark on the scanning system.
- Verify open and closed ports with packet-level evidence.
- Save the `.pcapng` file and review it on macOS Wireshark.

---

## 🧰 Tools Used

| Tool        | Platform      | Purpose               |
|-------------|---------------|-----------------------|
| Wireshark   | Windows & macOS | Packet capture & review |
| Nmap        | Windows (VM)  | Host discovery, SYN scan, service version detection |
| PowerShell  | Windows (VM)  | Running and exporting Nmap output |
| UTM         | macOS         | Virtualization of Windows VMs |

---

## 🛠️ Commands Used

```powershell
# Confirm IP address
ipconfig

# Ping target
ping 192.168.64.4

# Host discovery
nmap -sn 192.168.64.4

# SYN scan
nmap -sS 192.168.64.4 -p 1-1024

# Service/version scan
nmap -sV 192.168.64.4 | Tee-Object -FilePath C:\Users\Administrator\Desktop\04-11-nmap-sV.txt
📁 Screenshots
All images are in ./screenshots/

#	Filename	Description
01	04-01-wireshark-mac.png	Wireshark installed on macOS
02	04-02-wireshark-win.png	Wireshark installed on Windows VM
03	04-03-nmap-version.png	Confirm Nmap version
04	04-04-workstation-ipconfig.png	Workstation IP address
05	04-05-ping-dc01.png	Successfully pinging DC01
06	04-05-wireshark-live.png	Live capture in Wireshark
07	04-06-nmap-sn.png	Nmap host discovery (-sn)
08	04-07-wireshark-arp.png	ARP request/response in Wireshark
09	04-08-nmap-ss.png	Nmap SYN scan (-sS)
10	04-08-pcap-saved.png	Saved .pcapng file on Windows
11	04-09-wireshark-syn-filter.png	SYN packets sent to DC01
12	04-10-wireshark-rst-filter.png	RST packets from closed ports
13	04-10-wireshark-synack.png	SYN/ACK packet from open port (5985)
14	04-11-nmap-sV.png	Service version detection (-sV)
15	04-12-wireshark-ip-target.png	Filtered traffic by target
16	04-12-wireshark-packet-details-svc.png	HTTPAPI header for WinRM
17	04-13-wireshark-macos-pcap-open.png	Pcap opened on macOS

📦 Evidence Files
These files are in ./evidence/:

Lab4_NMapScan_192.168.64.4_2025-11-07.pcapng – Packet capture

04-11-nmap-sV.txt – Raw service detection output

🔍 Findings (summary)
Confirmed multiple open ports on DC01 including LDAP, SMB, DNS, Kerberos.

Port 5985 (WinRM) is open and responds with Microsoft HTTPAPI/2.0 → remote PowerShell is enabled.

Closed ports return RST packets (confirmed in Wireshark).

Service fingerprinting (-sV) matches packet header data (HTTP/1.1 200 + HTTPAPI).

🛡️ Security Notes
WinRM (5985) over HTTP can be abused if an attacker gets valid credentials. Best practice is to use 5986 (HTTPS) and restrict access to admins.

Legacy ports like NetBIOS (139) should be disabled unless required.

Critical services such as LDAP, Kerberos, and SMB should be monitored and kept internal-only.

