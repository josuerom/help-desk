If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
   Write-Warning "¡ANIMAL! Debes ejecutar este script como administrador."
   Exit
}
# Función para instalar winget si no está instalado
function Install-Winget {
   $wingetInstalled = Get-Command winget -ErrorAction SilentlyContinue
   if (-not $wingetInstalled) {
      Write-Output "Instalando winget..."
      Invoke-WebRequest -Uri "https://aka.ms/getwinget" -OutFile "$env:TEMP\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
      Add-AppxPackage -Path "$env:TEMP\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
      Remove-Item "$env:TEMP\Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.msixbundle"
      Write-Output "winget instalado."
   } else {
      Write-Output "winget ya estaba instalado."
   }
}
# Instalar winget si no está instalado
Install-Winget
# Actualizar todas las aplicaciones instaladas usando winget
$updates = winget upgrade --source msstore
foreach ($update in $updates) {
   try {
      Write-Output "Actualizando $($update.Id)..."
      winget upgrade --id $update.Id --silent --accept-package-agreements --accept-source-agreements
      Write-Output "$($update.Id) se ha actualizado correctamente."
   } catch {
      Write-Error "Error al actualizar $($update.Id): $_"
   }
}
Write-Output "Algunas aplicaciones se intentaron actualizar.`n"
Write-Output "Autor: @josuerom"
Pause