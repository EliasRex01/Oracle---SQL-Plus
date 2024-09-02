------------------------------------------------------
----------------Funciones de grupo--------------------
------------------------------------------------------
SET LINESIZE 100
SET PAGESIZE 500

--//Comenzó Martes 22/08/2024
--Funciones SUM/AVG
SELECT SUM(MONTO_TOTAL), AVG(MONTO_TOTAL),
       MIN(MONTO_TOTAL), MAX(MONTO_TOTAL)
  FROM B_VENTAS
 WHERE ID_CLIENTE = 2;

--Funciones MAX/MIN
SELECT MIN(apellido), 
       MAX(apellido)
  FROM b_personas
 WHERE ES_CLIENTE = 'S';
 
--Función COUNT 
--Nos devuelve la cantidad de registros cuyo ID_AREA es igual a 12
--count(*) cuenta los nulos
SELECT COUNT(*)
  FROM b_posicion_actual
 WHERE id_area = 12;

--Nos devuelve cantidad de registros de personas que son clientes cuyo RUC no sea nulo 
--count(expresión) excluye los nulos
SELECT NOMBRE, RUC
  FROM b_personas
 WHERE ES_CLIENTE = 'S';

SELECT COUNT(RUC)
  FROM b_personas
 WHERE ES_CLIENTE = 'S';

--//Continua Jueves 22/08/2024
--Cláusula GROUP BY 
--Se despliega una línea de datos para cada grupo recuperado por la cláusula WHERE y COUNT (*).
--Se despliega la cantidad de personas que son clientes por localidad 
SELECT id_localidad, count(*) Cantidad
  FROM b_personas
 WHERE es_cliente= 'S'
 GROUP BY id_localidad; --se listan todas las columnas que preceden a la función de agrupación
 
--Despliegue los diferentes tipos de personas y la cantidad por cada tipo
SELECT tipo_persona, COUNT(*) Cantidad
  FROM b_personas
 GROUP BY tipo_persona;

--Determine todas las categorías salariales ocupadas, la cantidad de empleados que poseen dichas categorías   
SELECT p.cod_categoria, COUNT(p.cedula) 
  FROM B_POSICION_ACTUAL p 
 WHERE fecha_fin IS NULL
 GROUP BY p.Cod_Categoria; 

--Uso del HAVING
--Siguiendo el ejemplo anterior, solo recuperamos las categorías que cuenten con más de 2 empleados con dicha asignación.
SELECT p.cod_categoria, COUNT(p.cedula) 
  FROM B_POSICION_ACTUAL p 
 WHERE fecha_fin IS NULL
 GROUP BY p.Cod_Categoria
 HAVING COUNT(p.cedula) > 1; 
 
--Función LISTAGG
SELECT *
  FROM B_VENTAS;
  
SELECT *
  FROM B_DETALLE_VENTAS;

SELECT V.ID, 
       V.FECHA, 
       SUM(D.PRECIO * D.CANTIDAD) SUMA, 
       LISTAGG(D.ID_ARTICULO, ', ') WITHIN GROUP (ORDER BY D.ID_ARTICULO) ARTICULOS
  FROM B_DETALLE_VENTAS D JOIN B_VENTAS V ON V.ID = D.ID_VENTA
 GROUP BY V.ID, V.FECHA;

--QUERIES JERÁRQUICOS / START WITH / CONNECT BY
SELECT *
  FROM b_cuentas;

--Recupera la cuenta de ACTIVO (1000000) y las que dependen de ella
SELECT codigo_cta,
       nombre_cta
  FROM b_cuentas
 start with codigo_cta = 1000000
connect BY PRIOR codigo_cta = cta_superior;

--Recupera las cuentas superiores a la cuenta 1130000
SELECT codigo_cta,
       nombre_cta
  FROM b_cuentas
 start with codigo_cta = 1130000
connect BY codigo_cta = PRIOR cta_superior;

--Para mostrar la jerarquía en los datos recuperados
--En el ejemplo, LEVEL = 1000000 ya que es el nivel raíz de la jerarquía
SELECT LPAD(' ',2*(LEVEL-1))|| TO_CHAR(codigo_cta,'0000000') codigo_cta,
       nombre_cta
  FROM b_cuentas
 start with codigo_cta = 1000000
connect BY PRIOR codigo_cta = cta_superior;

--SUBQUERIES / SUBCONSULTAS
--Subconsultas simples
--Devuelve una única fila o columna
SELECT NOMBRE, APELLIDO, CEDULA_JEFE
  FROM B_EMPLEADOS
 WHERE CEDULA_JEFE = (SELECT CEDULA_JEFE 
                        FROM B_EMPLEADOS
                       WHERE UPPER(APELLIDO)= 'FERREIRA');
					   
					   
--Subconsultas de multiples filas					   
SELECT NOMBRE, APELLIDO, CEDULA_JEFE
  FROM B_EMPLEADOS
 WHERE CEDULA_JEFE IN (SELECT CEDULA_JEFE 
                        FROM B_EMPLEADOS
                       WHERE UPPER(APELLIDO) LIKE 'F%');

--Ejemplo de la utilización de funciones de grupo en la subconsulta
SELECT nombre, 
       costo
  FROM b_articulos
 WHERE costo < (SELECT AVG(costo)
                  FROM b_articulos)
 ORDER by costo DESC;
 
--Ejemplo de uso de un subquery escalar en el CASE
select nombre_cta, 
       (CASE
        WHEN id_tipo = (SELECT id  
                          FROM b_tipo_cuenta
                         WHERE nombre_categoria =('ACTIVO')) THEN 'ACTIVO' 
        ELSE
          'Otra clasificación' 
        END) Clasificación
  FROM b_cuentas;
  
--Ejemplo de uso de un subquery escalar en el DECODE 
select nombre_cta, 
       DECODE (ID_TIPO, 
               (SELECT id  
                  FROM b_tipo_cuenta
                 WHERE nombre_categoria =('ACTIVO')), 'ACTIVO',
               'Otra clasificación') CLASIFICACION
  FROM b_cuentas;
  
--Errores con SUBQUERIES
SELECT nombre, apellido
  FROM b_personas
 WHERE id_localidad = (SELECT id 
                         FROM b_localidad
                        WHERE UPPER(nombre) LIKE 'CAA%'); //Dará error!!!
--ORA-01427: la subconsulta de una sola fila devuelve más de una fila						
--Se está utilizando un operador de comparación siendo que el subquery devuelve más de un resultado.

--Si cambiamos al operador IN solucionamos el error ya que nos permite tratar con el conjunto resultante del subquery
SELECT nombre, apellido
  FROM b_personas
 WHERE id_localidad in (SELECT id 
                         FROM b_localidad
                        WHERE UPPER(nombre) LIKE 'CAA%');
						
--Utilización de cláusula HAVING  en una SUBCONSULTA
--Vendedores y su promedio de ventas
SELECT CEDULA_VENDEDOR, AVG(MONTO_TOTAL)COSTO
  FROM B_VENTAS
 GROUP BY CEDULA_VENDEDOR;
 
--Promedio general de ventas
SELECT AVG(MONTO_TOTAL) FROM B_VENTAS;

--Total de vendedores cuyo promedio se encuentra por debajo del promedio general de ventas
SELECT CEDULA_VENDEDOR, AVG(MONTO_TOTAL)COSTO
  FROM B_VENTAS
 GROUP BY CEDULA_VENDEDOR
HAVING AVG(MONTO_TOTAL) < (SELECT AVG(MONTO_TOTAL) FROM B_VENTAS);


--Sub Consultas correlacionadas
SELECT V.numero_factura, 
       V.fecha, 
       V.id_cliente,
       --
       (select count(d.numero_item)
          from B_DETALLE_VENTAS d
         where V.ID = D.ID_VENTA) as cantidad_item,
       --
       (select sum(D.precio*D.cantidad)
          from B_DETALLE_VENTAS D
         where V.ID = d.ID_VENTA) as Importe_total
  FROM B_VENTAS V;

--Uso del operador EXISTS en consultas correlacionadas  
SELECT E.CEDULA, 
       E.NOMBRE 
  FROM B_EMPLEADOS E
 WHERE EXISTS (SELECT 'X'
                 FROM B_EMPLEADOS E2
                WHERE E2.CEDULA_JEFE = E.CEDULA); 
				
--EXISTS vs IN 
--IN
SELECT E.CEDULA, 
       E.NOMBRE 
  FROM B_EMPLEADOS E
 WHERE E.CEDULA IN (SELECT E2.CEDULA_JEFE
                      FROM B_EMPLEADOS E2);
					
--EXISTS
SELECT E.CEDULA, 
       E.NOMBRE 
  FROM B_EMPLEADOS E
 WHERE EXISTS (SELECT 'X'
                 FROM B_EMPLEADOS E2
                WHERE E2.CEDULA_JEFE = E.CEDULA);

--Si bien generan el mismo resultado, se procesan de modo diferente. EXISTS puede ser más eficiente si el subquery tiene muchos datos.

--NOT EXISTS vs NOT IN 			
--NOT IN
SELECT E.CEDULA, 
       E.NOMBRE 
  FROM B_EMPLEADOS E
 WHERE E.CEDULA NOT IN (SELECT E2.CEDULA_JEFE
                          FROM B_EMPLEADOS E2); --Cuidado con los valores NULL (nulos) en el uso del NOT IN ya que anula la colección de valores.
					
--NOT EXISTS
SELECT E.CEDULA, 
       E.NOMBRE 
  FROM B_EMPLEADOS E
 WHERE NOT EXISTS (SELECT 'X'
                     FROM B_EMPLEADOS E2
                    WHERE E2.CEDULA_JEFE = E.CEDULA);	

--Verifique el resultado, debido a la presencia de valores NULL en el subquery! Vemos que no tenemos el mismo resultado.
--Esto se resolvería aplicando querys correlativos en el uso de NOT IN
SELECT E.CEDULA, E.NOMBRE 
  FROM B_EMPLEADOS E
 WHERE E.CEDULA NOT IN (SELECT E2.CEDULA_JEFE  
                          FROM B_EMPLEADOS E2
                         WHERE E2.CEDULA_JEFE = E.CEDULA);
						 
--También se resuelve utilizando el NVL	
SELECT E.CEDULA, 
       E.NOMBRE 
  FROM B_EMPLEADOS E
 WHERE E.CEDULA NOT IN (SELECT NVL(E2.CEDULA_JEFE,0)
                          FROM B_EMPLEADOS E2);					 
				
--INLINE VIEWS (Vistas Incrustadas)
SELECT V.CLIENTE, 
       V.MONTO_VENTAS
  FROM (SELECT ID_CLIENTE CLIENTE,    
               SUM(MONTO_TOTAL) MONTO_VENTAS
          FROM B_VENTAS
         GROUP BY ID_CLIENTE) V
		 
--Ejemplo sin la cláusula WITH
--Ver el id, nombre y cantidad del artículo más vendido
SELECT v.id_articulo, 
       a.nombre, 
       SUM(v.cantidad) cantidad
  FROM b_detalle_ventas v JOIN b_articulos a ON a.id = v.id_articulo
 GROUP BY v.id_articulo, a.nombre
HAVING SUM(v.cantidad) = (SELECT MAX(v.cantidad) maximo
                            FROM (SELECT v.id_articulo, a.nombre, SUM(v.cantidad) cantidad
                                    FROM b_detalle_ventas v JOIN b_articulos a ON a.id = v.id_articulo
                                   GROUP BY v.id_articulo, a.nombre) v );
								   
--Ejemplo con el uso de la cláusula WITH
--Ver el id, nombre y cantidad del artículo más vendido
WITH sum_ven AS
  (SELECT v.id_articulo, 
          a.nombre, 
          SUM(v.cantidad) cantidad
      FROM b_detalle_ventas v JOIN b_articulos a ON a.id = v.id_articulo
     GROUP BY v.id_articulo, a.nombre)
     
SELECT v.id_articulo, 
       v.nombre, 
       v.cantidad
  FROM sum_ven v 
WHERE v.cantidad = (SELECT MAX(v.cantidad) maximo 
                      FROM sum_ven v);


--Ejercitario 03 Funciones de Grupo y Subqueries
--#7
/*7.	Para tener una idea de movimientos, se desea conocer el volumen (cantidad) de  
ventas por mes  que se hicieron por cada artículo durante el año 2018. 
Debe listar también los artículos que no tuvieron movimiento. 
La consulta debe lucir así: (ver formato)*/
--Opción 1: INLINE VIEWS
SELECT A.NOMBRE, 
       VE.ENE, 
       VE.FEB, 
       VE.MAR, 
       VE.ABR, 
       VE.MAY, 
       VE.JUN, 
       VE.JUL,
       VE.AGO, 
       VE.SEP, 
       VE.OCT, 
       VE.NOV, 
       VE.DIC 
  FROM (SELECT D.ID_ARTICULO,
               SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'01', D.CANTIDAD,0)) ENE,
               SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'02', D.CANTIDAD,0)) FEB, 
               SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'03', D.CANTIDAD,0)) MAR,
               SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'04', D.CANTIDAD,0)) ABR,
               SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'05', D.CANTIDAD,0)) MAY,
               SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'06', D.CANTIDAD,0)) JUN, 
               SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'07', D.CANTIDAD,0)) JUL,
               SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'08', D.CANTIDAD,0)) AGO, 
               SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'09', D.CANTIDAD,0)) SEP, 
               SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'10', D.CANTIDAD,0)) OCT, 
               SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'11', D.CANTIDAD,0)) NOV, 
               SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'12', D.CANTIDAD,0)) DIC    
          FROM B_DETALLE_VENTAS D JOIN B_VENTAS V ON V.ID = D.ID_VENTA
         WHERE EXTRACT (YEAR FROM V.FECHA) = '2018'
         GROUP BY D.ID_ARTICULO) VE RIGHT OUTER JOIN B_ARTICULOS A ON A.ID = VE.ID_ARTICULO;

--Opción 2: Usando with
--2.1 JOIN EXPLÍCITO. Usamos RIGHT OUTER JOIN
WITH VENTAS AS
(SELECT D.ID_ARTICULO,
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'01', D.CANTIDAD,0)) ENE,
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'02', D.CANTIDAD,0)) FEB, 
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'03', D.CANTIDAD,0)) MAR,
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'04', D.CANTIDAD,0)) ABR,
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'05', D.CANTIDAD,0)) MAY,
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'06', D.CANTIDAD,0)) JUN, 
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'07', D.CANTIDAD,0)) JUL,
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'08', D.CANTIDAD,0)) AGO, 
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'09', D.CANTIDAD,0)) SEP, 
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'10', D.CANTIDAD,0)) OCT, 
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'11', D.CANTIDAD,0)) NOV, 
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'12', D.CANTIDAD,0)) DIC    
     FROM B_DETALLE_VENTAS D JOIN B_VENTAS V ON V.ID = D.ID_VENTA
    WHERE EXTRACT (YEAR FROM V.FECHA) = '2018'
    GROUP BY D.ID_ARTICULO)
    
SELECT A.NOMBRE, 
       VE.ENE, 
       VE.FEB, 
       VE.MAR, 
       VE.ABR, 
       VE.MAY, 
       VE.JUN, 
       VE.JUL,
       VE.AGO, 
       VE.SEP, 
       VE.OCT, 
       VE.NOV, 
       VE.DIC 
  FROM VENTAS VE RIGHT OUTER JOIN B_ARTICULOS A ON A.ID = VE.ID_ARTICULO;
  
--2.2 JOIN IMPLÍCITO. Usando (+) del lado donde no tenemos ocurrencias
WITH VENTAS AS
(SELECT D.ID_ARTICULO,
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'01', D.CANTIDAD,0)) ENE,
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'02', D.CANTIDAD,0)) FEB, 
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'03', D.CANTIDAD,0)) MAR,
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'04', D.CANTIDAD,0)) ABR,
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'05', D.CANTIDAD,0)) MAY,
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'06', D.CANTIDAD,0)) JUN, 
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'07', D.CANTIDAD,0)) JUL,
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'08', D.CANTIDAD,0)) AGO, 
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'09', D.CANTIDAD,0)) SEP, 
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'10', D.CANTIDAD,0)) OCT, 
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'11', D.CANTIDAD,0)) NOV, 
        SUM(DECODE(TO_CHAR(V.FECHA,'MM'),'12', D.CANTIDAD,0)) DIC    
     FROM B_DETALLE_VENTAS D JOIN B_VENTAS V ON V.ID = D.ID_VENTA
    WHERE EXTRACT (YEAR FROM V.FECHA) = '2018'
    GROUP BY D.ID_ARTICULO)
    
SELECT A.NOMBRE, 
       VE.ENE, 
       VE.FEB, 
       VE.MAR, 
       VE.ABR, 
       VE.MAY, 
       VE.JUN, 
       VE.JUL,
       VE.AGO, 
       VE.SEP, 
       VE.OCT, 
       VE.NOV, 
       VE.DIC 
  FROM VENTAS VE,
       B_ARTICULOS A
 WHERE A.ID(+) = VE.ID_ARTICULO 
