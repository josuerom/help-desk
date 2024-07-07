# Verificar si el script se está ejecutando con privilegios de administrador
# If (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
# {
#    Write-Warning "¡ANIMAL! Debes ejecutar este script como administrador."
#    Exit
# }

while ($true) {
   $folderPath = Read-Host "PATH >>"
   if ($folderPath.ToLower() -eq "exit") {
      Exit
   }
   if (Test-Path $folderPath -PathType Container) {
      Invoke-Item $folderPath
   } else {
      Write-Error "El path no existe o no se puede acceder a el."
   }
   Write-Output "========================================="
   Write-Output ""
}