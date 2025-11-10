# simulate-attack.ps1  -- SAFE lab simulation
# Purpose: generate Sysmon/WEF events (process creation, file create, network connect)
# Run interactively on Workstation01 from an elevated PowerShell session.

# -------- CONFIG --------
$payloadName = "lab_test_payload.txt"
$payloadPath = Join-Path $env:APPDATA $payloadName
$testUrl = "http://example.com/"
# ------------------------

# 1) Create a harmless payload file
"LAB TEST PAYLOAD - DO NOT PANIC. Created: $(Get-Date -Format o)" | Out-File -FilePath $payloadPath -Encoding utf8 -Force
Write-Output "Payload created at: $payloadPath"

# 2) Simple web request (benign) to generate a network connection event
try {
    $resp = Invoke-WebRequest -Uri $testUrl -UseBasicParsing -TimeoutSec 10
    Write-Output "Web request completed: $testUrl (Status: $($resp.StatusCode))"
} catch {
    Write-Output "Web request failed or blocked (this is OK for the lab). Message: $($_.Exception.Message)"
}

# 3) Touch a temporary file in Temp (extra filecreate evidence)
$tempFile = Join-Path $env:TEMP ("lab_temp_" + ([guid]::NewGuid().ToString()) + ".txt")
"temp file created on $(Get-Date -Format o)" | Out-File -FilePath $tempFile -Encoding utf8 -Force
Write-Output "Temp file created at: $tempFile"

# 4) Optional: create local test user (COMMENTED OUT by default)
# Uncomment only if you want to generate Windows Security user creation events
# $pw = ConvertTo-SecureString "P@ssW0rd!" -AsPlainText -Force
# New-LocalUser -Name "lab_test_user" -Password $pw -FullName "Lab Test User" -Description "Temporary account for SOC lab"
# Add-LocalGroupMember -Group "Users" -Member "lab_test_user"
# Write-Output "Test local user 'lab_test_user' created."

# 5) Final output (so terminal shows something)
Write-Output "Simulation complete. Created payload and temp files; attempted web request."
