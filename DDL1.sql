--Creación Tablas: Sintaxis básica
CREATE TABLE [esquema.]nombretabla
(columna tipo_dato [DEFAULT
expr]
[cláusula_constraint_de_columna], 
...
[cláusula_constraint_de_tabla])
[TABLESPACE nombre_tablespace]
[PARTITION cláusula_partición]
[PCTFREE entero]
[PCTUSED entero]
[STORAGE (claúsula de storage)]
[LOGGING | NOLOGGING]
[CACHE | NOCACHE] ;

La Opción DEFAULT
Se puede especificar un valor predefinido para una columna durante una inserción.
Fecha_inicio DATE DEFAULT SYSDATE,...
• Los valores legales son generalmente valores literales, expresiones, o 
funciones SQL como SYSDATE o USER
• No se puede poner por default el nombre de otra columna
• Los valores predefinidos (default) deben emparejar el tipo de dato de la columna.

Creación de Tablas - Ejemplo
CREATE TABLE dept
(deptno NUMBER(2), 
dname VARCHAR2(14), 
loc VARCHAR2(13), 
create_date DATE DEFAULT SYSDATE); 
Table created.

Confirme la creación de la tabla
DESCRIBE dept

Constraints:
Previene eliminaciones de una tabla si hay dependencias.
Los tipos de constraints siguientes son válidos en Oracle:
• NOT NULL
• UNIQUE
• PRIMARY KEY
• FOREIGN KEY
• CHECK

Ejemplos de constraints
Restricción de nivel de columna: 
CREATE TABLE employees( 
employee_id NUMBER(6) 
CONSTRAINT emp_emp_id_pk PRIMARY KEY,
first_name VARCHAR2(20), 
...); 

Restricción de nivel de tabla: 
CREATE TABLE employees( 
employee_id NUMBER(6), 
first_name VARCHAR2(20), 
... 
job_id VARCHAR2(10) NOT NULL, 
CONSTRAINT emp_emp_id_pk
PRIMARY KEY (EMPLOYEE_ID)); 


El constraint UNIQUE
Impide que una columna o combinación de columnas tenga valores repetidos.
Se define a nivel de COLUMNA o a nivel de TABLA
CREATE TABLE employees( 
employee_id NUMBER(6), 
last_name VARCHAR2(25) NOT NULL, 
email VARCHAR2(25), 
salary NUMBER(8,2), 
commission_pct NUMBER(2,2), 
hire_date DATE NOT NULL, 
... 
CONSTRAINT emp_email_uk UNIQUE(email));

El constraint foreign key - ejemplo:
CREATE TABLE employees( 
employee_id NUMBER(6), 
last_name VARCHAR2(25) NOT NULL, 
email VARCHAR2(25), 
salary NUMBER(8,2), 
commission_pct NUMBER(2,2), 
hire_date DATE NOT NULL, 
... 
department_id NUMBER(4), 
CONSTRAINT emp_dept_fk FOREIGN KEY(department_id) 
REFERENCES departments(department_id), 
CONSTRAINT emp_email_uk UNIQUE(email));

* En la columna que es fk solo se pueden insertar, eliminar o modificar datos que existan en esa columna, en caso contrario se debe añadir el dato primero a la primary key.
* ON DELETE CASCADE: Suprime las filas dependientes de la tabla secundaria si
se suprime una fila de la tabla principal 
* ON DELETE SET NULL: Convierte valores clave de clave foránea dependientes en valores nulos
No se puede suprimir una fila que contenga una clave primaria que se utilice como clave foránea en otra tabla.


 
