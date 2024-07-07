# Pedir al usuario el nombre de host y el dominio o grupo de trabajo
$hostName = Read-Host "NOMBRE DE HOST >>"
$domainOrWorkgroup = Read-Host "DOMINIO | WORKGROUP >>"

# Validar si se ingresó un nombre de host y un dominio/grupo de trabajo
if (-not $hostName.Trim()) {
   Write-Host "Debe ingresar un nombre de host valido."
   exit
}
if (-not $domainOrWorkgroup.Trim()) {
   Write-Host "Debe ingresar un dominio o grupo de trabajo valido."
   exit
}
# Pedir al usuario el nombre de usuario y la contraseña para unirse al dominio
$username = Read-Host "USUARIO >>"
$password = Read-Host -AsSecureString "CLAVE >>"

# Convertir la contraseña segura en texto claro para netdom
$passwordPlain = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($password))

# Configurar el nombre de host del equipo
$computer = Get-WmiObject Win32_ComputerSystem
$computer.Rename($hostName)

# Unir el equipo al dominio o grupo de trabajo
$netdomArgs = "/Domain:$domainOrWorkgroup /UserD:$username /PasswordD:$passwordPlain"
netdom join $env:COMPUTERNAME $netdomArgs

# Mostrar mensaje de éxito
Write-Host "Se ha sido unido correctamente al dominio/grupo de trabajo: $domainOrWorkgroup"
Write-Host ""
Write-Host "Se reinicara automaticamente en POCOS segundos"

# Reiniciar el equipo para aplicar los cambios
Restart-Computer -Force -Delay 30
Pause