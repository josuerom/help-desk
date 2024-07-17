$key = (wmic path SoftwareLicensingService get OA3xOriginalProductKey).Split("`n")[2].Trim()
Write-Output "LICENCIA ALOJADA DEL PRODUCTO: [ $key ]`n"
if ($key -ne "") {
   Write-Output "Eliminando la clave de producto actual...`n"
   cscript //B //NoLogo "%windir%\System32\slmgr.vbs" /upk
} else {
   Write-Output "No se encontro una clave de producto para eliminar.`n"
}
do {
   $newKey = Read-Host "Ingrese la nueva clave de producto >>"
   if ($newKey -eq "") {
      Write-Output "Debe ingresar una clave de producto valida.`n"
   }
} while ($newKey -eq "")
cscript //B //NoLogo "%windir%\System32\slmgr.vbs" /ipk $newKey
Write-Output "Activando la nueva clave de producto...`n"
cscript //B //NoLogo "%windir%\System32\slmgr.vbs" /ato
Write-Output "----------------------------------"
Write-Output "::  CLAVE DE PRODUCTO ACTIVADA  ::"
Write-Output "----------------------------------"
Write-Output "`nAutor: @josuerom"
Pause