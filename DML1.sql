Hay varias como: insert, select, update,  delete, merge y explain plan.

Ejemplo de Inserción
Inserte una nueva fila que contiene valores por cada columna:
INSERT INTO B_AREAS VALUES (1, 'GERENCIA GENERAL',
TO_DATE('01-01-1990', 'DD-MM-YYYY'), 'S', NULL);

Cuando no existen datos para ciertas columnas:
Método implícito 
• Omita la columna de la lista de la columnas
INSERT INTO B_AREAS (ID, NOMBRE_AREA, FECHA_CREA, ACTIVA) 
VALUES (1, 'GERENCIA GENERAL', TO_DATE('01-01-1990', 'DD-MM-
YYYY'), 'S');
Método explícito 
• Especifique la palabra NULL en la lista de valores.
INSERT INTO B_AREAS VALUES (1, 'GERENCIA GENERAL', 
TO_DATE('01-01-1990', 'DD-MM-YYYY'),'S', NULL);

Insertando Valores Especiales
• La función USER registra el nombre del usuario actual
• La función SYSDATE registra la fecha y hora actual
INSERT INTO B_DIARIO_CABECERA (ID, FECHA, CONCEPTO,
USUARIO, FECHA_CIERRE, ID_AREA) VALUES (1, 
to_date('03-01-2013', 'dd-mm-yyyy'), 'APORTE DE CAPITAL 
INICIAL',USER,SYSDATE, 3);

Uso de ‘variables de sustitución
 Permite el ingreso interactivo de valores mediante parámetros  (variables de sustitución)
INSERT INTO B_AREAS (ID, NOMBRE_AREA, FECHA_CREA, 
ACTIVA) VALUES
(&pid,'&pnombre_area','&fecha_crea','&pactiva');
Introduzca un valor para pid: 1
Introduzca un valor para pnombre_area :GERENCIA 
Introduzca un valor para fecha_crea : 03/04/14
Introduzca un valor para pactiva : S

Ceando un script con Prompts customizados
• El comando ACCEPT del SQL*Plus almacena valores en una variable.
• Con PROMPT puede desplegar un texto personalizado.

ACCEPT pid NUMBER PROMPT 'Introduzca un valor para ID:';
ACCEPT pnombre_area CHAR PROMPT 'Ingrese nombre de Area:';
ACCEPT pfecha_crea DATE PROMPT 'Ingrese Fecha:';
ACCEPT pactiva CHAR PROMPT 'Ingrese Estado:';
INSERT INTO B_AREAS (ID, NOMBRE_AREA, FECHA_CREA, ACTIVA) 
VALUES (&pid,'&pnombre_area','&pfecha_crea','&pactiva');

Copiando Registros de otra Tabla
Insert into b_empleados (CEDULA, NOMBRE, APELLIDO, 
FECHA_ING, FECHA_NACIM, TELEFONO, DIRECCION, 
BARRIO)
select to_number(cedula), nombre, apellido, sysdate, 
to_date(fecha_nacimiento,'dd/mm/yyyy'), telefono, 
direccion, 'CENTRO' from b_personas where id=1;

Es posible utilizar un subquery en lugar de una tabla en la cláusula INTO:
Facultad Politécnica Base de Datos II
INSERT INTO
(select CEDULA, NOMBRE, APELLIDO, FECHA_ING, 
FECHA_NACIM, TELEFONO, DIRECCION, BARRIO 
from b_empleados where cedula = '1309873')
values ('3524610', 'JUAN', 'PORTILLO', SYSDATE, 
to_date('02/08/86','dd/mm/yyyy'), '345-865', 
'ESPAÑA 345', 'CARMELITAS');


Use WITH CHECK OPTION para evitar que se inserten valores no contemplados en el subquery
INSERT INTO
(select CEDULA, NOMBRE, APELLIDO, FECHA_ING, FECHA_NACIM, 
TELEFONO, DIRECCION, BARRIO from b_empleados where
BARRIO ='CENTRO' WITH CHECK OPTION)
values ('3524612','JUAN','PORTILLO', SYSDATE, 
to_date('02/08/86','dd/mm/yyyy'),'345-865','ESPAÑA 
345', 'CENTRO');


Inserción en múltiples tablas - Sintaxis
INSERT [ALL] [clausula de insert condicional]
[valores de la cláusula insert]
(SUBQUERY)
En donde la cláusula de INSERT condicional puede ser
[ALL] [FIRST]
[WHEN condicion THEN] [valores de la cláusula INSERT]
[ELSE] [valores de la cláusula INSERT]

INSERT ALL Incondicional
CREATE TABLE CLIENTES_CANTIDADES (ID_CLIENTE 
NUMBER, CANTIDAD NUMBER);
CREATE TABLE CLIENTES_MONTOS(ID_CLIENTE 
NUMBER, MONTO NUMBER);

INSERT ALL
INTO clientes_cantidades VALUES (id_cliente, 
cantidad)
INTO clientes_montos VALUES (id_cliente, 
monto_total)
SELECT id_cliente, count(*) cantidad, 
sum(monto_total) monto_total
FROM b_ventas group by id_cliente;

INSERT ALL Condicional
CREATE TABLE CLIENTES_MAYORISTAS (ID_CLIENTE NUMBER, MONTO NUMBER); 
CREATE TABLE CLIENTES_IDEN (ID_CLIENTE NUMBER, MONTO NUMBER);
CREATE TABLE CLIENTES_MINORISTAS (ID_CLIENTE NUMBER, MONTO NUMBER);

INSERT ALL
WHEN monto_total < 1000000 THEN Dependiendo del monto de venta,
INTO clientes_MINORISTAS clientes_mayoristas
WHEN monto_total>=1000000 THEN
INTO clientes_MAYORISTAS
WHEN id_cliente <10 THEN Si ademas el codigo es menor a 10,
INTO clientes_IDEN
SELECT id_cliente, sum(monto_total) monto_total
FROM b_ventas 
group by id_cliente;s

INSERT FIRST Condicional
INSERT FIRST
WHEN id_cliente <10 THEN
INTO clientes_IDEN
WHEN monto_total < 1000000 THEN
INTO clientes_MINORISTAS Inserta en la tabla con la primera
WHEN monto_total>=1000000 THEN
INTO clientes_MAYORISTAS
SELECT id_cliente, sum(monto_total) monto_total
FROM b_ventas 
group by id_cliente;s

