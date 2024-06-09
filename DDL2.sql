El constraint CHECK
Define una condición que debe satisfacer cada fila 
• No se permiten las expresiones siguientes: 
• Referencias a las pseudo columnas CURRVAL, NEXTVAL, 
LEVEL y ROWNUM
• Llamadas a las funciones SYSDATE, UID, USER y USERENV
• Consultas que hagan referencia a otros valores de otras filas
..., salary NUMBER(2) 
CONSTRAINT emp_salary_min
CHECK (salary > 0),...

Creación de Tabla: Ejemplo
SQL> CREATE TABLE p_departamento
2 (id NUMBER(7)
3 CONSTRAINT p_departamento_id_pk PRIMARY KEY,
4 descripcion VARCHAR2(25)
5 CONSTRAINT p_departamento_nombre_nn NOT NULL,
6 id_localidad NUMBER(7)
7 CONSTRAINT p_departamento_localidad_id_fk REFERENCES
8 p_localidad (id),
9 CONSTRAINT s_dept_desc_localidad_id_uk UNIQUE
10 (descripcion, id_localidad));

Creación de Tabla – Cláusula Storage
CREATE TABLE B_CUENTAS
(CODIGO_CTA NUMBER(7) not null CONSTRAINT PKCUENTAS 
PRIMARY KEY,
NOMBRE_CTA VARCHAR2(40) not null,
ID_TIPO NUMBER(4) not null,
NIVEL NUMBER(1) not null,
CTA_SUPERIOR NUMBER(7),
ORDEN VARCHAR2(1) not null,
FECHA_APERTURA DATE default SYSDATE not null,
IMPUTABLE VARCHAR2(1) default 'S' not null)
TABLESPACE BASEDATOS2
STORAGE (INITIAL 50K NEXT 10K
MAXEXTENTS 100
PCTINCREASE 0);

División de tablas en tablespaces según su rango
CREATE TABLE emp_adm
( empno NUMBER(5) PRIMARY KEY,
nombre VARCHAR2(15) NOT NULL,
titulo VARCHAR2(10),
jefe NUMBER(5),
fecha_ingreso DATE DEFAULT (sysdate),
salario NUMBER(7,2),
id_dpto NUMBER(3) NOT NULL)
PARTITION BY RANGE(empno)
(PARTITION emp1000 VALUES LESS THAN (1000) 
TABLESPACE admin_tbs,
PARTITION emp2000 VALUES LESS THAN (2000) 
TABLESPACE admin_tbs2);


División de tablas en tablespaces según una lista
Supongamos que las localidades estuvieran identificadas 
en aquellas que son de la región Oriental y Occidental:
CREATE TABLE localidades
(id NUMBER(5) PRIMARY KEY,
nombre VARCHAR2(15) NOT NULL,
region VARCHAR2(2) NOT NULL)
PARTITION BY LIST (region)
(PARTITION occidental VALUES ('OC') TABLESPACE 
basedatos2,
PARTITION oriental VALUES ('OR') TABLESPACE 
based2b);

Creación de una tabla a partir de un subquery - Ejemplo
Cree una tabla que contiene a todos los empleados de la categoría
salarial 56
CREATE TABLE vendedores AS
SELECT e.cedula, e.nombre, e.apellido, 
e.fecha_ing
FROM b_empleados e, b_posicion_actual p
WHERE e.cedula = p.cedula
AND p.cod_categoria = 56;
No se olvide de que sólo se copia el constraint NOT NULL

Consultas al Diccionario de la Base de Datos
- Listando todas las vistas del DD a los que el usuario tiene acceso.
SQL> SELECT *
2 FROM DICTIONARY;

- Desplegando la estructura de la vista de USER_OBJECTS
SQL> DESCRIBE user_objects

- Desplegando todos los nombres de objetos que usted posee.
SQL> SELECT object_name
2 FROM user_objects
3 WHERE object_type = 'TABLE';

- Busque tablas de diccionario de datos en temas específicos en la columna de los COMENTARIOS de la tabla del DICCIONARIO
SQL> SELECT *
2 FROM dictionary
3 WHERELOWER(comments) LIKE '%grant%';

Vista USER_OBJECTS
SELECT object_name, object_type, 
created, status 
FROM user_objects 
ORDER BY object_type; 

- Información de columna – USER_TAB_COLUMNS
SELECT column_name, data_type, data_length, 
data_precision, data_scale, nullable
FROM user_tab_columns
WHERE table_name = 'EMPLOYEES'; 

- Verifique los constraints en la tabla de B_AREAS
SELECT constraint_name, constraint_type, 
search_condition, r_constraint_name, 
delete_rule, status 
FROM user_constraints
WHERE table_name = 'EMPLOYEES';
