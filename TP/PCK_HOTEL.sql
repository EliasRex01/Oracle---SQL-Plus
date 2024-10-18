
 La función F_VERIFICAR_DISPONIBILIDAD 
 que recibirá como parámetros: La identificación del 
hotel, cantidad de huéspedes, fecha_desde y fecha_hasta; y devolverá una variable del tipo 
T_HABITACIONES.


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



