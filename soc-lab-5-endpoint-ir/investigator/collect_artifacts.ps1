# Investigator artifact collection script (run as Administrator)
$dest = "C:\Temp\forensics"
New-Item -Path $dest -ItemType Directory -Force | Out-Null
tasklist /v > "$dest\tasklist_v.txt"
schtasks /query /fo LIST /v > "$dest\schtasks_list_v.txt"
netstat -ano > "$dest\netstat_ano.txt"
Get-Service | Sort-Object Status | Out-File -FilePath "$dest\services.txt" -Encoding utf8
reg query "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" > "$dest\reg_run_hklm.txt" 2>&1
reg query "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Run" > "$dest\reg_run_hkcu.txt" 2>&1
$since = (Get-Date).AddHours(-24)
wevtutil qe Security /q:"*[System[TimeCreated[@SystemTime>='$($since.ToUniversalTime().ToString("s"))']]]" /f:text > "$dest\Security_last24h.txt" 2>&1
wevtutil epl Security "$dest\Security.evtx" 2>&1
$suspicious = "C:\Temp\evil\evil.exe"
if (Test-Path $suspicious) {
    Get-FileHash -Algorithm SHA256 $suspicious | Format-List | Out-File "$dest\evil_hash.txt"
    Copy-Item -Path $suspicious -Destination "$dest\" -Force
}
if (Test-Path "$env:SystemRoot\Prefetch") {
    dir "$env:SystemRoot\Prefetch" | Select-Object Name,Length,LastWriteTime | Out-File "$dest\prefetch_list.txt"
}
try { schtasks /query /xml /tn "SysUpdateService" > "$dest\SysUpdateService.xml" 2>&1 } catch {}
Write-Output "Artifacts collected in $dest"
