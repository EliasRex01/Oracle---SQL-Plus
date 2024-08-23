-- b. Cree el tablespace BASEHOTELTP, creando el datafile con el tamaño calculado en el punto a. y permitiendo que se autoextienda.

CREATE TABLESPACE BASEHOTELTP
DATAFILE '/ORANT/ORADATA/BASED2_01.dbf' SIZE 50M
AUTOEXTEND ON NEXT 10M MAXSIZE UNLIMITED
  DEFAULT STORAGE (INITIAL 10K NEXT 50K
  MAXEXTENTS 100
  PCTINCREASE 0)
ONLINE;


-- Eliminar el tablespace
DROP TABLESPACE BASEHOTELTP
  [INCLUDING CONTENTS AND DATAFILES [CASCADE CONSTRAINTS]];


-- El siguiente segmento determina el directorio por default para la creacion del datafile:
ALTER SYSTEM SET DB_CREATE_FILE_DEST = 
'$ORACLE_HOME/rdbms/dbs';
