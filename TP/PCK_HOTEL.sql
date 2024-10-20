-- especificacion del paquete 
CREATE OR REPLACE PACKAGE PCK_HOTEL 
IS 
 TYPE T_HABITACION IS RECORD 
 (CATEGORIA VARCHAR2(100), 
 COSTO_X_NOCHE NUMBER(10));
 TYPE T_HABITACIONES IS TABLE OF T_HABITACION INDEX BY BINARY_INTEGER; 
 
 FUNCTION F_VERIFICAR_DISPONIBILIDAD(La identificación del 
hotel, cantidad de huéspedes, fecha_desde y fecha_hasta) RETURN T_HABITACIONES;

 PROCEDURE P_FACTURAR(P_ID_HOTEL NUMBER); 
 PROCEDURE P_CONSULTAR_OCUPACION(P_CRITERIO VARCHAR2, P_VALOR VARCHAR2);
END; 
/


-- body del paquete
La función F_VERIFICAR_DISPONIBILIDAD deberá validar que la cantidad de
huéspedes esté entre 1 y 3 atendiendo a la capacidad de las habitaciones del hotel.
Cualquier otro valor será rechazado. La fecha inicial de la reserva no puede ser
anterior a la fecha de hoy. Además, las fecha_hasta debe ser mayor a la
fecha_desde. Con los parámetros recibidos deberá seleccionar todas las
habitaciones con la capacidad solicitada y que estén disponibles, es decir que no
posean reservas Confirmadas o Pendientes en el rango de fechas recibido por
parámetro. Debe considerar que si la fecha_desde coincide con la fecha de
checkout de una reserva (confirmada o pendiente) se la podrá considerar también
disponible. Con los datos seleccionados la función deberá cargar la variable del tipo
T_HABITACIONES indexando por el número de habitación


FUNCTION F_VERIFICAR_DISPONIBILIDAD(La identificación del 
hotel, cantidad de huéspedes, fecha_desde y fecha_hasta) RETURN T_HABITACIONES;











