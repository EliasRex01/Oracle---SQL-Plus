-- b. Cree el tablespace BASEHOTELTP, creando el datafile con el tamaño calculado en el punto a. y permitiendo que se autoextienda. 

--Definimos ubicación por defecto de los archivos de datos
ALTER SYSTEM SET DB_CREATE_FILE_DEST = 'C:\app\vegac\product\21c\oradata\XE'; 

CREATE TABLESPACE BASEHOTELTP
LOGGING
DATAFILE 'BASEHOTELTP.dbf'
SIZE 40M REUSE
AUTOEXTEND ON NEXT 640 K MAXSIZE 100M
ONLINE;

-- Genere con SPOOL un script que selecciones todas las tablas del trabajo práctico (que comiencen con H_), y las mueva al tablespace BASEHOTELTP. Una vez generado el script,
-- ejecútelo para mover efectivamente las tablas.


SET LINESIZE 100
SET PAGESIZE 500
SET HEAD OFF --SACA LOS TÍTULOS

SPOOL MOVER_TABLESPACE.SQL

SELECT  'MOVE TABLE'  || X.TNAME || 'MOVE TABLESPACE BASEHOTELTP;'
FROM TAB X
WHERE X.tname LIKE 'H_%' ESCAPE '\'

SPOOL OFF
