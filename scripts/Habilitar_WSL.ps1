dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
wsl --set-default-version 2
wsl.exe --install
wsl --install -d kali-linux
Write-Output "`nAutor: @josuerom"
Restart-Computer -Force
Pause