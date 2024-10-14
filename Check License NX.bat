@echo off
setlocal enabledelayedexpansion

:: Configuración de la consola
color F1
title NX_Environment_variables 1.1
mode con cols=145 lines=40

:: Función para centrar texto
:CenterText
set "text=%~1"
for /f "tokens=2" %%a in ('mode con ^| find "Columns"') do set "columns=%%a"
set /a "padding=(!columns!-2-len("%text%"))/2"
set "centered_text="
for /l %%i in (1,1,!padding!) do set "centered_text=!centered_text! "
set "centered_text=!centered_text!%text%"
echo !centered_text!
goto :eof

:Menu_general
cls
echo.
call :CenterText "==================================================================="
call :CenterText "= Desarrollo: Oskar                                               ="
call :CenterText "==================================================================="
call :CenterText "= Email: Soporte@Ats-global.com                                   ="
call :CenterText "==================================================================="
call :CenterText "= Version: 1.1                                                    ="
call :CenterText "==================================================================="
call :CenterText "= Descripcion: Comprobar el estado actual de las licencias de NX  ="
call :CenterText "==================================================================="
echo.
echo Seleccione una opcion:
echo 1. Deteccion automatica (usando SPLM_LICENSE_SERVER)
echo 2. Configuracion manual
choice /c 12 /n /m "Ingrese su eleccion (1 o 2): "

if errorlevel 2 goto :Manual
if errorlevel 1 goto :Automatico

:Automatico
if not defined SPLM_LICENSE_SERVER (
    echo La variable SPLM_LICENSE_SERVER no esta definida.
    echo Cambiando a modo manual...
    goto :Manual
)
for /f "tokens=1,2 delims=@" %%a in ("%SPLM_LICENSE_SERVER%") do (
    set "PuertoSRV=%%a"
    set "NombreSRV=%%b"
)
echo Usando configuracion automatica:
echo Servidor: %NombreSRV%
echo Puerto: %PuertoSRV%
goto :Procesar

:Manual
:: Recoger nombre del servidor con valor por defecto
set /p "NombreSRV=Nombre del servidor [Maquina actual: %computername%]: " || set "NombreSRV=%computername%"

:: Recoger puerto con valor por defecto
set /p "PuertoSRV=Puerto asignado [Por defecto: 28000]: " || set "PuertoSRV=28000"

:Procesar
:: Ajustar parámetros
set "LM_LICENSE_FILE=%PuertoSRV%@%NombreSRV%"

:: Eliminar ficheros antiguos de manera segura
if exist "Licencias.txt" del "Licencias.txt"
if exist "LicenciaUso.txt" del "LicenciaUso.txt"

:: Extraer features y mostrar licencias en uso
echo Procesando, por favor espere...
"lmutil.exe" lmstat -A > "Licencias.txt"
findstr "Users (%NombreSRV%" "Licencias.txt" > "LicenciaUso.txt"

:: Mostrar resultados
cls
echo Licencias en uso:
echo.
type "LicenciaUso.txt"

echo.
echo Presione cualquier tecla para salir...
pause >nul
exit /b 0
