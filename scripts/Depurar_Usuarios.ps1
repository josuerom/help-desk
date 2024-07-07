If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
   Write-Warning "¡ANIMAL! Debes ejecutar este script como administrador."
   Exit
}
function EliminarCarpetasUsuarios {
   $carpetasExcluidas = @("soporte", "public", "default", "all users", "default user")
   $carpetasUsuarios = Get-ChildItem -Path C:\Users | Where-Object { 
      $_.PSIsContainer -and 
      $carpetasExcluidas -notcontains $_.Name.ToLower()
   }
   $totalCarpetas = $carpetasUsuarios.Count
   $contador = 0
   foreach ($carpeta in $carpetasUsuarios) {
      $contador++
      Write-Output "Eliminando carpeta de usuario: $($carpeta.FullName) ($contador de $totalCarpetas)"
      # Eliminar la carpeta
      Remove-Item -Path $carpeta.FullName -Recurse -Force -ErrorAction SilentlyContinue
      # Mostrar barra de estado
      $porcentaje = [math]::Round(($contador / $totalCarpetas) * 100)
      Write-Progress -Activity "Eliminando carpetas de usuarios" -Status "Progreso $porcentaje%" -PercentComplete $porcentaje
   }
}
function EliminarRegistrosPerfil {
   $registrosExcluidos = @("*18", "*19", "*20", "*500")
   $subdirectorios = Get-ChildItem -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList\" | Where-Object { $_.PSIsContainer }
   foreach ($subdir in $subdirectorios) {
      $nombreDirectorio = $subdir.Name
      if (-not ($registrosExcluidos -contains $nombreDirectorio)) {
         Write-Output "Eliminando registro de perfil: $($subdir.FullName)"
         Remove-Item -Path $subdir.FullName -Recurse -Force -ErrorAction SilentlyContinue
      }
   }
}
EliminarCarpetasUsuarios
EliminarRegistrosPerfil
Write-Output "DEPURACION DE USUARIOS COMPLETA.`n"
Write-Output "Autor: @josuerom"
Start-Sleep -Seconds 4
Restart-Computer -Force