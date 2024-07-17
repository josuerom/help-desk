$inf = Get-CimInstance -ClassName Win32_OperatingSystem
$windowsEdition = $inf.Caption -replace "Microsoft ", ""
Write-Output "EDICION EN USO DE WINDOWS    : [ $windowsEdition ]"
$key = (wmic path SoftwareLicensingService get OA3xOriginalProductKey).Split("`n")[2].Trim()
Write-Output "LICENCIA ALOJADA DEL PRODUCTO: [ $key ]"
Write-Output "`nAutor: @josuerom"
Pause