::[Bat To Exe Converter]
::
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFBpQQQ2MAFuzBaEJ+u3o0+OErUMSGus8d+8=
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF65
::cxAkpRVqdFKZSjk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpCI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJhZksaHErSXA==
::ZQ05rAF9IBncCkqN+0xwdVsFAlXi
::ZQ05rAF9IAHYFVzEqQIWi9pXRQjCD0iKZg==
::eg0/rx1wNQPfEVWB+kM9LVsJDAKDP2K2FbYMiA==
::fBEirQZwNQPfEVWB+kM9LVsJDAKDP2K2FbYMiA==
::cRolqwZ3JBvQF1fEqQIDCysUUESjKG60Erpc3O337viCsQ0BFMsxf8Gb8LudNeVT2ErpcIQitg==
::dhA7uBVwLU+EWHiQ8UwkJ1t3QwiNMWmzB9U=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATE2WsEaEkaHGQ=
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCuDJHaU4Es9PQgUfBaLMW6GVuMjzun45ua0gX1TUfo6GA==
::YB416Ek+ZG8=
::
::
::978f952a14a936cc963da21a135fa983
@echo off
setlocal
title Copiado Facil y Seguro :: Atento Telares
color 6

set /p puerto_servidor="PUERTO: "
set /p usuario_servidor="USUARIO SERVIDOR: "
set /p ip_servidor="IP SERVIDOR: "
set /p origen_servidor="ORIGEN SERVIDOR: "
set /p destino_local="DESTINO LOCAL: "

scp -P %puerto_servidor% %usuario_servidor%@%ip_servidor%:%origen_servidor% %destino_local%

if %errorlevel% equ 0 (
    color 2
    echo.
    echo La transferencia de informacion fue exitosa.
) else (
    color 4
    echo.
    echo OJO: Hubo un error al intentar la conexion.
)

echo Autor: @josuerom
echo.
pause