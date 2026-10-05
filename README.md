# sql-server-data-migration-bi

Inmobiliaria — Modelado de datos, migración y BI en SQL Server

Proyecto académico de la materia Gestión de Datos (UTN FRBA).

El problema

Una inmobiliaria tenía toda su operación registrada en una única tabla plana de ~90 columnas: inmuebles, propietarios, anuncios, agentes, sucursales, ventas, alquileres, inquilinos y pagos, todo mezclado y repetido en cada fila.

El objetivo fue transformar esos datos en algo consistente y útil para la toma de decisiones:

Modelo transaccional: diseñar un modelo relacional normalizado y migrar todos los datos a él.
Modelo de BI: construir un modelo dimensional sobre el anterior y exponer indicadores de negocio mediante vistas.
Tecnologías
SQL Server 2019 · T-SQL
SQL Server Management Studio
Qué incluye
Archivo	Contenido
script_creacion_inicial.sql	Creación del esquema, tablas, claves y constraints, y stored procedures de migración
script_creacion_BI.sql	Modelo dimensional (hechos y dimensiones), carga y vistas de indicadores
verificacion.sql	Controles post-migración: compara cantidades entre origen y destino para detectar duplicados o pérdidas
Modelo transaccional
<!-- Agregar imagen del DER: ![DER](docs/der.png) -->

Algunas decisiones de diseño:

Persona como entidad común para agentes, propietarios, inquilinos y compradores, evitando duplicar datos personales. Los roles se modelan como relaciones con inmuebles, alquileres y ventas.
Catálogos para todos los valores tipificados (tipo de inmueble, estado, moneda, medio de pago, etc.).
Jerarquía de ubicación Provincia → Localidad → Barrio, reutilizada por inmuebles y sucursales.
Características de inmuebles como relación N:M, en lugar de columnas booleanas fijas.
El anuncio como eje del modelo: ventas y alquileres se originan en un anuncio.
Migración
Implementada con stored procedures, en orden de dependencias (primero catálogos y ubicación, después entidades con claves foráneas).
Todo el proceso corre en un único script, de una sola vez, sobre una base limpia.
Los datos de origen no se modifican: las inconsistencias detectadas se resolvieron desde el diseño.
Modelo de BI
<!-- Agregar imagen del modelo estrella: ![BI](docs/bi.png) -->

Modelo estrella con dimensiones de tiempo, ubicación, sucursal, rango etario, tipo de inmueble, ambientes, rango de superficie, tipo de operación y moneda.

Las vistas resuelven indicadores como:

Tiempo promedio de publicación de anuncios.
Precio promedio por tipo de inmueble y superficie.
Barrios más demandados para alquilar según la edad del inquilino.
Morosidad en pagos de alquiler.
Evolución del valor de los alquileres.
Comisiones y montos de cierre por sucursal.
Tasa de conversión de anuncios en operaciones.
