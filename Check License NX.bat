@echo off
rem [color fondo][color letra]
color F1
title NX_Environment_variables 1.0
rem tamaño columnas y lineas
mode con cols=145 lines=40

rem etiqueta para goto
:Menu_general
cls
rem linea en blanco
echo.
echo   ===================================================================
echo   = Desarrollo: Oskar                                               =          
echo   ===================================================================
echo   = Email: Soporte@Ats-global.com                                   =                              
echo   ===================================================================
echo   = Version: 1.0                                                    =
echo   ===================================================================
echo   = Descripcion: Comprobar el estado actual de las licencias de NX  =
echo   ===================================================================
echo.
:: Recogenos nombre del servidor
set/p NombreSRV=Nombre del servidor [Maquina actual: %computername%]?
cls
echo.
:: Recogemos puerto
set/p PuertoSRV=Puerto asignado (Por defecto 28000)
cls
echo.
:: Ajustmos parametros
set LM_LICENSE_FILE=%PuertoSRV%@%NombreSRV%
:: Eliminamos ficheros antiguos
IF EXIST "Licencias.txt" IF Exist "LicenciaUso.txt" (
  del *.txt
) ELSE (
  REM Do another thing
)
:: Extramos features en bruto
"lmutil.exe" lmstat -A >> Licencias.txt
cls
:: Mostramos licencias en uso
findstr "Users (%SPLM_LICENSE_SERVER%" Licencias.txt > LicenciaUso.txt
cls
type LicenciaUso.txt
pause
exit