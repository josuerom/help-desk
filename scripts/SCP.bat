@echo off
setlocal
title (SCP | Atento Telares | JR3)

color 0A
set /p ip_servidor="IP SERVIDOR -> "
set /p puerto_servidor="PUERTO SERVIDOR -> "
set /p usuario_servidor="USUARIO SERVIDOR -> "
set /p origen_servidor="ORIGEN DEL SERVIDOR [/c/Herramientas/abc.bat] -> "
set /p usuario_destino="USUARIO DESTINO -> "
set destino=C:\Users\%usuario_destino%\Desktop

REM set /p origen_servidor="ORIGEN SERVIDOR [/c/Bin/Push.bat]: "
REM set /p usuario_destino="USUARIO DE DESTINO: "
REM set ip_servidor=172.28.144.137
REM set puerto_servidor=2002
REM set usuario_servidor=josue.romero
REM set destino=C:\Users\%username%\Desktop

echo.
scp -P %puerto_servidor% %usuario_servidor%@%ip_servidor%:%origen_servidor% "%destino%"
echo.

color 07
pause
