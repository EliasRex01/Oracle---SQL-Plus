----------------------------------------------
----------------TABLESPACE--------------------
----------------------------------------------
SET LINESIZE 100
SET PAGESIZE 500


--Ejercitario 05-Tablespace 
--Ejercicio #3
CREATE TABLESPACE BASED2B 
LOGGING 
DATAFILE 'C:\app\vegac\product\21c\oradata\XE\based2b.dbf' 
SIZE 10M REUSE 
AUTOEXTEND ON NEXT 600 MAXSIZE 20M; 

--En donde:
BASED2B --Nombre del tablespace
LOGGING --Determina si se crea registro de la sentencia en los redo log y 
	    --su correcta restauración desde backup
DATAFILE <ruta ubicación\archivo.bdf> --Ubicación del archivo dentro del disco
SIZE entero --Especifica el tamaño del tablespace, en KB o MB
REUSE --Reutiliza el archivo si ya existe o lo crea si no existe.
AUTOEXTEND ON NEXT --Cuando un tablespace se llena podemos usar esta opción 
				   --para que el tamaño del archivo o archivos de datos asociados  
				   --crezca automáticamente
				   
				   
--Considerando el punto 1.3 del TP Parte 1
--
SET LINESIZE 100
SET PAGESIZE 500
SET HEAD OFF --SACA LOS TÍTULOS

SPOOL MODIFICA_TABLESPACE.SQL

SELECT 'MOVE TABLE '||X.TNAME||' MOVE TABLESPACE BASEDATOS3;'
  FROM TAB X
 WHERE TNAME LIKE 'B_%';
 
SPOOL OFF

--Definimos ubicación por defecto de los archivos de datos

ALTER SYSTEM SET DB_CREATE_FILE_DEST = 'C:\app\vegac\product\21c\oradata\XE'; 

CREATE TABLESPACE BASED2
LOGGING
DATAFILE 'BASED2.dbf'
SIZE 40M REUSE
AUTOEXTEND ON NEXT 640 K MAXSIZE 100M;