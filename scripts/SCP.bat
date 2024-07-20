@echo off
setlocal
title SCP -- Atento Telares -- JR3

color 2
set /p ip_servidor="IP SERVIDOR: "
set /p puerto_ssh="PUERTO SERVIDOR: "
set /p usuario_servidor="USUARIO SERVIDOR: "
set /p origen_servidor="ORIGEN SERVIDOR [c:\apps\act.bat]: "
set /p usuario_destino="USUARIO DESTINO: "
set destino=C:\Users\%usuario_destino%\Desktop

echo.
scp -P %puerto_ssh% %origen_servidor% %usuario_servidor%@%ip_servidor%:%destino%
color 3

echo.
color 7
pause
