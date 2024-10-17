SELECT CODIGO_CTA, NOMBRE_CTA, 
MES||ANIO PERIODO, ACUM_DEBITO, ACUM_CREDITO
FROM  B_CUENTAS NATURAL JOIN B_MAYOR;

SELECT CODIGO_CTA, NOMBRE_CTA, 
MES||ANIO PERIODO, ACUM_DEBITO, ACUM_CREDITO
FROM  B_CUENTAS 
 JOIN B_MAYOR USING (CODIGO_CTA)
;

SELECT CTA.CODIGO_CTA, CTA.NOMBRE_CTA, 
MAY.MES||MAY.ANIO PERIODO, MAY.ACUM_DEBITO, MAY.ACUM_CREDITO
FROM B_CUENTAS CTA 
INNER JOIN B_MAYOR MAY
	ON CTA.CODIGO_CTA=MAY.CODIGO_CTA
WHERE CTA.CODIGO_CTA=5230000
;

SELECT E.CEDULA, E.APELLIDO, CS.ASIGNACION
FROM B_EMPLEADOS E 
JOIN B_POSICION_ACTUAL PA 
	ON E.CEDULA=PA.CEDULA 
JOIN B_AREAS A 
	ON PA.ID_AREA = A.ID
JOIN B_CATEGORIAS_SALARIALES CS 
	ON PA.COD_CATEGORIA=CS.COD_CATEGORIA
JOIN B_LOCALIDAD L 
	ON E.ID_LOCALIDAD=L.ID
WHERE PA.FECHA_FIN IS NULL 
AND CS.FECHA_FIN IS NULL 
; 

SELECT E.CEDULA, E.APELLIDO, CS.ASIGNACION
FROM B_EMPLEADOS E,  
B_POSICION_ACTUAL PA,
B_CATEGORIAS_SALARIALES CS 
WHERE E.CEDULA=PA.CEDULA 
AND PA.COD_CATEGORIA=CS.COD_CATEGORIA
AND E.CEDULA=3008180
AND PA.FECHA_FIN IS NULL 
AND CS.FECHA_FIN IS NULL 
; 
 
SELECT E.APELLIDO ||' trabaja para '||J.APELLIDO
FROM B_EMPLEADOS E
JOIN B_EMPLEADOS J
	ON E.CEDULA_JEFE=J.CEDULA 
WHERE E.CEDULA=3008180
;

SELECT J.APELLIDO ||' ES JEFE DE '||E.APELLIDO
FROM B_EMPLEADOS E
JOIN B_EMPLEADOS J
	ON E.CEDULA_JEFE=J.CEDULA 
WHERE j.CEDULA=1607843
;

SELECT *
FROM TAB T 
WHERE T.TNAME LIKE '%NIVEL%'	
;

CREATE TABLE B_NIVELSALARIO 
(NIVEL VARCHAR2(10), 
SALARIO_MINIMO NUMBER(8),
SALARIO_MAXIMO NUMBER(8)
); 

INSERT INTO B_NIVELSALARIO 
VALUES ('BAJO',1,2000000); 
INSERT INTO B_NIVELSALARIO 
VALUES ('MEDIO',2000001,4000000); 
INSERT INTO B_NIVELSALARIO 
VALUES ('ALTO',4000001,99999999); 

SELECT E.APELLIDO, CS.ASIGNACION,N.NIVEL
FROM B_EMPLEADOS E 
JOIN B_POSICION_ACTUAL PA 
	ON E.CEDULA=PA.CEDULA 
JOIN B_CATEGORIAS_SALARIALES CS 
	ON PA.COD_CATEGORIA=CS.COD_CATEGORIA
JOIN B_NIVELSALARIO N 
	ON CS.ASIGNACION BETWEEN N.SALARIO_MINIMO AND N.SALARIO_MAXIMO
WHERE PA.FECHA_FIN IS NULL 
AND CS.FECHA_FIN IS NULL 
AND E.CEDULA=3008180
; 

SELECT COUNT(*)
FROM B_EMPLEADOS E
INNER JOIN B_LOCALIDAD L 
	ON E.ID_LOCALIDAD=L.ID; 

SELECT COUNT(*)
FROM B_EMPLEADOS E LEFT OUTER JOIN B_LOCALIDAD L
 ON E.ID_LOCALIDAD=L.ID; 	
 

SELECT COUNT(*)
FROM B_LOCALIDAD L RIGHT JOIN B_EMPLEADOS E 
 ON E.ID_LOCALIDAD=L.ID; 
 
SELECT COUNT(*)
FROM B_EMPLEADOS E, 
B_LOCALIDAD L
WHERE E.ID_LOCALIDAD=L.ID(+)
; 	

SELECT COUNT(*)
FROM B_EMPLEADOS E, 
B_LOCALIDAD L
WHERE E.ID_LOCALIDAD(+)=L.ID
; 

SELECT E.APELLIDO, L.NOMBRE 
FROM B_EMPLEADOS E LEFT OUTER JOIN B_LOCALIDAD L
 ON E.ID_LOCALIDAD=L.ID; 
 
SELECT E.APELLIDO, L.NOMBRE 
FROM B_EMPLEADOS E FULL  JOIN B_LOCALIDAD L
 ON E.ID_LOCALIDAD=L.ID;
 
SELECT E.APELLIDO, L.NOMBRE 
FROM B_EMPLEADOS E,
B_LOCALIDAD L
; 

SELECT NOMBRE, APELLIDO 
FROM B_EMPLEADOS 
UNION ALL
SELECT NOMBRE, APELLIDO 
FROM B_PERSONAS 
ORDER BY NOMBRE
; 

--22082024
SELECT --A.NOMBRE_AREA, 
E.APELLIDO||', '||E.NOMBRE NOMBRE_EMPLEADO,  
--E.FECHA_ING, 
PA.ID, 
CS.COD_CATEGORIA,
--CS.NOMBRE_CAT CATEGORIA, 
CS.ASIGNACION SALARIO_ACTUAL
FROM B_EMPLEADOS E 
INNER JOIN B_POSICION_ACTUAL PA 
	ON E.CEDULA=PA.CEDULA 
JOIN B_CATEGORIAS_SALARIALES CS 
	ON PA.COD_CATEGORIA=CS.COD_CATEGORIA
JOIN B_AREAS A 
	ON PA.ID_AREA=A.ID
WHERE PA.FECHA_FIN IS NULL 
AND CS.FECHA_FIN IS NULL 
AND E.CEDULA=3008180
ORDER BY 
;

SELECT --A.NOMBRE_AREA, 
UPPER(CONCAT(CONCAT(E.APELLIDO||', '),||E.NOMBRE))NOMBRE_EMPLEADO,  

PA.ID, 
CS.COD_CATEGORIA,
--CS.NOMBRE_CAT CATEGORIA, 
CS.ASIGNACION SALARIO_ACTUAL
FROM B_EMPLEADOS E 
INNER JOIN B_POSICION_ACTUAL PA 
	ON E.CEDULA=PA.CEDULA 
JOIN B_CATEGORIAS_SALARIALES CS 
	ON PA.COD_CATEGORIA=CS.COD_CATEGORIA
JOIN B_AREAS A 
	ON PA.ID_AREA=A.ID
WHERE PA.FECHA_FIN IS NULL 
AND CS.FECHA_FIN IS NULL 
AND E.CEDULA=3008180
ORDER BY 
;

SELECT SYSDATE FROM DUAL; --22/08/24

SELECT E.CEDULA, E.APELLIDO, 
NVL(E.ID_LOCALIDAD,0) LOCALIDAD,
COALESCE(E.ID_LOCALIDAD, E.CEDULA_JEFE, E.CEDULA) CEDULA_COA
FROM B_EMPLEADOS E 
WHERE E.ID_LOCALIDAD IS NULL 
AND E.CEDULA=1607843
;

UPDATE B_EMPLEADOS
SET ID_LOCALIDAD = NULL
WHERE CEDULA_JEFE IS NULL;


SELECT TO_CHAR(CS.ASIGNACION,'999g999g999')asig
FROM B_EMPLEADOS E 
INNER JOIN B_POSICION_ACTUAL PA 
	ON E.CEDULA=PA.CEDULA 
JOIN B_CATEGORIAS_SALARIALES CS 
	ON PA.COD_CATEGORIA=CS.COD_CATEGORIA
JOIN B_AREAS A 
	ON PA.ID_AREA=A.ID
WHERE PA.FECHA_FIN IS NULL 
AND CS.FECHA_FIN IS NULL 
AND E.CEDULA=3008180
;

alter session set nls_date_format='DD-mm-yy hh24:mi:ss';
SELECT SYSDATE, 
ROUND(SYSDATE,'YEAR') REDON
FROM DUAL; 

SELECT 
TRUNC(SYSDATE,'rr') TRUNCA
FROM DUAL; 

SELECT EXTRACT (YEAR FROM SYSDATE) FROM DUAL;
SELECT CEDULA 
FROM B_EMPLEADOS
WHERE FECHA_ING='06-05-06'
;

SELECT EXTRACT (YEAR FROM SYSDATE) FROM DUAL;
SELECT CEDULA 
FROM B_EMPLEADOS
WHERE FECHA_ING=TO_DATE('06-05-06','dd-mm-yy')
;

SELECT CEDULA, 
TO_CHAR(FECHA_ING, 'dd/mm/yy') ING
FROM B_EMPLEADOS
WHERE FECHA_ING='06-05-06'
;

SELECT  TIPO_PERSONA, ES_CLIENTE,
	CASE 
		WHEN TIPO_PERSONA='F' then 'Fisica' , 
		WHEN ES_CLIENTE='S' then 'NO ES FISICA PERO SI CLIENTE'
		ELSE 'N/A'
	END CASE EVAL
FROM B_PERSONAS
; 
SELECT 
	DECODE(NVL(TIPO_PERSONA,'N'),
		'F','Fisica',
		'J','Juridica',
		'N','No Determinado',
		 'Error al registrar'
		 )
--27/08/24
SELECT P.CEDULA, 
P.APELLIDO,
DIRECCION_SECUNDARIA 
FROM B_PERSONAS P 
WHERE P.ES_CLIENTE='S'
INTERSECT
SELECT TO_CHAR(E.CEDULA), 
E.APELLIDO,
'n/d'
FROM B_EMPLEADOS E
ORDER BY 1
; 


SELECT NVL(L.NOMBRE,'No Asignado') Localidad, P.NOMBRE
FROM B_PERSONAS P 
LEFT JOIN B_LOCALIDAD L
 ON P.ID_LOCALIDAD=L.ID
ORDER BY LOCALIDAD; 	
	
	
/*7- ID_Asiento, Fecha, Concepto, Nro.Linea, código cuenta, nombre cuenta, debe_haber, Importe */
SELECT *
FROM B_DIARIO_CABECERA DC 
JOIN B_DIARIO_DETALLE DD ON DC.ID=DD.ID 
JOIN B_CUENTAS C ON DD.CODIGO_CTA=C.CODIGO_CTA
WHERE DC.FECHA LIKE '%2019'
;
--8
SELECT DC.ID, DC.FECHA,
FROM B_DIARIO_CABECERA DC 
JOIN B_DIARIO_DETALLE DD ON DC.ID=DD.ID 
JOIN B_CUENTAS C ON DD.CODIGO_CTA=C.CODIGO_CTA
WHERE DC.FECHA LIKE '%2019'
;
SELECT DD.CODIGO_CTA, 
DEBE_HABER, 
(CASE DEBE_HABER WHEN 'D' THEN IMPORTE ELSE 0 END) DEBITOS,
DECODE(DEBE_HABER,'C',IMPORTE,'D',0,-99999)CREDITOS
FROM B_DIARIO_CABECERA DC 
JOIN B_DIARIO_DETALLE DD ON DC.ID=DD.ID 
JOIN B_CUENTAS C ON DD.CODIGO_CTA=C.CODIGO_CTA
WHERE DC.FECHA LIKE '%19'
;	

SELECT FILE_NAME
FROM DBA_DATA_FILES
;

SELECT COUNT(*)
FROM B_LOCALIDAD; 

SELECT L.NOMBRE, COUNT(L.ID) CANTIDAD
FROM  B_LOCALIDAD L 
LEFT JOIN B_PERSONAS P ON P.ID_LOCALIDAD=L.ID
GROUP BY L.NOMBRE
; 

SELECT C.NOMBRE_CAT CAT, COUNT(p.cedula) Cantid
FROM B_CATEGORIAS_SALARIALES C 
LEFT JOIN B_POSICION_ACTUAL p 
	ON P.COD_CATEGORIA=C.COD_CATEGORIA
WHERE P.FECHA_FIN IS NULL
AND C.FECHA_FIN IS NULL
GROUP BY C.NOMBRE_CAT
HAVING COUNT(p.cedula) > 1;

--1607843	
SELECT J.APELLIDO
FROM B_EMPLEADOS J
WHERE J.CEDULA= 1607843; 

SELECT E.CEDULA, E.APELLIDO  
FROM B_EMPLEADOS E
WHERE E.CEDULA_JEFE=1607843 
; 

SELECT E.CEDULA, E.APELLIDO, E.CEDULA_JEFE 
FROM B_EMPLEADOS E
WHERE E.CEDULA_JEFE IN (952160, 2204219, 444765) 
; 


Brandenstein
	CANIZA
		 Ferreira
			esclavito x 
		 Moreno
		 Gonzalez 
	BENITEZ 
		 Franco de Nuñez
		 Lee 
	MIERES
	
ACTIVOS
	RODADOS 
		Rodados
		
SELECT CODIGO_CTA, NOMBRE_CTA, C.CTA_SUPERIOR
FROM B_CUENTAS C 
WHERE CODIGO_CTA=1110000;

SELECT CODIGO_CTA, NOMBRE_CTA, C.CTA_SUPERIOR
FROM B_CUENTAS C 
WHERE CODIGO_CTA=1100000;


SELECT CODIGO_CTA,NOMBRE_CTA
FROM B_CUENTAS
START WITH CODIGO_CTA = 1000000
CONNECT BY PRIOR CODIGO_CTA = CTA_SUPERIOR;

SELECT CODIGO_CTA,NOMBRE_CTA
FROM B_CUENTAS
START WITH CODIGO_CTA = 1130000
CONNECT BY  CODIGO_CTA = PRIOR CTA_SUPERIOR;

SELECT LPAD(' ',2*(LEVEL-1))|| CODIGO_CTA CUENTA,
NOMBRE_CTA
FROM B_CUENTAS
START WITH CODIGO_CTA = 1100000
CONNECT BY PRIOR CODIGO_CTA = CTA_SUPERIOR;


SELECT E.CEDULA 
FROM B_EMPLEADOS E
WHERE E.ID_LOCALIDAD IN  
	(SELECT ID ID_LOC FROM B_LOCALIDAD L WHERE UPPER(L.NOMBRE) LIKE 'A%')
; 

SELECT E.CEDULA 
FROM B_EMPLEADOS E
JOIN (SELECT ID ID_LOC 
		FROM B_LOCALIDAD L 
		WHERE UPPER(L.NOMBRE) LIKE 'A%'
	 ) LOC_A ON E.ID_LOCALIDAD=LOC_A.ID_LOC 
;

SELECT E.CEDULA, 
NVL((SELECT L.NOMBRE
		FROM B_LOCALIDAD L 
		WHERE L.ID=E.ID_LOCALIDAD),'N/A') NOM_LOCALIDAD
FROM B_EMPLEADOS E
;

SELECT CEDULA, NOMBRE 
FROM B_EMPLEADOS E
WHERE E.CEDULA_JEFE IN (SELECT CEDULA
 FROM B_EMPLEADOS );

SELECT CEDULA, NOMBRE 
FROM B_EMPLEADOS JEFE
WHERE EXISTS (SELECT 'X'
			 FROM B_EMPLEADOS EMP
			 WHERE EMP.CEDULA_JEFE = JEFE.CEDULA);
 

SELECT 'X'
			 FROM B_EMPLEADOS EMP
			 WHERE EMP.CEDULA_JEFE = 952160