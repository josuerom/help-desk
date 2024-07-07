# Verificar si el script se está ejecutando con privilegios de administrador
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
   Write-Warning "¡ANIMAL! Debe ejecutar este script como administrador."
   Exit
}
# Ruta del registro para habilitar la lectura de USB
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\RemovableStorageDevices"
# Verificar si la clave del registro existe
if (-not (Test-Path $registryPath)) {
   # Write-Output "Creando la clave del registro: $registryPath"
   # New-Item -Path $registryPath -Force | Out-Null
}
# Establecer el valor del registro para permitir todos los dispositivos USB
Set-ItemProperty -Path $registryPath -Name "Deny_All" -Value 0 -Type DWord -Force
Write-Output "Ahora ingrese la USB."
Write-Output "Si no funciona ejecute nuevamente!"

# Reiniciar para aplicar los cambios (opcional dependiendo de las políticas del dominio)
#Restart-Computer -Force
Pause