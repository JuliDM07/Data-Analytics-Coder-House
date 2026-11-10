RetailPro — Proyecto de Data Analytics

DESCRIPCIÓN

RetailPro es un proyecto integrador desarrollado durante el curso de Data Analytics / Data Scientist de CoderHouse.
El objetivo del proyecto es construir un flujo completo de análisis de datos para una empresa distribuidora de tecnología, abarcando desde el diseño y creación de una base de datos relacional hasta la construcción de un modelo analítico y dashboard en Power BI.
El proyecto busca responder preguntas de negocio relacionadas con ventas, clientes, productos, categorías y desempeño comercial.

Tecnologías utilizadas:

-Microsoft SQL Server
-SQL
-Power BI Desktop
-Power Query
-Lenguaje M
-DAX
-GitHub
-Inteligencia Artificial generativa como herramienta de asistencia y documentación

ESTRUCTURA DEL PROYECTO

El proyecto fue desarrollado de manera incremental a lo largo de distintos módulos:

-M1: definición del problema de negocio, preguntas de análisis y KPIs.
-M2: diseño del modelo relacional.
-M3: creación de la base de datos y carga inicial mediante SQL.
-M4: consultas SQL de negocio y métricas.
-M5: consultas con JOIN y UNION ALL.
-M6: pipeline ETL en Power Query.
-M7: diseño del dashboard y storytelling.
-M8: modelo analítico, relaciones y medidas DAX.
-M9: uso de IA para documentación, validación y optimización.

MODELO DE DATOS

El modelo utiliza una estructura basada en tablas de hechos y dimensiones.

Principales tablas:

-Fact_Ventas
-Dim_Clientes
-Dim_Productos
-Dim_Categorias
-Dim_Fechas

Las relaciones fueron configuradas principalmente con cardinalidad 1:N y dirección de filtro única.

PRINCIPALES MEDIDAS DAX
Entre las medidas desarrolladas se encuentran:

Total Ventas =
SUM(Fact_Ventas[total_venta])

Ventas Online =
CALCULATE(
    [Total Ventas],
    Fact_Ventas[canal] = "Online"
)

Ventas YTD =
TOTALYTD(
    [Total Ventas],
    Dim_Fechas[Date]
)

Ventas LY =
CALCULATE(
    [Total Ventas],
    SAMEPERIODLASTYEAR(Dim_Fechas[Date])
)

También se desarrolló una medida de crecimiento anual utilizando VAR y DIVIDE.

EJECUCION DE LOS SCRIPTS SQL

-Abrir Microsoft SQL Server Management Studio.
-Ejecutar el script de creación de la base de datos.
-Verificar que se haya creado Ventas_Tech_DB.
-Ejecutar los scripts correspondientes a los módulos de consultas SQL.
-Verificar que las tablas y relaciones se hayan creado correctamente antes de ejecutar las consultas posteriores.

Los scripts fueron desarrollados para Microsoft SQL Server, por lo que algunas funciones pueden requerir modificaciones si se utilizan en otro motor de base de datos.

FLUJO ETL

Los datos fueron importados a Power BI y transformados mediante Power Query.

Entre las principales transformaciones se encuentran:

-eliminación de registros duplicados;
-tratamiento de valores nulos;
-corrección de tipos de datos;
-normalización de nombres de consultas;
-combinación de tablas mediante Merge;
-documentación de transformaciones mediante lenguaje M.

DASHBOARD

El dashboard de RetailPro fue diseñado utilizando una jerarquía visual basada en el patrón de lectura en Z.

Incluye:

-KPIs comerciales;
-análisis del ticket promedio;
-comparación entre canales;
-análisis de productos;
-filtros interactivos;
-detalle de transacciones.

USO DE IA
La IA generativa fue utilizada como herramienta de apoyo para:

-explicar conceptos técnicos;
-revisar código SQL;
-proponer optimizaciones;
-generar borradores de documentación;
-analizar resultados y proponer insights.

Todas las respuestas generadas mediante IA fueron posteriormente revisadas y validadas utilizando los datos y el criterio analítico del proyecto.

Autor

Julian Di Marco
