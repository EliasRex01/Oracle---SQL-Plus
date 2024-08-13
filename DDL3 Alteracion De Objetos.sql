-- Las columnas virtuales:
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

-- Extienda la longitud máxima de la columna NOMBRE en la tabla de B_EMPLEADOS a 50 caracteres.
ALTER TABLE b_empleados
MODIFY (nombre VARCHAR2(50));

-- La idea de columnas invisibles es similar a la idea de crear una vista para dejar de lado las columnas que no desea que vea el usuario final.
SQL> ALTER TABLE B_TIPO_CUENTA MODIFY NOMBRE_CATEGORIA INVISIBLE;
-- llamada normal (no se muestra)
SQL> SELECT * FROM B_TIPO_CUENTA;
SQL> SELECT ID,NOMBRE_CATEGORIA
FROM B_TIPO_CUENTA;

-- Borrando una Columna: Sintaxis
ALTER TABLE tabla
DROP (columna );
-- Una columna no puede ser borrada si forma parte de un  constraint o de una clave, a no ser que se agregue la opción CASCADE

-- Opción SET UNUSED, Cuando se marca una columna como UNUSED ya no es accesible con el comando SELECT
ALTER TABLE <tabla>
SET UNUSED (columna);
-- o bien
ALTER TABLE <tabla>
SET UNUSED COLUMN <columna>;


Borrar columnas marcadas como UNUSED
ALTER TABLE <tabla>
DROP UNUSED COLUMNS;
# Las tablas que tienen columnas definidas así pueden verse en USER_UNUSED_COL_TABS

Adición de una Sintaxis de Restricción
ALTER TABLE <table_name>
ADD [CONSTRAINT <constraint_name>] 
type (<column_name>);

Adicionando un Constraint: Ejemplo
Adicione un constraint de tipo FOREIGN KEY a la tabla de
B_EMPLEADOS que indique que un jefe ya debe existir como un empleado válido en la Tabla
ALTER TABLE b_empleados
ADD CONSTRAINT s_emp_cedula_jefe_fk
FOREIGN KEY (cedula_jefe)
REFERENCES b_empleados(cedula);

Borrando un Constraint: Ejemplo
Borrar el constraint de integridad referencial con la tabla B_EMPLEADOS
ALTER TABLE b_empleados
DROP CONSTRAINT r_jefe_empleado;
Borre el constraint PRIMARY KEY en la tabla de B_PERSONAS y consecuentemente el FOREIGN KEY asociado en la columna de B_COMPRAS
ALTER TABLE b_personas
DROP PRIMARY KEY CASCADE;


Desactivar constraint
La sentencia ALTER TABLE posee la cláusula DISABLE que permite deshabilitar el funcionamiento una regla de integridad.
• Aplique la opción CASCADE para desactivar constraints dependientes.
ALTER TABLE b_empleados
DISABLE CONSTRAINT r_jefe_empleado;


Activar Constraints
# Active un constraint actualmente desactivado en la definición de la tabla usando la cláusula ENABLE.
• Si se habilita un constraint UNIQUE o PRIMARY KEY, se crea
automáticamente un índice.
ALTER TABLE b_empleados
ENABLE CONSTRAINT r_jefe_empleado;


Borrando una Tabla: Sintaxis
 Se confirman las transacciones pendientes
 Todos los índices se borran
 La opción CASCADE CONSTRAINT elimina los constraints de integridad dependientes
 No se puede realizar un rollback de esta sentencia
 La opción PURGE libera inmediatamente el espacio en el TABLESPACE

Sentencia FLASHBACK TABLE – Ejemplo
DROP TABLE vendedores;
SELECT original_name, operation, droptime
FROM recyclebin;
FLASHBACK TABLE vendedores TO BEFORE DROP;

RENAME para cambiar el nombre de una 
tabla, vista, secuencia, o sinónimo
SQL> RENAME b_empleados TO b_empleados_otro;

TRUNCATE: Elimina todas las filas de una tabla siempre y cuando la misma no sea referenciada por otras tablas.
SQL> TRUNCATE TABLE b_liquidacion;

Comentarios de la tabla
Para limpiar el comentario use el string que simboliza NULL (‘ ‘).
Ejemplos:
SQL> COMMENT ON TABLE b_empleados IS 'Informacion del
Empleado';
SQL> COMMENT ON COLUMN b_empleados.fecha_ing IS 'Fecha de ingreso en la empresa';
