# Help Desk
PyScripts productivos para la ayuda inmediata de escritorio

## PowerShell:
Eliminar la carpeta del perfil de usuario:
```powershell
rmdir /S /Q c:\users\<USER>
```

Eliminar las entradas del registro relacionadas con el perfil de usuario:
```powershell
$ProfileListPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"
Get-ChildItem $ProfileListPath | ForEach-Object {
    $ProfileImagePath = $_.GetValue("ProfileImagePath")
    if ($ProfileImagePath -like "*\<USER>") {
        Remove-Item $_.PSPath -Recurse -Force
        Write-Host "Eliminado del registro: $($_.PSPath)"
    }
}
```

Asegúrate de ejecutar todos estos comandos y scripts con privilegios de administrador para que se puedan realizar todas las acciones necesarias.

## Entorno virtual
Comandos para crear entorno virtual del proyecto:
```powershell
python -m venv help-desk
help-desk\Scripts\activate
pip install --upgrade pip
deactivate
```
