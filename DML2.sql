INSERT mediante giro o pivotante
Es una operación de transformación donde cada registro de cualquier flujo de entrada, como una tabla no relacional, se
convierta en registros para un entorno relacional.

INSERT ALL
INTO sales_info VALUES (employee_id, week_id, sales_MON)
INTO sales_info VALUES (employee_id, week_id,sales_TUE)
INTO sales_info VALUES (employee_id, week_id,sales_WED) INTO sales_info VALUES (employee_id, week_id, sales_THUR)
INTO sales_info VALUES (employee_id, week_id, sales_FRI) SELECT EMPLOYEE ID, week id, sales MON, sales TUE, sales WED, sales THUR, sales FRI FROM sales_source_data;

Update
Marque como proveedor y actualice a 22 la localidad de la persona con id=1
UPDATE b_personas 
SET es_proveedor='S', id_localidad='22'
WHERE id = 1;

Actualizando con el resultado del subquery
UPDATE B_EMPLEADOS 
SET CEDULA_JEFE = 1309873 
WHERE CEDULA IN 
(SELECT CEDULA 
FROM B_EMPLEADOS 
WHERE CEDULA_JEFE=952160);

Actualización de más de una columna con el resultado de un subquery:
UPDATE B_MAYOR M
SET (ACUM_DEBITO, ACUM_CREDITO) =
(SELECT NVL(SUM(DECODE(D.DEBE_HABER, 'D', D.IMPORTE, 
0)),0) ACUM_DEBITO,
NVL(SUM(DECODE(D.DEBE_HABER, 'C', D.IMPORTE, 
0)),0) ACUM_CREDITO
FROM B_DIARIO_DETALLE D JOIN B_DIARIO_CABECERA 
C
ON C.ID = D.ID
WHERE D.CODIGO_CTA = M.CODIGO_CTA
AND EXTRACT(YEAR FROM C.FECHA) = M.ANIO
AND EXTRACT(MONTH FROM C.FECHA) = M.MES);

Delete
Ejemplo: Elimine toda la información de empleados que empezaron antes del 1 de enero del 2001.
DELETE FROM b_personas
WHERE fecha_ing<to_date(’2001-01-01’,’yyyy-mm-dd’)

ROWID
La pseudo-columna ROWID devuelve la dirección de la fila en el disco.
SQL> SELECT ROWID,A.ID,A.NOMBRE_AREA
FROM B_AREAS A
WHERE A.ID=1;
ROWID ID NOMBRE_AREA
------------------                             ----             ----------------
AAASKJAANAAAAXVAAA     1        Gerencia General

Ejemplo uso (selects, en where o condicionales):
UPDATE B_AREAS A
SET A.NOMBRE_AREA=UPPER(A.NOMBRE_AREA)
WHERE ROWID='AAASKJAANAAAAXVAAA';
COMMIT;
No puede insertar, actualizar o eliminar un valor de la pseudo-columna ROWID.


MERGE : Sintaxis
Permite actualizar los datos de una tabla combinándola con los datos de otra tabla.
MERGE INTO <nombre de tabla>
USING <vista o sentencia SELECT>
ON (<condición>)
WHEN MATCHED THEN <cláusula UPDATE>
WHEN NOT MATCHED THEN <cláusula INSERT>;

Ejemplo: Creemos una tabla de bonificación por cada empleado con la siguiente 
estructura:
CREATE TABLE BONIFICACION
(CEDULA_EMP NUMBER(7),
BONIFICACION NUMBER(10));

• Suponiendo que la tabla contenga la bonificación correspondiente a cada empleado como un porcentaje del 5% sobre las ventas entonces podríamos hacer:
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

Manipulación de Datos y
Comandos de Control de Transacciones
COMANDO - DESCRIPCION
COMMIT Finaliza la transacción actual haciendo que todos los 
cambios pendientes pasen a ser permanentes. 
SAVEPOINT Establece una "marca" dentro de la transacción en 
curso, usada por COMMIT o ROLLBACK. 
ROLLBACK Finaliza la transacción en curso descartando todos los cambios pendientes.

INICIO DE LA TRANSACCIÓN
Una transacción comienza cuando se ejecuta la primera sentencia SQL
• FIN DE LA TRANSACCIÓN
La transacción termina cuando sucede cualquiera de los siguientes eventos:
• La ejecución de un comando COMMIT o ROLLBACK
• Se ejecuta un comando DDL o DCL
• Existe una falla de la BD o del Sistema Operativo
• El usuario sale de su sesión SQL*Plus

El comando COMMIT
Confirma los cambios en la base de datos de modo permanente.
• Ejemplo: Cree el nuevo departamento «Contabilidad»
insert into b_areas(id, nombre_area, fecha_crea, 
activa,id_area_superior)
values(50,'Contabilidad',to_date(sysdate,'dd/mm/yyyy'),'S',NULL);

Agregue a un empleado en el departamento y confirme los cambios.
INSERT INTO B_POSICION_ACTUAL 
VALUES(30,1,429987,50,SYSDATE,NULL);
COMMIT;

El comando ROLLBACK
Se descartan los cambios de los datos y el estado anterior de los 
datos se restaura
• Ejemplo:
DELETE FROM B_POSICION_ACTUAL;
ROLLBACK;

El comando SAVEPOINT
Establece un ‘marcador’ para controlar la reversión de los cambios
• Ejemplo: Cree una marca dentro de una transacción actual usando 
SAVEPOINT. Al hacer el rollback, la transacción se deshace hasta el 
último SAVEPOINT
QL> UPDATE...
SQL> SAVEPOINT update_done;
Savepoint created.
SQL> INSERT...
SQL> ROLLBACK TO update_done;
Rollback complete.

