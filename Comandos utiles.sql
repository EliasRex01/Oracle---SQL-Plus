-- comando get para obtener el contenido de un archivo en concreto
SQL> get test.sql

-- comando edit permite abrir el blog de notas para editar el contenido de un archivo
-- que se ejecuto con un select
SQL> edit test.sql

-- spool permite crear un archivo y guardar en el lo siguiente que se consulte y devuelva
SQL> spool test2.sql
SQL> select tname from tab;

SQL> spool off

-- describe o desc para ver tablas e informacion de tablas de una basen de datos
SQL> desc b_ventas

-- start ejecuta el contenido del archivo seleccionado con el
SQL> start test.sql
