@echo off
setlocal
title SCP -- Atento Telares -- JR3
color 6

set /p puerto_servidor="PUERTO: "
set /p usuario_servidor="USUARIO SERVIDOR: "
set /p ip_servidor="IP-HOST SERVIDOR: "
set /p origen_servidor="ORIGEN SERVIDOR: "
set /p destino_cliente="DESTINO CLIENTE: "

echo.
scp -P %puerto_servidor% %usuario_servidor%@%ip_servidor%:%origen_servidor% %destino_cliente%

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
