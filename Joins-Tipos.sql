-- Sintaxis Explicita

SELECT c.fecha, c.id_proveedor, p.nombre, l.nombre localidad
FROM b_compras c JOIN b_personas p
ON p.id = c.id_proveedor
JOIN b_localidad l
ON l.id = p.id_localidad;

-- Sintaxis implícita de ORACLE

SELECT c.fecha, c.id_proveedor, p.nombre, l.nombre localidad
FROM b_compras c, b_personas p, b_localidad l
WHERE p.id = c.id_proveedor
AND l.id = p.id_localidad;

-- Self Joins: Ejemplo
-- Puede reunir filas de una tabla con otras filas de la misma tabla usando el SELF JOIN. 
-- Simule dos tablas en la cláusula FROM creando dos seudónimos para la tabla.
  
SELECT funcionario.nombre || ' ' || 
funcionario.apellido||' trabaja para '|| jefe.apellido
FROM b_empleados funcionario,b_empleados jefe
WHERE jefe.cedula = funcionario.cedula_jefe;

SELECT funcionario.nombre || ' ' || 
funcionario.apellido ||' trabaja para '|| jefe.apellido
FROM b_empleados funcionario JOIN b_empleados jefe
ON jefe.cedula = funcionario.cedula_jefe;

-- Non- Equijoins: Reuniones que no utilizan el  operador =
-- Se da este tipo de reunión cuando ninguna columna en una tabla corresponde directamente a una columna en la segunda tabla
-- Para ejemplificar, suponga que existe una tabla B_NIVELSALARIO, que contenta los siguientes campos:
-- SALARIO_MINIMO NUMBER(8)
-- SALARIO_MAXIMO NUMBER(8)
-- Que determinen los niveles mínimo y máximo de la empresa. El ejemplo de una operación non-equijoin sería:

SQL> SELECT C.COD_CATEGORIA, C.NOMBRE_CAT, C.ASIGNACION
2 FROM B_CATEGORIAS_SALARIALES C, B_NIVELSALARIO N
3 WHERE C.ASIGNACION BETWEEN N.SALARIO_MINIMO AND N.SALARIO_MAXIMO;


-- Ejemplo de LEFT OUTER JOIN
-- Liste todas las personas, aún cuando no tengan localidad
  
SELECT c.cedula, c.nombre, c.apellido, l.nombre "Localidad"
FROM b_personas c, b_localidad l
WHERE l.id (+) = c.id_localidad;

SELECT c.cedula, c.nombre, c.apellido, l.nombre 
"Localidad"
FROM b_personas c LEFT OUTER JOIN b_localidad l
ON l.id = c.id_localidad;

-- Ejemplo de RIGHT OUTER JOIN
-- Nos interesa listar todas las localidades, aún  cuando no haya personas en dicha localidad

SELECT c.cedula, c.nombre, c.apellido, 
l.nombre "Localidad"
FROM b_personas c, b_localidad l
WHERE l.id = c.id_localidad (+);

SELECT c.cedula, c.nombre, c.apellido, 
l.nombre "Localidad"
FROM b_personas c RIGHT OUTER JOIN 
b_localidad l
ON l.id = c.id_localidad;

-- Ejemplo de FULL OUTER JOIN
-- Nos interesa listar todas las localidades, aún  cuando no haya personas en dicha localidad, y 
-- todas las personas, aún cuando se conozca la localidad a la que pertenecen
SELECT c.cedula, c.nombre, c.apellido,
l.nombre "Localidad"
FROM b_personas c FULL OUTER JOIN b_localidad l
ON l.id = c.id_localidad;

-- Producto Cartesiano
-- Sintaxis implícita, omitiendo la cláusula WHERE:

SELECT c.fecha, c.id_proveedor, p.nombre 
FROM b_compras c, b_personas p;

SELECT c.fecha, c.id_proveedor, p.nombre 
FROM b_compras c CROSS JOIN b_personas p;

-- Union
-- La normal une dos tablas (eliminando duplicados). El union all es lo contrario (une dos tablas sin eliminar duplicados)

Select nombre, apellido from b_empleados
UNION
Select nombre, apellido from b_personas;

-- Intersección
-- El comando INTERSECT tiene los mismos requerimientos de la UNION.
-- Ej.: Ver todos los empleados que han realizado alguna venta

SELECT cedula FROM b_empleados
INTERSECT
SELECT cedula_vendedor FROM b_ventas;

-- Diferencia
-- El comando MINUS reproduce la resta algebraica.
-- Ej.: Ver todos los empleados que NO han realizado venta alguna

SELECT cedula FROM b_empleados
MINUS
SELECT cedula_vendedor FROM b_ventas;
