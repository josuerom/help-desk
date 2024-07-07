Write-Output "SSH Server instalado" + (Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0)
Write-Output "Servicio (sshd) iniciado" + (Start-Service sshd)
Write-Output "El servicio fue establecido con inicio automatico" + (Set-Service -Name sshd -StartupType 'Automatic')
Write-Output "Se agrego regla al firewall con nombre: (sshd)" + (New-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22)
cd C:\ProgramData\ssh\
notepad.exe sshd_config
whoami
Echo ""
Echo ":: Para modificar el puerto de regla del firewall EJECUTE:"
Echo "Set-NetFirewallRule -Name sshd -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort"
Echo ""
Echo ":: Para eliminar la regla del firewall. EJECUTE:"
Echo "Remove-NetFirewallRule -Name sshd"
Echo ""
Echo ":: Para detener el servicio sshd. EJECUTE:"
Echo "Stop-Service sshd"
Echo ""
Write-Output "Autor: @josuerom"
Pause