Introduzca el nombre de usuario: /as sysdba      -- ingresar como usuario sistema
Conectado a:
Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
Version 21.3.0.0.0
SQL> ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;     -- permitir alteraciones
Sesion modificada.
SQL> CREATE USER bd2_rex IDENTIFIED BY "1231329"      -- crear usuario
  2  DEFAULT TABLESPACE "USERS"
  3  TEMPORARY TABLESPACE "TEMP"
  4  ;
Usuario creado.
SQL> ALTER USER bd2_rex QUOTA UNLIMITED ON USERS;      -- asignar uso ilimitado del espacio
Usuario modificado.
SQL> GRANT CREATE SESSION TO bd2_rex;                  -- asignar inicio de sesion
Concesi≤n terminada correctamente.
SQL> GRANT "RESOURCE" TO bd2_rex;                  -- asignar rol resource a usuario
Concesion terminada correctamente.
SQL> ALTER USER bd2_rex DEFAULT ROLE "RESOURCE";         -- habilitar rol por defecto como resource para el usuario
Usuario modificado.

SQL> show user con_name;
USER es bd2_rex

CON_NAME
................................................
CDB$RESOURCE



-- Para las clases y examenes de bd2
SQL> CREATE USER basedatos2 IDENTIFIED BY "basedatos2"      -- crear usuario
  2  DEFAULT TABLESPACE "BASEDATOS2"
  3  TEMPORARY TABLESPACE "TEMP"
  4  GRANT DBA ;
Usuario creado.
SQL> ALTER USER basedatos2 QUOTA UNLIMITED ON USERS;      -- asignar uso ilimitado del espacio
Usuario modificado.
SQL> GRANT CREATE SESSION TO basedatos2;                  -- asignar inicio de sesion
Concesi≤n terminada correctamente.
SQL> GRANT "RESOURCE" TO basedatos2;                  -- asignar rol resource a usuario
Concesion terminada correctamente.
SQL> ALTER USER basedatos2 DEFAULT ROLE "RESOURCE";         -- habilitar rol por defecto como resource para el usuario
Usuario modificado.

-- ConectandoIntroduzca el nombre de usuario: basedatos2/basedatos2
Conectado a:
Oracle Database 21c Express Edition Release 21.0.0.0.0 - Production
Version 21.3.0.0.0
SQL> ALTER SESSION SET "_ORACLE_SCRIPT"=TRUE;     -- permitir alteraciones
Sesion modificada.
