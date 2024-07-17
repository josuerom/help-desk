# Verificar si el script se está ejecutando con privilegios de administrador
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
   Write-Warning "¡ANIMAL! Debes ejecutar este script como administrador."
   Exit
}
# Ruta del registro para habilitar la aplicación Recortes
$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\TabletPC"
# Verificar si la clave del registro existe
if (-not (Test-Path $registryPath)) {
   Write-Output "No existe clave del registro: $registryPath"
} else {
   # Establecer el valor del registro para permitir la aplicación Recortes
   Set-ItemProperty -Path $registryPath -Name "DisableSnippingTool" -Value 0 -Type DWord -Force
   Write-Output "La aplicacion Recortes (SnippingTool) ha sido habilitada."
}
Write-Output "`nAutor: @josuerom"
Pause