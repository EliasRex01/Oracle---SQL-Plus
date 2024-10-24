
CREATE TABLE H_CANAL_RESERVA
(
	CODIGO               NUMBER(5) NOT NULL ,
	NOMBRE               VARCHAR2(100) NOT NULL ,
	HABILITADO           VARCHAR2(1) NOT NULL ,
CONSTRAINT  PK_COD_CANAL PRIMARY KEY (CODIGO)
);



COMMENT ON TABLE H_CANAL_RESERVA IS 'Tabla donde se registran los medios a trav�s de los cuales se realiza la reserva de una habitaci�n. Ej: Contac Center, Mostrador, Sitio Web, etc';



CREATE TABLE H_CATEGORIA
(
	CODIGO               NUMBER(5) NOT NULL ,
	DESCRIPCION          VARCHAR2(100) NOT NULL ,
	COSTO_X_NOCHE        NUMBER(10) NOT NULL ,
	COSTO_ADICIONAL_HUESP NUMBER(10) NOT NULL ,
	CAPACIDAD_MAXIMA     NUMBER(3) NOT NULL ,
CONSTRAINT  PK_COD_CATEGORIA PRIMARY KEY (CODIGO)
);


COMMENT ON TABLE H_CATEGORIA IS 'Tabla donde se mantiene los datos de las categor�as de habitaciones con que cuenta el hotel. Ej: Simple, matrimonial, triple, etc.';


CREATE TABLE H_EMISOR_TARJETA
(
	CODIGO               NUMBER(5) NOT NULL ,
	NOMBRE               VARCHAR2(150) NOT NULL ,
	DIRECCION            VARCHAR2(200) NOT NULL ,
	TELEFONO             VARCHAR2(15) NOT NULL ,
	EMAIL                VARCHAR2(20) NOT NULL ,
	TIPO                 VARCHAR2(1) NOT NULL ,
CONSTRAINT  PK_COD_BANCO PRIMARY KEY (CODIGO)
);


COMMENT ON TABLE H_EMISOR_TARJETA IS 'En esta tabla se mantienen los datos de entidades emisoras de tarjetas de cr�dito y d�bito.
Existen 3 tipos: B (Banco), F (Financiera) y C (Cooperativa).';


CREATE TABLE H_HABITACION
(
	NUMERO               NUMBER(5) NOT NULL ,
	PISO                 NUMBER(3) NOT NULL ,
	COD_CATEGORIA        NUMBER(5) NOT NULL ,
	OCUPADO              VARCHAR2(1) NOT NULL ,
CONSTRAINT  PK_NUM_HABITACION PRIMARY KEY (NUMERO)
);


COMMENT ON TABLE H_HABITACION IS 'Tabla donde se registran los datos de las habitaciones del hotel.';


CREATE TABLE H_HUESPED
(
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


COMMENT ON TABLE H_HUESPED IS 'Tabla donde se mantienen los datos b�sicos de los hu�spedes.';



CREATE TABLE H_MOVIMIENTO_PRODUCTO
(
	CODIGO               NUMBER(15) NOT NULL ,
	ID_PRODUCTO          NUMBER(5) NOT NULL ,
	TIPO_MOVIMIENTO      VARCHAR2(1) NOT NULL ,
	CANTIDAD             NUMBER(6) NOT NULL ,
	OBSERVACION          VARCHAR2(200) NULL ,
CONSTRAINT  PK_COD_MOVIM PRIMARY KEY (CODIGO)
);


COMMENT ON TABLE H_MOVIMIENTO_PRODUCTO IS 'En esta tabla se registran los movimientos de stock de los productos, ya sea por concepto de compra o venta.';


CREATE TABLE H_PRODUCTO_SERVICIO
(
	ID                   NUMBER(5) NOT NULL ,
	DESCRIPCION          VARCHAR2(100) NOT NULL ,
	PRECIO               NUMBER(10) NOT NULL ,
	TIPO                 VARCHAR2(1) NOT NULL ,
	PORC_IVA             NUMBER(3) NOT NULL ,
	CANTIDAD_ACTUAL      NUMBER(6) NULL ,
CONSTRAINT  PK_COD_PROD_SERV PRIMARY KEY (ID)
);


COMMENT ON TABLE H_PRODUCTO_SERVICIO IS 'En la tabla se mantienen los datos de los productos y servicios que ofrece el hotel a los hu�spedes. Ej: Lavander�a, Masajes, Traslado, Bebidas, Alimentos, etc.
El dominio de la columna TIPO es: P (Producto) - S (Servicio).
Si es un producto se almacena la cantidad en stock';

CREATE TABLE H_TIMBRADO
(
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

COMMENT ON TABLE H_TIMBRADO IS 'En esta tabla se mantienen los datos principales de los timbrados y sus respectivas numeraciones, habilitados por la SET para la facturaci�n.';

CREATE TABLE H_TIPO_DOCUMENTO
(
	DESC_ABREVIADA     VARCHAR2(10) NOT NULL ,
	DESC_LARGA           VARCHAR2(100) NOT NULL ,
CONSTRAINT  PK_ID_TIPO_DOC PRIMARY KEY (DESC_ABREVIADA)
);


COMMENT ON TABLE H_TIPO_DOCUMENTO IS 'En esta tabla se registran los tipos de documentos de identidad que podr�an presentar los hu�spedes. Ej: CI, DNI, PASAPORTE, etc.';


ALTER TABLE H_HABITACION
	ADD (CONSTRAINT CATEGORIA_HABITACION_FK FOREIGN KEY (COD_CATEGORIA) REFERENCES H_CATEGORIA (CODIGO));


ALTER TABLE H_HUESPED
	ADD (CONSTRAINT TIPO_DOCUMENTO_HUESPUED_FK FOREIGN KEY (TIPO_DOCUMENTO) REFERENCES H_TIPO_DOCUMENTO (DESC_ABREVIADA));



ALTER TABLE H_MOVIMIENTO_PRODUCTO
	ADD (CONSTRAINT PRODUCTO_SERVICIO_MOVIMIENT996 FOREIGN KEY (ID_PRODUCTO) REFERENCES H_PRODUCTO_SERVICIO (ID));

CREATE TABLE H_DATOS_EXTERNOS
(TIPO  VARCHAR2(1),
 TITULAR_OCUPANTE NUMBER(10),
 CHECK_IN DATE,
 CHECK_OUT DATE,
 HABITACION NUMBER(5),
 CANAL NUMBER(3),
 RESERVA NUMBER(12),
 FEC_INGRESO DATE,
 PRODUCTO NUMBER(10),
 PRECIO	 NUMBER(6),
 CANTIDAD NUMBER(6));

