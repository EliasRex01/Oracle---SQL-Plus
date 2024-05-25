-- Funciones para Strings
-- Función                                  Resultado
LOWER('SQL Course')                         sql course
UPPER('SQL Course')                         SQL COURSE
INITCAP('SQL Course')                       Sql course
  
SELECT employee_id, last_name, department_id
FROM employees
WHERE last_name = 'higgins';

SELECT employee_id, last_name, department_id
FROM employees
WHERE LOWER(last_name) = 'higgins';

-- Función                                  Resultado
CONCAT('Hello', 'World')                    HelloWorld
SUBSTR('HelloWorld',1,5)                    Hello
LENGTH('HelloWorld')                        10
INSTR('HelloWorld', 'W')                    6
LPAD(salary,10,'*')                         *****24000
RPAD(salary, 10, '*')                       24000*****
REPLACE ('JACK and JUE','J','BL')           BLACK and BLUE
TRIM('H' FROM 'HelloWorld')                 elloWorld

-- Formato de Fechas
-- Por default se despliega en el formato DD-MM-YYYY
-- SYSDATE es una función que retorna fecha y hora actual del servidor. 
-- CURRENT_DATE también retorna fecha y hora actual en la zona horaria de la sesión. 
-- SYSDATE y CURRENT_DATE no tienen argumentos
  
SELECT sysdate FROM dual;

SELECT current_date FROM dual;

-- Si el usuario y el servidor están en Asunción, no habrá diferencias, pero si el servidor está
--  en otro país, por ejemplo en China, puede haber hasta 12 horas de diferencia entre ambos resultados.

-- Funciones de fecha
-- Función                                                    Resultado
MONTHS_BETWEEN ('01-SEP-95','11-JAN-94‘)                      19.6774194
ADD_MONTHS ('11-JAN-94',6)                                    '11-JUL-94'
NEXT_DAY ('01-SEP-95','FRIDAY')                               '08-SEP-95'
LAST_DAY ('01-FEB-95')                                        '28-FEB-95'

-- Supongamos que SYSDATE = '25-JUL-03':
-- Función                                       Resultado
ROUND(SYSDATE,'MONTH')                           01-AUG-03
ROUND(SYSDATE ,'YEAR')                           01-JAN-04
TRUNC(SYSDATE ,'MONTH')                          01-JUL-03
TRUNC(SYSDATE ,'YEAR')                           01-JAN-03

-- Obtener una parte de la fecha con EXTRACT
-- EXTRACT es una función de fecha que permite obtener una parte de la fecha de los campos DATE o TIMESTAMP. 
-- Ejemplos:
  
SELECT EXTRACT (YEAR FROM SYSDATE) FROM DUAL;
  
SELECT EXTRACT (MONTH FROM SYSDATE) FROM DUAL;
  
-- EXTRACT puede utilizarse para extraer (para tipos DATE y TIMESTAMP):
• AÑO (YEAR)
• MES (MONTH)
• DÍA (DAY)
-- Estas funciones sólo pueden utilizarse con variables TIMESTAMP
• HORA (HOUR)
• MINUTO (MINUTE)
• SEGUNDO (SECOND)

Conversión de Tipos de Datos Implícita
• Para las asignaciones, Oracle Server puede 
convertir automáticamente:
De - A
VARCHAR2 o CHAR - NUMBER
VARCHAR2 o CHAR - DATE
NUMBER - VARCHAR2
DATE - VARCHAR2

Uso de la Función TO_CHAR con Fechas
SELECT last_name, 
TO_CHAR(hire_date, 'fmDD Month YYYY')AS HIREDATE 
FROM employees;

Uso de la Función TO_CHAR con Números
TO_CHAR(number, 'format_model') ddspth

Anidamiento de Funciones
SELECT last_name,
UPPER(CONCAT(SUBSTR(LAST_NAME, 1, 8),'_US'))
FROM employees
WHERE department_id = 60;

La expresión CASE: Ejemplo
SELECT nombre, apellido, 
CASE tipo_persona 
WHEN 'F' THEN 'Fisica'
WHEN 'J' THEN 'Jurídica'
ELSE 'Tipo no definido' 
END "tipo persona"
FROM B_PERSONAS;

La expresión CASE: Ejemplo 2
SELECT numero_factura, fecha, 
monto_total, 
CASE 
WHEN EXTRACT (YEAR FROM 
FECHA) <= 2018 THEN 'Viejo'
ELSE 'Nuevo' 
END Clasificac
FROM B_VENTAS;

La función DECODE (Ejemplo)
• Si if2, entonces el resultado es then2, y así 
sucesivamente,
• El valor else, es obligatorio
SELECT nombre, apellido, DECODE(tipo_persona, 
'F','Fisica', 'J', 'Jurídica', 'Tipo no 
definido') "tipo persona"
FROM B_PERSONAS;
