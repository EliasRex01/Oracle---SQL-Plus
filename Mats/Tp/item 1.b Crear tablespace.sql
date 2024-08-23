-- b. Cree el tablespace BASEHOTELTP, creando el datafile con el tamaño calculado en el punto a. y permitiendo que se autoextienda.

CREATE TABLESPACE BASEHOTELTP

  

-- Creación de Tablespace: Ejemplo
SQL> CREATE TABLESPACE BASED2
2 DATAFILE '/ORANT/ORADATA/BASED2_01.dbf' SIZE 50M
3 DEFAULT STORAGE (INITIAL 10K NEXT 50K
4    MAXEXTENTS 100
5    PCTINCREASE 0)
6 ONLINE;

-- Ampliando un tablespace: Ejemplo
SQL> ALTER TABLESPACE BASED2
2 ADD DATAFILE '/ORANT/ORADATA/BASED2_02.dbf' SIZE 50M;

-- Poniendo un tablespace fuera de línea
SQL> ALTER TABLESPACE BASED2 OFFLINE NORMAL;

-- Eliminación de un tablespace
SQL> DROP TABLESPACE <espacio de tablas>
2 [INCLUDING CONTENTS [CASCADE CONSTRAINTS]];

INCLUDING CONTENTS: Elimina todos los segmentos en el TABLESPACE
• CASCADE CONSTRAINTS: Elimina constraints de integridad referencial de las tablas fuera d

-- Espacio de tabla TEMPORARY - Ejemplo
-- El siguiente ejemplo determina el directorio por default para la creación de los datafiles:
ALTER SYSTEM SET DB_CREATE_FILE_DEST = 
'$ORACLE_HOME/rdbms/dbs';

-- Posteriormente los tablespaces se generarán en el destino definido:
CREATE TEMPORARY TABLESPACE temp_demo TEMPFILE 
'temp01.dbf' SIZE 5M AUTOEXTEND ON;

-- Creación de un segmento de rollback
CREATE [PUBLIC] ROLLBACK SEGMENT <nombre>
[TABLESPACE nombre]
[STORAGE (clausula de storage)]:

-- Creación de un segmento de rollback
CREATE ROLLBACK SEGMENT rbs01
TABLESPACE rbs
STORAGE (INITIAL 100K NEXT 100K OPTIMAL 4M
MINEXTENTS 20 MAXEXTENTS 100);

-- Se habilita el rollback segment
ALTER ROLLBACK SEGMENT RB_TEMP ONLINE;

-- Cambio de asignación de tablespace por defecto y tablespace temporal para el usuario SYSTEM.
ALTER USER SYSTEM TEMPORARY TABLESPACE TEMPORARY_DATA;
ALTER USER SYSTEM DEFAULT TABLESPACE USER_DATA;

-- Creación de rollback segment público (Estimar la cantidad de segmentos de
-- rollback de acuerdo a los procesos ejecutados y a los usuarios que son conectados.
-- Se recomienda un segmento de rollback por cada 4 (cuatro) usuarios conectados)
CREATE PUBLIC ROLLBACK SEGMENT RB1 STORAGE(INITIAL 
50K NEXT 50K)
TABLESPACE ROLLBACK_DATA;
