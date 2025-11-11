# SOC-LAB-5 - Endpoint Incident Response (Native Windows Tools)

## Overview
Host Compromise Triage & Containment lab using only native Windows tools and portable utilities. No Sysmon / no WEF / no Splunk.

## Structure
- attacker/         -> benign attacker scripts to simulate persistence & beaconing
- investigator/     -> collection & triage scripts (PowerShell) + export helpers
- tools/            -> instructions for portable tools (Autoruns, ProcExplorer)
- docs/             -> lab instructions, timeline template, checklist
- screenshots/      -> save screenshots here with required names
- artifacts/        -> collected artifacts (evtx, pcap, exported xml)
