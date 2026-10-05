-------------------INICIO SCRIPT script_creacion_inicial.sql-------------------

--USAR DATABASE GD2C2023
USE GD2C2023
GO
--CREAR ESQUEMA INMOBILIARIA
CREATE SCHEMA INMOBILIARIA
GO

-------------------------------CREACION-----------------------------------------

--CREAR PROCEDIMIENTO DE CREACION DE DATOS (TABLAS CON SUS RESPECTIVAS PK,FK)
CREATE PROCEDURE INMOBILIARIA.creacionDatos
AS
--CREAR PROVINCIA
CREATE TABLE INMOBILIARIA.Provincia (
    provincia_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    provincia_detalle nvarchar(50)
)
--CREAR LOCALIDAD
CREATE TABLE INMOBILIARIA.Localidad (
    localidad_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    localidad_provincia numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.Provincia(provincia_codigo),
    localidad_detalle nvarchar(50)
)
--CREAR BARRIO
CREATE TABLE INMOBILIARIA.Barrio (
    barrio_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    barrio_localidad numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.Localidad(localidad_codigo),
    barrio_detalle nvarchar(50)
)
--CREAR SUCURSAL
CREATE TABLE INMOBILIARIA.Sucursal (
    sucursal_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    sucursal_localidad numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.Localidad(localidad_codigo),
    sucursal_detalle nvarchar(50),
    sucursal_direccion nvarchar(50),
    sucursal_telefono nvarchar(50)
)
--CREAR TIPOINMUEBLE
CREATE TABLE INMOBILIARIA.TipoInmueble (
    tipo_inmueble_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    tipo_inmueble_detalle nvarchar(100)
)
--CREAR ESTADOINMUEBLE
CREATE TABLE INMOBILIARIA.EstadoInmueble (
    estado_inmueble_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    estado_inmueble_detalle nvarchar(50)
)
--CREAR AMBIENTES
CREATE TABLE INMOBILIARIA.Ambientes (
    ambientes_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    ambientes_detalle nvarchar(50)
)
--CREAR DISPOSICION
CREATE TABLE INMOBILIARIA.Disposicion (
    disposicion_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    disposicion_detalle nvarchar(50)
)
--CREAR ORIENTACION
CREATE TABLE INMOBILIARIA.Orientacion (
    orientacion_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    orientacion_detalle nvarchar(50)
)
--CREAR CARACTERISTICA
CREATE TABLE INMOBILIARIA.Caracteristica (
    caracteristica_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    caracteristica_detalle nvarchar(50)
)
--CREAR INMUEBLE
CREATE TABLE INMOBILIARIA.Inmueble (
	inmueble_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    inmueble_tipo numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.TipoInmueble(tipo_inmueble_codigo) NOT NULL,
    inmueble_barrio numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.Barrio(barrio_codigo),
    inmueble_ambientes numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.Ambientes(ambientes_codigo),
    inmueble_orientacion numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.Orientacion(orientacion_codigo),
    inmueble_disposicion numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.Disposicion(disposicion_codigo),
    inmueble_estado numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.EstadoInmueble(estado_inmueble_codigo),
    inmueble_nombre nvarchar(100),
    inmueble_descripcion nvarchar(100),
    inmueble_direccion nvarchar(100),
    inmueble_superficie numeric(10,0),
    inmueble_antiguedad numeric(4,0),
    inmueble_expensas numeric(18,2)
)
--CREAR CARACXINMUEBLE
CREATE TABLE INMOBILIARIA.CaracteristicaPorInmueble (
    caracInmueble_caracteristica numeric(18,0) NOT NULL,
	caracInmueble_inmueble numeric(18,0) NOT NULL,
	PRIMARY KEY(caracInmueble_caracteristica,caracInmueble_inmueble),
	FOREIGN KEY (caracInmueble_caracteristica) REFERENCES INMOBILIARIA.Caracteristica(caracteristica_codigo),
    FOREIGN KEY (caracInmueble_inmueble) REFERENCES INMOBILIARIA.Inmueble(inmueble_codigo)
)
--CREAR PERSONA
CREATE TABLE INMOBILIARIA.Persona (
    persona_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    persona_nombre nvarchar(50),
    persona_apellido nvarchar(50),
    persona_dni char(8),
    persona_fecha_registro smalldatetime,
    persona_telefono nvarchar(50),
    persona_mail nvarchar(100),
    persona_fecha_nacimiento smalldatetime
)
--CREAR AGENTE
CREATE TABLE INMOBILIARIA.Agente (
    agente_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    agente_persona numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.Persona(persona_codigo),
    agente_sucursal numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.Sucursal(sucursal_codigo)
)
--CREAR PROPIETARIO
CREATE TABLE INMOBILIARIA.Propietario (
    propietario_persona numeric(18,0) NOT NULL,
    propietario_inmueble numeric(18,0) NOT NULL,
    PRIMARY KEY(propietario_persona,propietario_inmueble),
    FOREIGN KEY (propietario_persona) REFERENCES INMOBILIARIA.Persona(persona_codigo),
    FOREIGN KEY (propietario_inmueble) REFERENCES INMOBILIARIA.Inmueble(inmueble_codigo)
)
--CREAR MONEDA
CREATE TABLE INMOBILIARIA.Moneda (
    moneda_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    moneda_detalle nvarchar(100)
)
--CREAR MEDIODEPAGO
CREATE TABLE INMOBILIARIA.MedioDePago (
    medioDePago_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    medioDePago_detalle nvarchar(50)
)
--CREAR TIPOSPERIODOSANUNCIO
CREATE TABLE INMOBILIARIA.TiposPeriodosAnuncio (
    tipoPeriodo_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    tipoPeriodo_detalle nvarchar(100)
)
--CREAR ESTADOANUNCIO
CREATE TABLE INMOBILIARIA.EstadoAnuncio (
    estadoAnuncio_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    estadoAnuncio_Detalle nvarchar(100)
)
--CREAR TIPO OPERACION
CREATE TABLE INMOBILIARIA.TipoOperacion (
    tipoOperacion_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    tipoOperacion_detalle nvarchar(100)
)
--CREAR ANUNCIO
CREATE TABLE INMOBILIARIA.Anuncio (
    anuncio_codigo numeric(19,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    anuncio_tipoOperacion numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.TipoOperacion(tipoOperacion_codigo),
    anuncio_moneda numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.Moneda(moneda_codigo),
    anuncio_inmueble numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.Inmueble(inmueble_codigo),
    anuncio_agente numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.Agente(agente_codigo),
    anuncio_estadoAnuncio numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.EstadoAnuncio(estadoAnuncio_codigo),
    anuncio_tipoPeriodo numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.TiposPeriodosAnuncio(tipoPeriodo_codigo),
    anuncio_fechaPublicacion smalldatetime,
    anuncio_precioPublicado numeric(18,2),
    anuncio_costoAnuncio numeric(18,2),
    anuncio_fechaFinalizacion smalldatetime
)
--CREAR ESTADOALQUILER
CREATE TABLE INMOBILIARIA.EstadoAlquiler (
    estado_alquiler_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    estado_alquiler_detalle nvarchar(50)
)
--CREAR ALQUILER
CREATE TABLE INMOBILIARIA.Alquiler (
    alquiler_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    alquiler_anuncio_codigo numeric(19,0) FOREIGN KEY REFERENCES INMOBILIARIA.Anuncio(anuncio_codigo),
    alquiler_estado numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.EstadoAlquiler(estado_alquiler_codigo),
    alquiler_fecha_inicio smalldatetime,
    alquiler_fecha_fin smalldatetime,
    alquiler_cantidad_periodos numeric(18,0),
    alquiler_deposito numeric(18,0),
    alquiler_comision numeric(18,0),
    alquiler_gastos_averiguaciones numeric(18,2)
)
--CREAR IMPORTEPORPERIODOS
CREATE TABLE INMOBILIARIA.ImportePorPeriodos (
    ip_alquiler_codigo numeric(18,0) NOT NULL,
    ip_nroPeriodoInicio numeric(4,0) NOT NULL,
    ip_nroPeriodoFin numeric(4,0) NOT NULL,
    PRIMARY KEY(ip_alquiler_codigo,ip_nroPeriodoInicio,ip_nroPeriodoFin),
    FOREIGN KEY (ip_alquiler_codigo) REFERENCES INMOBILIARIA.Alquiler(alquiler_codigo),
    ip_precio numeric(18,2)
)
--CREAR PAGOALQUILER
CREATE TABLE INMOBILIARIA.PagoAlquiler (
    pagoAlquiler_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    pagoAlquiler_alquiler numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.Alquiler(alquiler_codigo),
    pagoAlquiler_medioDePago numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.MedioDePago(medioDePago_codigo),
    pagoAlquiler_fechaPago smalldatetime,
    pagoAlquiler_nroPeriodo numeric(4,0),
    pagoAlquiler_detallePeriodo nvarchar(100),
    pagoAlquiler_fechaInicioPeriodo smalldatetime,
    pagoAlquiler_fechaFinPeriodo smalldatetime,
    pagoAlquiler_importe numeric(18,2)
)
--CREAR INQUILINO
CREATE TABLE INMOBILIARIA.Inquilino (
    inquilino_persona numeric(18,0) NOT NULL,
    inquilino_alquiler numeric(18,0) NOT NULL,
    PRIMARY KEY(inquilino_persona,inquilino_alquiler),
    FOREIGN KEY (inquilino_alquiler) REFERENCES INMOBILIARIA.Alquiler(alquiler_codigo),   
    FOREIGN KEY (inquilino_persona) REFERENCES INMOBILIARIA.Persona(persona_codigo)    

)
--CREAR VENTA
CREATE TABLE INMOBILIARIA.Venta (
    venta_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    venta_moneda numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.Moneda(moneda_codigo) NOT NULL,
    venta_anuncio numeric(19,0) FOREIGN KEY REFERENCES INMOBILIARIA.Anuncio(anuncio_codigo) NOT NULL,
    venta_fecha smalldatetime,
    venta_comision numeric(18,2),
    venta_precio numeric(18,2)
)
--CREAR COMPRADOR
CREATE TABLE INMOBILIARIA.Comprador (
    comprador_venta numeric(18,0) NOT NULL,
	comprador_persona numeric(18,0) NOT NULL,
    PRIMARY KEY(comprador_persona,comprador_venta),
    FOREIGN KEY (comprador_persona) REFERENCES INMOBILIARIA.Persona(persona_codigo),
    FOREIGN KEY (comprador_venta) REFERENCES INMOBILIARIA.Venta(venta_codigo)
)
--CREAR PAGOVENTA
CREATE TABLE INMOBILIARIA.PagoVenta (
    pagoVenta_codigo numeric(18,0) IDENTITY(1,1) PRIMARY KEY NOT NULL,
    pagoVenta_venta numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.Venta(venta_codigo),
    pagoVenta_moneda numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.Moneda(moneda_codigo),
    pagoVenta_medioDePago numeric(18,0) FOREIGN KEY REFERENCES INMOBILIARIA.MedioDePago(medioDePago_codigo),
    pagoVenta_importe numeric(18,2),
    pagoVenta_cotizacion numeric(18,2)
)

GO
