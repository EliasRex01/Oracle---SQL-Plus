
 La función F_VERIFICAR_DISPONIBILIDAD 
 que recibirá como parámetros: La identificación del 
hotel, cantidad de huéspedes, fecha_desde y fecha_hasta; y devolverá una variable del tipo 
T_HABITACIONES.
 El procedimiento P_FACTURAR que recibirá 
 como parámetro la identificación del hotel
 El procedimiento P_CONSULTAR_OCUPACION 
 que recibirá como parámetros: Criterio y valor, 
ambos definidos de tipo VARCHAR2.



CREATE OR REPLACE PACKAGE PCK_HOTEL 
IS 
 TYPE T_HABITACION IS RECORD 
 (CATEGORIA VARCHAR2(100), 
 COSTO_X_NOCHE NUMBER(10));
 TYPE T_HABITACIONES IS TABLE OF T_HABITACION INDEX BY BINARY_INTEGER; 
 
 FUNCTION F_CONTAR_HUESPEDES(PIDPAQUETE NUMBER) RETURN TAB_HOTEL; 
 FUNCTION F_CONTAR_VIAJEROS(PIDPAQUETE NUMBER, PIDVUELO NUMBER, PIDCOMPANIA NUMBER) 
RETURN NUMBER; 
END; 
/
