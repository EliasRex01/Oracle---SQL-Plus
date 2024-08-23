-- a. Las tablas descriptas en el cuadro más abajo, deben ser creadas con las reglas de integridad
-- relacional (PK, FK, Checks) definidas.
-- b. Incluir los comentarios a nivel de las tablas


CREATE TABLE H_CARGO_RESERVA
(
	CODIGO               NUMBER(5) NOT NULL ,
	NOMBRE               VARCHAR2(100) NOT NULL ,
	HABILITADO           VARCHAR2(1) NOT NULL ,
CONSTRAINT  PK_COD_CANAL PRIMARY KEY (CODIGO)
);

COMMENT ON TABLE H_CARGO_RESERVA IS 'En esta tabla se registran todos los productos, servicios
y cargos que deben ser cobrados al huésped. Ej: Servicio de lavandería, Consumo de bebida, Saldo
reserva habitación, etc. Cuando un cargo tiene asociado un código de factura, significa que ya fue abonado.
Existen productos/servicios que se entregan al huésped como gentileza, y estos no deben ser facturados.';

ALTER TABLE H_CARGO_RESERVA
	ADD (CONSTRAINT CATEGORIA_HABITACION_FK FOREIGN KEY (COD_CATEGORIA) REFERENCES H_CATEGORIA (CODIGO));


CREATE TABLE H_CATEGORIA
(
	CODIGO               NUMBER(5) NOT NULL ,
	DESCRIPCION          VARCHAR2(100) NOT NULL ,
	COSTO_X_NOCHE        NUMBER(10) NOT NULL ,
	COSTO_ADICIONAL_HUESP NUMBER(10) NOT NULL ,
	CAPACIDAD_MAXIMA     NUMBER(3) NOT NULL ,
CONSTRAINT  PK_COD_CATEGORIA PRIMARY KEY (CODIGO)
);


COMMENT ON TABLE H_CATEGORIA IS 'Tabla donde se mantiene los datos de las categorías de habitaciones con que cuenta el hotel. Ej: Simple, matrimonial, triple, etc.';


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


COMMENT ON TABLE H_HUESPED IS 'Tabla donde se mantienen los datos básicos de los huéspedes.';


CREATE TABLE H_TIPO_DOCUMENTO
(
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
