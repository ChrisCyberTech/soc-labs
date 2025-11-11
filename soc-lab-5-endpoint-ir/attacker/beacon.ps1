# benign beacon script for lab - EDIT $uri to your test endpoint
$uri = "http://10.0.2.2:8080/heartbeat"
while ($true) {
    try { Invoke-WebRequest -Uri $uri -UseBasicParsing -TimeoutSec 5 | Out-Null } catch {}
    Start-Sleep -Seconds 30
}
