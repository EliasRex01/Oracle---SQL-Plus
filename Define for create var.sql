-- Uso de DEFINE para crear variables
SQL> DEFINE ced_empleado = 200
SQL> SELECT cedula, apellido
  2  FROM b_empleados
  3  WHERE cedula = &ced_empleado;

-- borrar la variable
SQL> UNDEFINE ced_empleado

SHOW ALL    -- muestra uma lista con todas las variables
