@echo off
setlocal
title Copiado Facil y Seguro :: Atento Telares
color 6

set /p puerto_servidor="PUERTO: "
set /p usuario_servidor="USUARIO SERVIDOR: "
set /p ip_servidor="IP SERVIDOR: "
set /p origen_servidor="ORIGEN SERVIDOR: "
set /p destino_cliente="DESTINO LOCAL: "

echo.
scp -P %puerto_servidor% %usuario_servidor%@%ip_servidor%:%origen_servidor% %destino_cliente%

if %errorlevel% equ 0 (
    color 2
    echo.
    echo La transferencia fue exitosa.
) else (
    color 4
    echo.
    echo Error al intentar la conexion ANIMAL.
)

echo Autor: @josuerom
echo.
pause
