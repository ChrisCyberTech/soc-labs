# 🧪 Lab 4 — Network Traffic Analysis with Wireshark + Nmap (Walkthrough)

**Goal:** Capture an Nmap scan from Workstation01 and verify findings with packet-level evidence in Wireshark. Capture on Windows (VM), review on macOS, and save artifacts for reproducibility.

---

## 🎯 Objectives
- Discover host and open ports on `DC01` (`192.168.64.4`) from `Workstation01` (`192.168.64.2`).
- Use `nmap -sS` to identify open ports and `nmap -sV` to fingerprint services.
- Verify `nmap` findings with Wireshark packets (SYN, SYN/ACK, RST).
- Save `.pcapng` and raw scan output for evidence.

---

## 🧰 Tools
- **Wireshark** (Windows capture, macOS analysis)
- **Nmap** (Workstation01; PowerShell)
- **UTM** Windows VMs (Workstation01 & DC01)
- **macOS** host (for offline analysis)

---

## 🗺️ Topology (mini)

Workstation01 (192.168.64.2) ---> DC01 (192.168.64.4)
(scanner + Wireshark capturing) (target - AD services)

yaml
Copy code

---

# Step-by-step Walkthrough

> NOTE: All screenshots are saved in `./screenshots/` and raw artifacts in `./evidence/`.

---

## Step 0 — Confirm tools & environment

**What I did:** verified Wireshark installed on macOS and Windows, and checked `nmap` version on the VM.

![Wireshark macOS](./screenshots/04-01-wireshark-mac.png)  
*Wireshark installed on macOS (for offline analysis).*

![Wireshark Windows](./screenshots/04-02-wireshark-win.png)  
*Wireshark installed on Workstation01 (used for live capture).*

![Nmap version](./screenshots/04-03-nmap-version.png)  
*Nmap version check on Workstation01.*

---

## Step 1 — Confirm Workstation IP & reachability

**Command:**
```powershell
ipconfig
ping 192.168.64.4

Workstation01 IP details.


Ping shows DC01 is reachable (host up).

Step 2 — Start Wireshark capture (Windows VM)
What I did: start a live capture on the VM interface that sees traffic to/from DC01.


Wireshark capturing on Workstation01 — waiting for scan traffic.

Step 3 — Host discovery (nmap -sn) — ARP observed
Command:

powershell
Copy code
nmap -sn 192.168.64.4
Why: quick host discovery; on local LAN this often uses ARP and may show ARP requests/replies.



ARP frames confirm host discovery — DC01 replies to ARP, proving it is up.

Step 4 — SYN port scan (nmap -sS) — send SYNs to ports
Command:

powershell
Copy code
nmap -sS 192.168.64.4 -p 1-1024
Why: stealthy SYN scan to detect open ports (SYN → SYN/ACK = open; SYN → RST = closed; no reply = filtered).


PowerShell shows scan running / results summary.

Wireshark evidence — SYNs to the target:

Apply display filter:

ini
Copy code
ip.dst == 192.168.64.4 and tcp.flags.syn == 1 and tcp.flags.ack == 0

Shows outbound SYN packets from scanner to DC01.

Step 5 — Confirm closed ports (RST responses)
What to look for: closed ports reply with RST to the scanner's SYN.

Filter:

ini
Copy code
ip.src == 192.168.64.4 and tcp.flags.reset == 1

RST packets from DC01 indicate closed ports.

Step 6 — Confirm open port via SYN/ACK (example: 5985 WinRM)
What to look for: SYN from scanner, then SYN/ACK from DC01 — proof the port is open.

Filter to show SYN/ACK replies:

ini
Copy code
ip.src == 192.168.64.4 and tcp.flags.syn == 1 and tcp.flags.ack == 1

This packet shows SYN/ACK from DC01 → confirm open port (5985).

Interpretation: The packet details show Src Port: 5985 → service running on TCP/5985.

Step 7 — Service/version detection (nmap -sV)
Command:

powershell
Copy code
nmap -sV 192.168.64.4 | Tee-Object -FilePath C:\Users\Administrator\Desktop\04-11-nmap-sV.txt
Why: -sV probes open ports and attempts to fingerprint the service/version.


Full -sV output saved to 04-11-nmap-sV.txt for evidence.

Key nmap -sV findings (excerpt):

5985/tcp open http Microsoft HTTPAPI httpd 2.0 (WinRM)

Other AD-related ports (DNS, Kerberos, LDAP, SMB) open.

Step 8 — Capture service-level traffic in Wireshark
Filter used while -sV ran:

ini
Copy code
ip.addr == 192.168.64.4
# or to focus on WinRM
tcp.port == 5985

Shows service probes and HTTP-like WinRM responses.


Expanded packet shows Microsoft-HTTPAPI/2.0 header — confirms WinRM service fingerprint.

Step 9 — Save the capture (.pcapng) and move for analysis
Action: stop the capture and save the packet trace.

Saved file:

Copy code
evidence/Lab4_NMapScan_192.168.64.4_2025-11-07.pcapng

Saved .pcapng before transfer — evidence of the capture file.

Open the same .pcapng on macOS Wireshark for offline review:


Cross-platform analysis — capture opened on macOS for deeper inspection.

Findings (summary)
Ports/services of interest (from nmap -sV & packet proof):

5985/tcp — WinRM (HTTP) — Microsoft HTTPAPI httpd 2.0 → remote PowerShell available

AD-related ports seen open: 53 (DNS), 88 (Kerberos), 389 (LDAP), 445 (SMB), 3268/3269 (Global Catalog), etc.

Packet evidence mapping:

04-07-wireshark-arp.png → host discovery (ARP)

04-09-wireshark-syn-filter.png → SYNs sent to DC01

04-10-wireshark-rst-filter.png → RST = closed ports

04-10-wireshark-synack.png → SYN/ACK = open port (5985)

04-12-wireshark-packet-details-svc.png → HTTPAPI header proving WinRM

04-11-nmap-sV.png + ./evidence/04-11-nmap-sV.txt → nmap fingerprints + text evidence

./evidence/Lab4_NMapScan_192.168.64.4_2025-11-07.pcapng → full packet capture

Security takeaway (intro-level)
WinRM (5985) — medium risk if exposed without restrictions. It enables remote PowerShell; an attacker with credentials could execute commands and move laterally. Prefer 5986 (HTTPS) and restrict access to management subnets.

LDAP / DNS / SMB are expected on domain controllers, but they are sensitive services. Keep them internal-only, monitored, and patched.

Mitigations (starter list):

Restrict WinRM to admin jump hosts / specific IPs in firewall rules.

Use WinRM over HTTPS (5986) or require management via jump host.

Disable legacy NetBIOS/SMBv1 if not required.

Monitor WinRM and authentication events (4624, 4625, 4104).

Evidence (files)
Screenshots: placed in ./screenshots/ (see inline images above).

Raw artifacts:

./evidence/Lab4_NMapScan_192.168.64.4_2025-11-07.pcapng

./evidence/04-11-nmap-sV.txt

