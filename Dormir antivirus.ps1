Set-MpPreference -DisableRealtimeMonitoring $true
Start-Sleep -Seconds 300
Set-MpPreference -DisableRealtimeMonitoring $false
