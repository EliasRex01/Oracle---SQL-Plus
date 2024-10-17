CREATE TABLE H_CANAL_RESERVA (
	CODIGO               NUMBER(5) NOT NULL ,
	NOMBRE               VARCHAR2(100) NOT NULL ,
	HABILITADO           VARCHAR2(1) NOT NULL ,
CONSTRAINT  PK_COD_CANAL PRIMARY KEY (CODIGO)
);

COMMENT ON TABLE H_CANAL_RESERVA IS 'Tabla donde se registran los medios a través de los cuales se realiza la reserva de una habitación. Ej: Contac Center, Mostrador, Sitio Web, etc';



CREATE TABLE H_CATEGORIA (
	CODIGO               NUMBER(5) NOT NULL ,
	DESCRIPCION          VARCHAR2(100) NOT NULL ,
	COSTO_X_NOCHE        NUMBER(10) NOT NULL ,
	COSTO_ADICIONAL_HUESP NUMBER(10) NOT NULL ,
	CAPACIDAD_MAXIMA     NUMBER(3) NOT NULL ,
CONSTRAINT  PK_COD_CATEGORIA PRIMARY KEY (CODIGO)
);

COMMENT ON TABLE H_CATEGORIA IS 'Tabla donde se mantiene los datos de las categorías de habitaciones con que cuenta el hotel. Ej: Simple, matrimonial, triple, etc.';


CREATE TABLE H_EMISOR_TARJETA (
	CODIGO               NUMBER(5) NOT NULL ,
	NOMBRE               VARCHAR2(150) NOT NULL ,
	DIRECCION            VARCHAR2(200) NOT NULL ,
	TELEFONO             VARCHAR2(15) NOT NULL ,
	EMAIL                VARCHAR2(20) NOT NULL ,
	TIPO                 VARCHAR2(1) NOT NULL ,
CONSTRAINT  PK_COD_BANCO PRIMARY KEY (CODIGO)
);

COMMENT ON TABLE H_EMISOR_TARJETA IS 'En esta tabla se mantienen los datos de entidades emisoras de tarjetas de crédito y débito.
Existen 3 tipos: B (Banco), F (Financiera) y C (Cooperativa).';


CREATE TABLE H_HABITACION (
	NUMERO               NUMBER(5) NOT NULL ,
	PISO                 NUMBER(3) NOT NULL ,
	COD_CATEGORIA        NUMBER(5) NOT NULL ,
	OCUPADO              VARCHAR2(1) NOT NULL ,
CONSTRAINT  PK_NUM_HABITACION PRIMARY KEY (NUMERO)
);

COMMENT ON TABLE H_HABITACION IS 'Tabla donde se registran los datos de las habitaciones del hotel.';


CREATE TABLE H_HUESPED (
	CODIGO               NUMBER(10) NOT NULL ,
	TIPO_DOCUMENTO       VARCHAR2(10) NOT NULL ,
	NUM_DOCUMENTO        VARCHAR2(25) NOT NULL ,
	PRIMER_NOMBRE        VARCHAR2(150) NOT NULL ,
	PRIMER_APELLIDO      VARCHAR2(150) NOT NULL ,
	SEGUNDO_NOMBRE       VARCHAR2(100) NULL ,
	SEGUNDO_APELLIDO     VARCHAR2(100) NULL ,
	TELEFONO_MOVIL       VARCHAR2(15) NULL ,
	DIRECCION_PARTICULAR VARCHAR2(200) NULL ,
	EMAIL                VARCHAR2(30) NULL ,
	FECHA_NACIMIENTO     DATE NOT NULL ,
	FECHA_ALTA           DATE NOT NULL ,
CONSTRAINT  PK_COD_HUESPED PRIMARY KEY (CODIGO)
);

COMMENT ON TABLE H_HUESPED IS 'Tabla donde se mantienen los datos básicos de los huéspedes.';



CREATE TABLE H_MOVIMIENTO_PRODUCTO (
	CODIGO               NUMBER(15) NOT NULL ,
	ID_PRODUCTO          NUMBER(5) NOT NULL ,
	TIPO_MOVIMIENTO      VARCHAR2(1) NOT NULL ,
	CANTIDAD             NUMBER(6) NOT NULL ,
	OBSERVACION          VARCHAR2(200) NULL ,
CONSTRAINT  PK_COD_MOVIM PRIMARY KEY (CODIGO)
);

COMMENT ON TABLE H_MOVIMIENTO_PRODUCTO IS 'En esta tabla se registran los movimientos de stock de los productos, ya sea por concepto de compra o venta.';


CREATE TABLE H_PRODUCTO_SERVICIO (
	ID                   NUMBER(5) NOT NULL ,
	DESCRIPCION          VARCHAR2(100) NOT NULL ,
	PRECIO               NUMBER(10) NOT NULL ,
	TIPO                 VARCHAR2(1) NOT NULL ,
	PORC_IVA             NUMBER(3) NOT NULL ,
	CANTIDAD_ACTUAL      NUMBER(6) NULL ,
CONSTRAINT  PK_COD_PROD_SERV PRIMARY KEY (ID)
);

COMMENT ON TABLE H_PRODUCTO_SERVICIO IS 'En la tabla se mantienen los datos de los productos y servicios que ofrece el hotel a los huéspedes. Ej: Lavandería, Masajes, Traslado, Bebidas, Alimentos, etc.
El dominio de la columna TIPO es: P (Producto) - S (Servicio).
Si es un producto se almacena la cantidad en stock';

CREATE TABLE H_TIMBRADO (
	NUMERO_TIMBRADO      NUMBER(15) NOT NULL ,
	EMISION              DATE NOT NULL ,
	ESTABLECIMIENTO      NUMBER(3) NOT NULL ,
	PUNTO_EXPEDICION     NUMBER(3) NOT NULL ,
	NUMERO_DESDE         NUMBER(10) NOT NULL ,
	NUMERO_HASTA         NUMBER(10) NOT NULL ,
	VALIDO_HASTA         DATE NOT NULL ,
	ULTIMO_NUM_EMITIDO   NUMBER(10) NOT NULL ,
CONSTRAINT  PK_COD_TIMBRADO1 PRIMARY KEY (NUMERO_TIMBRADO)
);

COMMENT ON TABLE H_TIMBRADO IS 'En esta tabla se mantienen los datos principales de los timbrados y sus respectivas numeraciones, habilitados por la SET para la facturación.';

CREATE TABLE H_TIPO_DOCUMENTO (
	DESC_ABREVIADA     VARCHAR2(10) NOT NULL ,
	DESC_LARGA           VARCHAR2(100) NOT NULL ,
CONSTRAINT  PK_ID_TIPO_DOC PRIMARY KEY (DESC_ABREVIADA)
);

COMMENT ON TABLE H_TIPO_DOCUMENTO IS 'En esta tabla se registran los tipos de documentos de identidad que podrían presentar los huéspedes. Ej: CI, DNI, PASAPORTE, etc.';


ALTER TABLE H_HABITACION
	ADD (CONSTRAINT CATEGORIA_HABITACION_FK FOREIGN KEY (COD_CATEGORIA) REFERENCES H_CATEGORIA (CODIGO));


ALTER TABLE H_HUESPED
	ADD (CONSTRAINT TIPO_DOCUMENTO_HUESPUED_FK FOREIGN KEY (TIPO_DOCUMENTO) REFERENCES H_TIPO_DOCUMENTO (DESC_ABREVIADA));

ALTER TABLE H_MOVIMIENTO_PRODUCTO
	ADD (CONSTRAINT PRODUCTO_SERVICIO_MOVIMIENT996 FOREIGN KEY (ID_PRODUCTO) REFERENCES H_PRODUCTO_SERVICIO (ID));

CREATE TABLE H_DATOS_EXTERNOS (
    TIPO  VARCHAR2(1),
    TITULAR_OCUPANTE NUMBER(10),
    CHECK_IN DATE,
    CHECK_OUT DATE,
    HABITACION NUMBER(5),
    CANAL NUMBER(3),
    RESERVA NUMBER(12),
    FEC_INGRESO DATE,
    PRODUCTO NUMBER(10),
    PRECIO	 NUMBER(6),
    CANTIDAD NUMBER(6)
);


CREATE TABLE H_RESERVA (
    CODIGO                  NUMBER(12) GENERATED ALWAYS AS IDENTITY 
                            (START WITH 1 MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1)
                            NOT NULL CONSTRAINT PK_COD PRIMARY KEY,
    FECHA_RESERVA           DATE NOT NULL,
    MONTO_TOTAL             NUMBER(10) NOT NULL,
    HUESPED_TITULAR         NUMBER(10) NOT NULL,
    SALDO_ABONAR            NUMBER(10) NOT NULL,
    CHECK_IN                DATE NOT NULL,
    CHECK_OUT               DATE NOT NULL,
    NUM_HABITACION          NUMBER(5) NOT NULL,
    ESTADO                  VARCHAR2(1) DEFAULT 'P' NOT NULL 
                            CHECK (ESTADO IN ('P', 'C', 'X', 'F')),
    CODIGO_CANAL            NUMBER(5) NOT NULL,
    CONSTRAINT CK_INOUT CHECK (CHECK_OUT >= CHECK_IN),
    CONSTRAINT FK_H_TITULAR FOREIGN KEY (HUESPED_TITULAR) 
                            REFERENCES H_HUESPED(CODIGO),
    CONSTRAINT FK_N_HABITACION FOREIGN KEY (NUM_HABITACION) 
                               REFERENCES H_HABITACION(NUMERO),
    CONSTRAINT FK_COD_CANAL FOREIGN KEY (CODIGO_CANAL) 
                            REFERENCES H_CANAL_RESERVA(CODIGO)
);

COMMENT ON TABLE H_RESERVA IS 'Tabla donde se registran las reservas de habitaciones.
La reserva cuenta con 3 estados:
P: Pendiente, por defecto.
C: Confirmada, cuando se abona el 50% del monto correspondiente.
X: Anulada.
F: Facturada. 
Fórmula para obtener el costo total de una reserva: Cantidad de días * (Costo por
noche de la habitación+(Costo adicional huésped * Cantidad adicional huésped)).';


CREATE TABLE H_FACTURA_VENTA (
    CODIGO                  NUMBER(15) NOT NULL 
                            CONSTRAINT PK_CODIGO_FV PRIMARY KEY,
    FECHA_EMISION           DATE NOT NULL,
    FECHA_CARGA             DATE NOT NULL,
    NUMERO_FACTURA          VARCHAR2(20) NOT NULL,
    NUMERO_TIMBRADO         NUMBER(15) NOT NULL,
    MONTO_GRAVADO           NUMBER(15) NOT NULL,
    MONTO_IVA               NUMBER(15) NOT NULL,
    MONTO_EXENTO            NUMBER(15) NOT NULL,
    CODIGO_RESERVA          NUMBER(12) NOT NULL,
    CONSTRAINT FK_NUM_TIMBRADO FOREIGN KEY (NUMERO_TIMBRADO) 
                               REFERENCES H_TIMBRADO(NUMERO_TIMBRADO),
    CONSTRAINT FK_COD_RESERVA FOREIGN KEY (CODIGO_RESERVA) 
                              REFERENCES H_RESERVA(CODIGO)
);

COMMENT ON TABLE H_FACTURA_VENTA IS 'En esta tabla se registran los datos principales para la emisión
del comprobante legal por el pago de los cargos que no fueron entregados como gentileza al huésped.
Sólo se emiten facturas del tipo contado.';


CREATE TABLE H_DETALLE_PAGO (
    COD_FACTURA             NUMBER(15) NOT NULL,
    NUM_ITEM                NUMBER(5) NOT NULL,
    FORMA_PAGO              VARCHAR2(2) NOT NULL 
                            CHECK (FORMA_PAGO IN ('EF', 'TC', 'TD')),
    MONTO                   NUMBER(15) NOT NULL,
    MARCA_TARJETA           VARCHAR2(20),
    NUMERO_TARJETA          VARCHAR2(16),
    CODIGO_EMISOR           NUMBER(5),
    CONSTRAINT PK_FACTURA_ITEM PRIMARY KEY (COD_FACTURA, NUM_ITEM),
    CONSTRAINT CK_FORMA_PAGO CHECK (
        (FORMA_PAGO = 'TD' AND MARCA_TARJETA IS NOT NULL AND NUMERO_TARJETA IS NOT NULL AND
         CODIGO_EMISOR IS NOT NULL) OR 
        (FORMA_PAGO <> 'TD' AND MARCA_TARJETA IS NULL AND NUMERO_TARJETA IS NULL AND 
         CODIGO_EMISOR IS NULL)),
    CONSTRAINT FK_COD_EMISOR FOREIGN KEY (CODIGO_EMISOR) 
                             REFERENCES H_EMISOR_TARJETA(CODIGO)
);

COMMENT ON TABLE H_DETALLE_PAGO IS 'En esta tabla se registra la distribución del pago de una factura.
Existen dos formas de pago: EF (Efectivo), TC (Tarjeta de crédito) y TD (Tarjeta de débito).
En caso de que se abone con TC o TD, se deben completar los campos de: número de tarjeta, marca 
y entidad emisora.';


CREATE TABLE H_CARGO_RESERVA (
    CODIGO_CARGO            NUMBER(10) GENERATED BY DEFAULT AS IDENTITY 
                            (START WITH 1 MINVALUE 1 MAXVALUE 9999999999 INCREMENT BY 1)
                            NOT NULL CONSTRAINT PK_COD_CARGO PRIMARY KEY,
    CODIGO_RESERVA          NUMBER(12) NOT NULL,
    ID_PROD_SERV            NUMBER(5) NOT NULL,
    PRECIO_UNITARIO         NUMBER(10) NOT NULL,
    CANTIDAD                NUMBER(5) NOT NULL,
    APLICAR_COBRO           VARCHAR2(1) DEFAULT 'S' NOT NULL 
                            CHECK (APLICAR_COBRO IN ('S', 'N')),
    CODIGO_FACTURA          NUMBER(15),
    CONSTRAINT FK_COD_RESERVA_CR FOREIGN KEY (CODIGO_RESERVA) 
                                 REFERENCES H_RESERVA(CODIGO),
    CONSTRAINT FK_ID_PROD_SERV FOREIGN KEY (ID_PROD_SERV) 
                               REFERENCES H_PRODUCTO_SERVICIO(ID),
    CONSTRAINT FK_COD_FACTURA FOREIGN KEY (CODIGO_FACTURA) 
                              REFERENCES H_FACTURA_VENTA(CODIGO)
);

COMMENT ON TABLE H_CARGO_RESERVA IS 'En esta tabla se registran todos los productos, servicios
y cargos que deben ser cobrados al huésped. Ej: Servicio de lavandería, Consumo de bebida, Saldo
reserva habitación, etc. Cuando un cargo tiene asociado un código de factura, significa que ya fue abonado.
Existen productos/servicios que se entregan al huésped como gentileza, y estos no deben ser facturados.';


CREATE TABLE H_OCUPANTE (
    CODIGO_OCUPANTE         NUMBER(10) NOT NULL,
    CODIGO_RESERVA          NUMBER(12) NOT NULL,
    FEC_HORA_ENTRADA        DATE NOT NULL,
    FEC_HORA_SALIDA         DATE,
    CONSTRAINT PK_OCUPANTE_RESERVA PRIMARY KEY (CODIGO_OCUPANTE, CODIGO_RESERVA),
    CONSTRAINT CK_FEC_HORA_SALIDA CHECK (
        FEC_HORA_SALIDA IS NULL OR FEC_HORA_SALIDA > FEC_HORA_ENTRADA),
    CONSTRAINT FK_COD_OCUPANTE FOREIGN KEY (CODIGO_OCUPANTE) 
                               REFERENCES H_HUESPED(CODIGO),
    CONSTRAINT FK_COD_RESERVA_HO FOREIGN KEY (CODIGO_RESERVA) 
                                 REFERENCES H_RESERVA(CODIGO)
);

COMMENT ON TABLE H_OCUPANTE IS 'En esta tabla se registra(n) la(s) persona(s) que ocupará(n) 
la habitación reservada.';





-- menu del hotel con imagenes y algunos  movimientos en modelos
-- H_PRODUCTO_SERVICIO depende de H_MOVIMIENTO_PRODUCTO
-- H_CARGO_RESERVA depende de H_PRODUCTO_SERVICIO


-- parte intermedia de union del ocupante, el historial de las facturas (consesiones)
-- y los precios del servicio
-- la tabla H_RESERVA une a H_CARGO_RESERVA, H_FACTURA_VENTA, h_ocupante,
-- H_CANAL_RESERVA y H_HUESPED (H_HUESPED depende de H_TIPO_DOCUMENTO)

-- cabecera y detalle
-- H_DETALLE_PAGO (depende de H_EMISOR_TARJETA)

-- H_FACTURA_VENTA depende de H_DETALLE_PAGO
-- H_TIMBRADO depende de H_FACTURA_VENTA

