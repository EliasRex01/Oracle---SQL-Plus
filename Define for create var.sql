-- Uso de DEFINE para crear variables
SQL> DEFINE ced_empleado = 200
SQL> SELECT cedula, apellido
  2  FROM b_empleados
  3  WHERE cedula = &ced_empleado;

-- borrar la variable
SQL> UNDEFINE ced_empleado

SHOW ALL    -- muestra uma lista con todas las variables


-- Ejemplo de variables de substitución 
-- Para strings y fechas, ponga la variable entre apóstrofes
-- Use (&&) si se desea reutilizar el valor de la variable sin tener que 
-- repetir el valor por cada ejecucion
SQL> SELECT nombre ||' '|| apellido as Empleado
2 FROM b_empleados
3 WHERE cedula = &c;

SQL> SELECT nombre ||' '|| apellido as Empleado
2 FROM b_empleados
3 WHERE apellido = '&apellido';
