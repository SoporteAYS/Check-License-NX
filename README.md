# Comprobación del Estado de las Licencias de NX

Este script de shell en lotes (Batch) permite comprobar el estado actual de las licencias de Siemens NX. Puede ser útil para verificar el estado de las licencias en un servidor específico y mostrar la información relevante.

## Uso

1. Ejecuta el script proporcionando los siguientes datos:
   - `NombreSRV`: El nombre del servidor de licencias (por defecto, se utiliza el nombre de la máquina actual).
   - `PuertoSRV`: El puerto asignado para el servidor de licencias (por defecto, 29000).
   
2. El script ajustará automáticamente los parámetros y recopilará información sobre las licencias de NX.

3. Se mostrará un resumen de las licencias en uso en la consola.
