Write-Output "Instalando SSH Server..." (Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0)
Write-Output "Servicio (sshd) iniciado" + (Start-Service sshd)
Set-Service -Name sshd -StartupType 'Automatic'
$Puerto = Read-Host "Que puerto desea usar"
Write-Output "Se ha agregado una nueva regla al firewall con nombre: (sshd)" (New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort $Puerto)
notepad C:\ProgramData\ssh\sshd_config
whoami
Echo "-------------------------------------------------------------"
Echo ":: Para modificar el puerto de regla del firewall EJECUTE:"
Echo "Set-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort`n"
Echo ":: Para eliminar la regla del firewall. EJECUTE:"
Echo "Remove-NetFirewallRule -Name sshd`n"
Echo ":: Para detener el servicio sshd. EJECUTE:"
Echo "Stop-Service sshd"
Echo "-------------------------------------------------------------"
Write-Output "`nAutor: @josuerom"
Pause