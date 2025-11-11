# LAB 5 - Instructions (Endpoint IR)

1. On WORKSTATION01:
   - Run attacker/setup_persistence.ps1 (admin) to create benign persistence.
   - Verify: schtasks /query /v | findstr /i SysUpdateService
2. On Investigator VM:
   - Run investigator/collect_artifacts.ps1 as Administrator
   - Use investigator/import_artifacts.sh to copy artifacts into repo (if using WSL/Git Bash)
3. Save screenshots into /screenshots with provided filenames.
