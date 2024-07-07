:: BAT Test Template
@echo off
title ATENTO A TI - COLOMBIA
color 2
echo COMENZANDO A HACKEAR...
echo.
echo Espere un momento...
cd /d %~dp0 >nul 2>&1
>nul 2>&1 reg add hkcu\software\classes\.Admin\shell\runas\command /f /ve /d "cmd /x /d /r set \"f0=%%2\"& call \"%%2\" %%3"& set _= %*
>nul 2>&1 fltmc|| if "%f0%" neq "%~f0" (cd.>"%temp%\runas.Admin" & start "%~n0" /high "%temp%\runas.Admin" "%~f0" "%_:"=""%" & exit /b)
>nul 2>&1 reg delete hkcu\software\classes\.Admin\ /f
>nul 2>&1 del %temp%\runas.Admin /f /q 

::=================================================================

pushd %temp% >nul 2>&1
echo.
echo jajajajajajaja...
echo.
@set "0=%~f0" &powershell -nop -c $f=[IO.File]::ReadAllText($env:0)-split':KMS_Suite\:.*';iex($f[1]); X(1) >nul 2>&1
cmd.exe /c act.bat -suite
:: Esto no realiza NADA MALO porque no existe el .bat 'act.bat'
pause