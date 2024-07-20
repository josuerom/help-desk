@echo off
setlocal
title SCP -- Atento Telares -- JR3

color 0A
set /p ip_servidor="IP SERVIDOR: "
set /p puerto_servidor="PUERTO SERVIDOR: "
set /p usuario_servidor="USUARIO SERVIDOR: "
set /p origen_servidor="ORIGEN DEL SERVIDOR [/c/Herramientas/a.bat]: "
set /p usuario_destino="USUARIO DESTINO: "
set destino=C:\Users\%usuario_destino%\Desktop

REM set /p origen_servidor="ORIGEN SERVIDOR [/c/Bin/A.bat]: "
REM set /p usuario_destino="USUARIO DESTINO LOCAL: "
REM set ip_servidor=172.28.144.137
REM set puerto_servidor=3003
REM set usuario_servidor=josue.romero
REM set destino=C:\Users\%usuario_destino%\Desktop

echo.
scp -P %puerto_servidor% %usuario_servidor%@%ip_servidor%:%origen_servidor% "%destino%"
echo.

color 07
pause
