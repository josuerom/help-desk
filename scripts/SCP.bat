@echo off
setlocal
title SCP -- Atento Telares -- JR3
color 6

set /p puerto_servidor="PUERTO: "
set /p origen_servidor="ORIGEN SERVIDOR: "
set /p usuario_servidor="USUARIO SERVIDOR: "
set /p ip_hostname_servidor="IP-HOST SERVIDOR: "
set /p usuario_destino="USUARIO DESTINO: "
set destino=c:\users\%usuario_destino%\desktop

echo.
color 3

scp -P %puerto_servidor% %usuario_servidor%@%ip_hostname_servidor%:"%origen_servidor%" "%destino%"

if %errorlevel% equ 0 (
    color 2
    echo.
    echo EXITO. La transferencia fue exitosa.
    echo.
    pause
) else (
    color 4
    echo.
    echo ERROR. Al intentar la transferencia animal.
    echo.
    pause
)
