# Verificar si el script se esta ejecutando con privilegios de administrador
If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
   Write-Warning "¡ANIMAL! Debes ejecutar este script como administrador."
   Exit
}
# Funcion para obtener informacion del sistema
function Get-SystemInfo {
   Write-Output "         Informacion del Sistema"
   Write-Output "========================================="
   Get-ComputerInfo | Select-Object CsName, WindowsVersion, WindowsBuildLabEx, OsArchitecture, CsProcessors, CsTotalPhysicalMemory
}
# Funcion para reiniciar un servicio específico
function Restart-ServiceByName {
   param(
      [string]$serviceName
   )
   Write-Output "Reiniciando el servicio: $serviceName"
   Restart-Service -Name $serviceName -Force
}
# Funcion para limpiar la cache de Windows Update
function Clear-WindowsUpdateCache {
   Write-Output "Deteniendo servicios relacionados con Windows Update..."
   Stop-Service -Name wuauserv -Force
   Stop-Service -Name bits -Force
   Stop-Service -Name cryptsvc -Force

   Write-Output "Eliminando archivos de la cache de Windows Update..."
   Remove-Item -Path "C:\Windows\SoftwareDistribution\*" -Recurse -Force
   Remove-Item -Path "C:\Windows\System32\catroot2\*" -Recurse -Force

   Write-Output "Iniciando servicios relacionados con Windows Update..."
   Start-Service -Name wuauserv
   Start-Service -Name bits
   Start-Service -Name cryptsvc

   Write-Output "Cache de Windows Update limpiada."
}
# Funcion para desinstalar una aplicacion por nombre
function Uninstall-Application {
   param(
      [string]$appName
   )
   $app = Get-WmiObject -Query "SELECT * FROM Win32_Product WHERE Name = '$appName'"
   if ($app) {
      Write-Output "Desinstalando la aplicacion: $appName"
      $app.Uninstall()
      Write-Output "Aplicacion desinstalada: $appName"
   } else {
      Write-Warning "Aplicacion no encontrada: $appName"
   }
}
# Funcion para reparar la imagen de Windows
function Repair-WindowsImage {
   Write-Output "Reparando la imagen de Windows..."
   DISM /Online /Cleanup-Image /RestoreHealth
   Write-Output "Reparacion de la imagen de Windows completada."
}
# Funcion para limpiar la carpeta Temp
function Clear-TempFolder {
   Write-Output "Limpiando la carpeta Temp..."
   Remove-Item -Path "$env:temp\*" -Recurse -Force
   Write-Output "Carpeta Temp limpiada."
}
# Funcion para actualizar todas las aplicaciones de Microsoft Store usando winget
function Update-MSStoreApps {
   Write-Output "Actualizando todas las aplicaciones de Microsoft Store..."
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
   Write-Output "Actualizacion de aplicaciones de Microsoft Store completada."
}
# Menú de opciones
function Show-Menu {
   Write-Output ""
   Write-Output "=============================================="
   Write-Output "::::: HELP-DESK TOOLKIT  --  [@josuerom] :::::"
   Write-Output "=============================================="
   Write-Output "1. Obtener informacion del sistema"
   Write-Output "2. Reiniciar un servicio"
   Write-Output "3. Limpiar cache de Windows Update"
   Write-Output "4. Desinstalar una aplicacion"
   Write-Output "5. Reparar la imagen de Windows"
   Write-Output "6. Limpiar la carpeta Temp"
   Write-Output "7. Actualizar aplicaciones de Microsoft Store"
   Write-Output "0. Salir"
   Write-Output "=============================================="
}
# Funcion principal para ejecutar el menú
function Main {
   $exit = $false
   while (-not $exit) {
      Show-Menu
      $choice = Read-Host "Seleccione una opcion"
      switch ($choice) {
         1 { Get-SystemInfo }
         2 { 
            $serviceName = Read-Host "Ingrese el nombre del servicio"
            Restart-ServiceByName -serviceName $serviceName
         }
         3 { Clear-WindowsUpdateCache }
         4 { 
            $appName = Read-Host "Ingrese el nombre de la aplicacion"
            Uninstall-Application -appName $appName
         }
         5 { Repair-WindowsImage }
         6 { Clear-TempFolder }
         7 { Update-MSStoreApps }
         0 { $exit = $true }
         default { Write-Warning "Opcion no valida, intente de nuevo." }
      }
   }
}
# Ejecutar programa
Main