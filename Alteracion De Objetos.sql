Las columnas virtuales:
SQL> ALTER TABLE B_DETALLE_VENTAS ADD SUBTOTAL NUMBER(10) 
GENERATED ALWAYS AS (CANTIDAD*PRECIO) VIRTUAL;

SQL> SELECT ID_ARTICULO,CANTIDAD,PRECIO, SUBTOTAL
2 FROM B_DETALLE_VENTAS
3 WHERE ID_VENTA=5;

ID_ARTICULO CANTIDAD PRECIO SUBTOTAL
----------- ---------- ---------- ----------
774449 10 11727 117270
788993 10 271818 2718180
750135 10 36273 362730

- Extienda la longitud máxima de la columna NOMBRE en la tabla de B_EMPLEADOS a 50 caracteres.
ALTER TABLE b_empleados
MODIFY (nombre VARCHAR2(50));

- La idea de columnas invisibles es similar a la idea de crear una vista para dejar de lado las columnas que no desea que vea el usuario final.
SQL> ALTER TABLE B_TIPO_CUENTA MODIFY NOMBRE_CATEGORIA INVISIBLE;
- llamada normal (no se muestra)
SQL> SELECT * FROM B_TIPO_CUENTA;
SQL> SELECT ID,NOMBRE_CATEGORIA
FROM B_TIPO_CUENTA;

