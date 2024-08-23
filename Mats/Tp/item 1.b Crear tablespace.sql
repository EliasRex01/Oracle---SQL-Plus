-- b. Cree el tablespace BASEHOTELTP, creando el datafile con el tamaño calculado en el punto a. y permitiendo que se autoextienda.

CREATE TABLESPACE BASEHOTELTP
  DATAFILE '/ORANT/ORADATA/BASED2_01.dbf' SIZE 50M
  DEFAULT STORAGE (INITIAL 10K NEXT 50K
    MAXEXTENTS 100
    PCTINCREASE 0)
  ONLINE;
  

-- Eliminacion de un tablespace
DROP TABLESPACE <espacio de tablas>
  [INCLUDING CONTENTS [CASCADE CONSTRAINTS]];


-- El siguiente segmento determina el directorio por default para la creacion del datafile:
ALTER SYSTEM SET DB_CREATE_FILE_DEST = 
'$ORACLE_HOME/rdbms/dbs';

-- Posteriormente los tablespaces se generaran en el destino definido:
CREATE TEMPORARY TABLESPACE temp_demo TEMPFILE 
'temp01.dbf' SIZE 5M AUTOEXTEND ON;

-- Creacion de un segmento de rollback
CREATE [PUBLIC] ROLLBACK SEGMENT <nombre>
[TABLESPACE nombre]
[STORAGE (clausula de storage)]:

-- Creacion de un segmento de rollback
CREATE ROLLBACK SEGMENT rbs01
TABLESPACE rbs
STORAGE (INITIAL 100K NEXT 100K OPTIMAL 4M
MINEXTENTS 20 MAXEXTENTS 100);

-- Se habilita el rollback segment
ALTER ROLLBACK SEGMENT RB_TEMP ONLINE;

-- Cambio de asignacion de tablespace por defecto y tablespace temporal para el usuario SYSTEM.
ALTER USER SYSTEM TEMPORARY TABLESPACE TEMPORARY_DATA;
ALTER USER SYSTEM DEFAULT TABLESPACE USER_DATA;

-- Creación de rollback segment publico (Estimar la cantidad de segmentos de
-- rollback de acuerdo a los procesos ejecutados y a los usuarios que son conectados.
-- Se recomienda un segmento de rollback por cada 4 (cuatro) usuarios conectados)
CREATE PUBLIC ROLLBACK SEGMENT RB1 STORAGE(INITIAL 
50K NEXT 50K)
TABLESPACE ROLLBACK_DATA;
