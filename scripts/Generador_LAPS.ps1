# Importar módulos necesarios
Import-Module AdmPwd.PS
Import-Module ActiveDirectory

# Función para obtener y exportar la contraseñas
function Get-LAPSPassword {
   param (
      [string]$hostname
   )
   # Write-Output "Generando LAPS para el host: $hostname"
   try {
      # Obtener el objeto de computadora desde Active Directory
      $computer = Get-ADComputer -Identity $hostname -Server "local.atento.com.co" -ErrorAction Stop
      # Obtener la contraseña LAPS del usuario "soporte"
      $lapsPassword = Get-AdmPwdPassword -ComputerName $hostname -ErrorAction Stop
      # Exportar la contraseña LAPS a un archivo de texto
      $outputFile = "Claves_LAPS.txt"
      $lapsPassword.Password | Out-File -FilePath $outputFile -Encoding ASCII
      Write-Output "Contraseñas LAPS generadas y exportada correctamente: .\$outputFile"
   }
   catch {
      Write-Error "Error al obtener los LAPS para $hostname: $_"
   }
}
# Ciclo para solicitar nombres de host y generar contraseñas LAPS hasta que se ingrese "exit"
while ($true) {
   Write-Output ""
   Write-Output "------------------------------------------------"
   Write-Output ":::::+  EXPORTADOR NUEVO DE LAPS [ATENTO] +:::::"
   Write-Output "------------------------------------------------"
   # Se debe escribir 'exit' para cerrar la ejecucion del programa
   $hostname = Read-Host "Ingrese el HOST | GRANJA ->"
   if ($hostname.ToLower() -eq "exit") {
      Exit
   }
   # Llamar a la función para generar y exportar la contraseña LAPS
   Get-LAPSPassword -hostname $hostname
}
#Pause