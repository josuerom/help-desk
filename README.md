# Help Desk
PyScripts para soporte técnico productivo

## Eliminar usuarios del todo
```powershell
net user USER /delete
```

Eliminar la carpeta del perfil de usuario:
```powershell
rmdir /s /q c:\users\USER
```

Eliminar las entradas del registro relacionadas con el perfil de usuario:
```powershell
$ProfileListPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\ProfileList"
Get-ChildItem $ProfileListPath | ForEach-Object {
    $ProfileImagePath = $_.GetValue("ProfileImagePath")
    if ($ProfileImagePath -like "*\shifu_1") {
        Remove-Item $_.PSPath -Recurse -Force
        Write-Host "Eliminado del registro: $($_.PSPath)"
    }
}
```

Asegúrate de ejecutar todos estos comandos y scripts con privilegios de administrador para que se puedan realizar todas las acciones necesarias.

Comandos para crear entorno virtual:
```cmd
python -m venv env
env\Scripts\activate
pip install colorama
deactivate
```
