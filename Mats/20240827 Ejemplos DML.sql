--------------------------------------------------
----------------Sentencias DML--------------------
--------------------------------------------------
SET LINESIZE 100
SET PAGESIZE 500

--INSERT
DESC B_AREAS

Name             Type         Nullable Default Comments 
---------------- ------------ -------- ------- -------- 
ID               NUMBER(6)                              
NOMBRE_AREA      VARCHAR2(40)                           
FECHA_CREA       DATE                                   
ACTIVA           VARCHAR2(1)           'S'              
ID_AREA_SUPERIOR NUMBER(6)    Y                         


(select max(nvl(id,0))+1 from b_areas)

--Método explícito  
INSERT INTO B_AREAS (ID, NOMBRE_AREA, FECHA_CREA, ACTIVA) 
             VALUES ((select max(nvl(id,0))+1 from b_areas), 'RECURSOS HUMANOS', TO_DATE('27-08-2024', 'DD-MM-YYYY'), 'S');


--Método implícito  
INSERT INTO B_AREAS VALUES ((select max(nvl(id,0))+1 from b_areas), 'RECURSOS HUMANOS', TO_DATE('27-08-2024', 'DD-MM-YYYY'), 'S', NULL);

--INSERT con valores especiales
--Usando SYSDATE
INSERT INTO B_AREAS (ID, NOMBRE_AREA, FECHA_CREA, ACTIVA) 
             VALUES ((select max(nvl(id,0))+1 from b_areas), 'RECURSOS HUMANOS', SYSDATE, 'S');
			 

--Uso de variables de sustitución / Comando ACCEPT
ACCEPT pid NUMBER PROMPT 'Introduzca un valor para ID:';
ACCEPT pnombre_area CHAR PROMPT 'Ingrese nombre de Area:';
ACCEPT pfecha_crea DATE PROMPT 'Ingrese Fecha:';
ACCEPT pactiva CHAR PROMPT 'Ingrese Estado:';


INSERT INTO B_AREAS (ID, NOMBRE_AREA, FECHA_CREA, ACTIVA) 
             VALUES (&pid,'&pnombre_area','&fecha_crea',&pactiva);

Introduzca un valor para pid: 18
Introduzca un valor para pnombre_area: CRM 
Introduzca un valor para fecha_crea: 27/08/2024
Introduzca un valor para pactiva: S

--INSERT mediante un SUBQUERIES
--A nivel del VALUES
Insert into b_empleados (CEDULA, NOMBRE, APELLIDO, FECHA_ING, FECHA_NACIM, TELEFONO, DIRECCION, BARRIO)
select to_number(cedula), 
	   nombre, 
	   apellido, 
	   sysdate, 	
	   to_date(fecha_nacimiento,'dd/mm/yyyy'), 
	   telefono, 	
	   direccion, 
	   'CENTRO' 
  from b_personas 
 where id = 1;

--A nivel de la cláusuloa INTO
INSERT INTO (select CEDULA, NOMBRE, APELLIDO, FECHA_ING, 	FECHA_NACIM, TELEFONO, DIRECCION, BARRIO 
			   from b_empleados 
			  where cedula = '1309873')

     VALUES ('3524610', 
		     'JUAN', 
			 'PORTILLO', 
			 SYSDATE, 	
			 to_date('02/08/86','dd/mm/yyyy'), 
			 '345-865', 	
			 'ESPAÑA 345', 
			 'CARMELITAS');
			 
--WITH CHECK OPTION
--Especifica el nivel de comprobación cuando los datos se insertan o actualizan a través de una vista.
--Si se especifica, cada fila que se inserta o actualiza debe ajustarse a la definición (en éste caso, esa definición está en el WHERE).
INSERT INTO (select CEDULA, NOMBRE, APELLIDO, FECHA_ING, 	FECHA_NACIM, TELEFONO, DIRECCION, BARRIO 
			   from b_empleados 
			  where cedula = '1309873' WITH CHECK OPTION)

     VALUES ('3524610', 
		     'JUAN', 
			 'PORTILLO', 
			 SYSDATE, 	
			 to_date('02/08/86','dd/mm/yyyy'), 
			 '345-865', 	
			 'ESPAÑA 345', 
			 'CARMELITAS');

--INSERT en varias tablas / INSERT ALL
--INSERT ALL INCONDICIONAL
--Todas las filas recuperadas se insertan en ambas tablas
CREATE TABLE CLIENTES_CANTIDADES (ID_CLIENTE NUMBER, CANTIDAD NUMBER);
CREATE TABLE CLIENTES_MONTOS(ID_CLIENTE NUMBER, MONTO NUMBER); 

INSERT ALL
	INTO clientes_cantidades VALUES (id_cliente, cantidad)
	INTO clientes_montos VALUES (id_cliente, monto_total)	
SELECT id_cliente, 
	   count(*) cantidad, 
	   sum(monto_total) monto_total
  FROM b_ventas 
 group by id_cliente;

--INSERT ALL CONDICIONAL
--Las filas se insertan en las tablas respectivas solo si cumplen la condición WHEN
CREATE TABLE CLIENTES_MAYORISTAS (ID_CLIENTE NUMBER, MONTO NUMBER); 
CREATE TABLE CLIENTES_IDEN (ID_CLIENTE NUMBER, MONTO NUMBER);
CREATE TABLE CLIENTES_MINORISTAS (ID_CLIENTE NUMBER, MONTO NUMBER);

INSERT ALL
	WHEN monto_total < 1000000 THEN  --Dependiendo del monto de venta, inserta en clientes_MINORISTAS o clientes_MINORISTAS
		INTO clientes_MINORISTAS                              
	WHEN monto_total >= 1000000 THEN
		INTO CLIENTES_MAYORISTAS
	WHEN id_cliente < 10 THEN        --Si además el código es menor a 10, inserta también en  clientes_IDEN                          
		INTO clientes_IDEN
SELECT id_cliente, 
       sum(monto_total) monto_total
  FROM b_ventas 
 group by id_cliente;
 
--INSERT FIRST CONDICIONAL
--Inserta en la tabla con la primera tabla con la condición WHEN que se cumpla
INSERT FIRST
	WHEN id_cliente <10 THEN
		INTO clientes_IDEN
	WHEN monto_total < 1000000 THEN
		INTO clientes_MINORISTAS  
	WHEN monto_total>=1000000 THEN
		INTO clientes_MAYORISTAS		
SELECT id_cliente, 
	   sum(monto_total) monto_total
  FROM b_ventas 
 group by id_cliente;


--INSERT mediante giro
--Supongamos que tenemos una tabla VENTAS
create table VENTAS
(
  id        NUMBER(8) not null,
  dia       VARCHAR2(1),
  monto_lun NUMBER,
  monto_mar NUMBER,
  monto_mie NUMBER,
  monto_jue NUMBER,
  monto_vie NUMBER,
  monto_sab NUMBER,
  monto_dom NUMBER
);

--Insertamos los registros de prueba
insert into VENTAS (ID, DIA, MONTO_LUN, MONTO_MAR, MONTO_MIE, MONTO_JUE, MONTO_VIE, MONTO_SAB, MONTO_DOM)
values (1, '2', 0, 7215470, 0, 0, 0, 0, 0);
insert into VENTAS (ID, DIA, MONTO_LUN, MONTO_MAR, MONTO_MIE, MONTO_JUE, MONTO_VIE, MONTO_SAB, MONTO_DOM)
values (2, '4', 0, 0, 0, 8260000, 0, 0, 0);
insert into VENTAS (ID, DIA, MONTO_LUN, MONTO_MAR, MONTO_MIE, MONTO_JUE, MONTO_VIE, MONTO_SAB, MONTO_DOM)
values (3, '2', 0, 2370910, 0, 0, 0, 0, 0);
insert into VENTAS (ID, DIA, MONTO_LUN, MONTO_MAR, MONTO_MIE, MONTO_JUE, MONTO_VIE, MONTO_SAB, MONTO_DOM)
values (4, '7', 0, 0, 0, 0, 0, 0, 3233640);
insert into VENTAS (ID, DIA, MONTO_LUN, MONTO_MAR, MONTO_MIE, MONTO_JUE, MONTO_VIE, MONTO_SAB, MONTO_DOM)
values (5, '5', 0, 0, 0, 0, 3198180, 0, 0);
insert into VENTAS (ID, DIA, MONTO_LUN, MONTO_MAR, MONTO_MIE, MONTO_JUE, MONTO_VIE, MONTO_SAB, MONTO_DOM)
values (6, '4', 0, 0, 0, 4779090, 0, 0, 0);
insert into VENTAS (ID, DIA, MONTO_LUN, MONTO_MAR, MONTO_MIE, MONTO_JUE, MONTO_VIE, MONTO_SAB, MONTO_DOM)
values (7, '1', 300000, 0, 0, 0, 0, 0, 0);
commit;

--Creamos la tabla donde insertaremos los registros
create table VENTAS_SEMANALES(
	id      NUMBER(1),
	dia     NUMBER,
	monto   NUMBER);

--Ejecutamos el INSERT ALL pivotante.
--Vemos que se transforma el flujo de entrada, en este caso una tabla no relacional
--se convierte en registros para un entorno relacional.
INSERT ALL
  INTO VENTAS_SEMANALES VALUES (ID, DIA, MONTO_LUN)
  INTO VENTAS_SEMANALES VALUES (ID, DIA, MONTO_MAR)
  INTO VENTAS_SEMANALES VALUES (ID, DIA, MONTO_MIE)
  INTO VENTAS_SEMANALES VALUES (ID, DIA, MONTO_JUE)
  INTO VENTAS_SEMANALES VALUES (ID, DIA, MONTO_VIE)
  INTO VENTAS_SEMANALES VALUES (ID, DIA, MONTO_SAB)
  INTO VENTAS_SEMANALES VALUES (ID, DIA, MONTO_DOM)
  
SELECT ID,
       DIA,
       MONTO_LUN,
       MONTO_MAR,
       MONTO_MIE,
       MONTO_JUE,
       MONTO_VIE,
       MONTO_SAB,
       MONTO_DOM
  FROM VENTAS;

	
--UPDATE
--Actualiza el id de localidad de todas las personas que tienen actualmente como id_localidad el valor 2
UPDATE b_personas 
   SET id_localidad = 6
 WHERE id_localidad = 2;

--Actualiza los campos ES_PROVEEDOR e ID_LOCALIDAD para el empleado ID= 1
UPDATE b_personas 
   SET es_proveedor='S', 
       id_localidad='22'
 WHERE id = 1;

--Actualizando con el resultado del subquery
--Actualiza los empleados del conjunto resultante del subquery
UPDATE B_EMPLEADOS 
   SET CEDULA_JEFE = 1309873 
 WHERE CEDULA IN (SELECT CEDULA 
				    FROM B_EMPLEADOS 
				   WHERE CEDULA_JEFE=952160);


--Actualización de más de una columna  con el resultado de un subquery
UPDATE B_MAYOR M
   SET (ACUM_DEBITO, ACUM_CREDITO) =(SELECT NVL(SUM(DECODE(D.DEBE_HABER, 'D', D.IMPORTE, 0)),0) ACUM_DEBITO,
											NVL(SUM(DECODE(D.DEBE_HABER, 'C', D.IMPORTE, 0)),0) ACUM_CREDITO
									   FROM B_DIARIO_DETALLE D JOIN B_DIARIO_CABECERA C ON   C.ID = D.ID
									  WHERE D.CODIGO_CTA                = M.CODIGO_CTA
									    AND EXTRACT(YEAR FROM C.FECHA)  = M.ANIO
									    AND EXTRACT(MONTH FROM C.FECHA) = M.MES);

--DELETE
--Elimine toda la información de empleados que empezaron antes del 1 de enero del 2001
DELETE FROM b_personas
WHERE fecha_ing < to_date('2001-01-01','yyyy-mm-dd'); --Si no especifica WHERE borra todas las filas!

--ROWID
--La pseudo-columna ROWID devuelve la dirección de la fila en el disco
SELECT ROWID,A.ID,A.NOMBRE_AREA
  FROM B_AREAS A
 WHERE A.ID=1;

--MERGE
CREATE TABLE BONIFICACION
 (CEDULA_EMP     NUMBER(7),
  BONIFICACION   NUMBER(10));

MERGE INTO bonificacion B
	USING (SELECT cedula_vendedor cedula, 
		   SUM(monto_total) ventas
		   FROM b_ventas
		   GROUP by cedula_vendedor) E
	ON (B.cedula_emp = E.cedula)
	
	WHEN MATCHED THEN
		UPDATE SET B.bonificacion = ROUND(E.ventas * 1.05)
		
	WHEN NOT MATCHED THEN
		  INSERT (B.cedula_emp, B.bonificacion)
		  VALUES (E.cedula, ROUND(E.ventas * 1.05));

--COMMIT // A mostrar el jueves 29/08
INSERT INTO B_AREAS (ID, NOMBRE_AREA, FECHA_CREA, ACTIVA) 
             VALUES ((select max(nvl(id,0))+1 from b_areas), 'SERVICIO TECNICO', TO_DATE('27-08-2024', 'DD-MM-YYYY'), 'S');
			 
INSERT INTO B_POSICION_ACTUAL (id, 
							   cod_categoria, 
							   cedula, 
							   id_area, 
							   fecha_ini, 
							   fecha_fin)
                        VALUES(30,
							   1,
							   429987,
							   19,
							   SYSDATE,
							   NULL);
COMMIT;

--ROLLBACK
DELETE FROM	BONIFICACION;
ROLLBACK;

--EJERCITARIO 04-DML 
--#1
--Opción 1
INSERT INTO B_AREAS
(ID, NOMBRE_AREA, FECHA_CREA, ACTIVA, ID_AREA_SUPERIOR)
SELECT (SELECT MAX(ID)+1 FROM B_AREAS), 
       'Auditoria', 
       SYSDATE, 
       'S', 
       ID 
  FROM B_AREAS 
 WHERE UPPER(NOMBRE_AREA) = 'GERENCIA ADMINISTRATIVA';

--Opción 2
INSERT INTO B_AREAS
(ID, NOMBRE_AREA, FECHA_CREA, ACTIVA, ID_AREA_SUPERIOR)
VALUES ((SELECT MAX(A.ID)+1 FROM B_AREAS A), 
        'Auditoria', 
        SYSDATE, 
        'S', 
        (SELECT X.ID FROM B_AREAS X WHERE UPPER(X.NOMBRE_AREA) = 'GERENCIA ADMINISTRATIVA'));
