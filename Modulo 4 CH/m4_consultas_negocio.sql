-- =============================================================================
-- PROYECTO: RetailPro - Extrayendo métricas clave con SQL
-- ARCHIVO: m4_consultas_negocio.sql
-- AUTOR: Julian Di Marco
-- BASE DE DATOS: Ventas_Tech_DB
-- TABLA: ventas (id_venta, id_cliente, id_producto, cantidad, precio_unitario, fecha_venta)
-- =============================================================================

USE Ventas_Tech_DB;
GO

----------------------------------------------------------------------------------------
-- CONSULTA 1: RESUMEN EJECUTIVO MENSUAL
-- Objetivo: Total facturado, cantidad de pedidos y ticket promedio, agrupados por mes.
----------------------------------------------------------------------------------------

SELECT 
MONTH (fecha_venta) as mes,
SUM (cantidad * precio_unitario) as total_facturado,
COUNT(*) AS cantidad_pedidos,
AVG (cantidad*precio_unitario) as ticket_promedio
FROM ventas
GROUP BY MONTH(fecha_venta)
ORDER BY mes ASC;
GO

----------------------------------------------------------------------------------------
-- CONSULTA 2: Ranking de productos
-- Objetivo: Top 5 por total facturado, mostrando unidades vendidas y facturacion generada
----------------------------------------------------------------------------------------
SELECT top 5
id_producto,
SUM (cantidad) as unidades_vendidas,
SUM (cantidad * precio_unitario) as total_generado
FROM ventas
GROUP BY id_producto
ORDER BY total_generado DESC;
GO

-- -----------------------------------------------------------------------------
-- CONSULTA 3: Clientes recurrentes
-- Objetivo: id_cliente con más de un pedido, con conteo y total gastado.
-- -----------------------------------------------------------------------------

SELECT
id_cliente,
COUNT(*) as cantidad_pedidos,
SUM (cantidad*precio_unitario) as total_gastado
from ventas
group by id_cliente
HAVING COUNT(*)>1
ORDER BY cantidad_pedidos DESC, total_gastado DESC;

-- -----------------------------------------------------------------------------
-- CONSULTA 4: Meses por encima/por debajo del promedio mensual general
-- Objetivo: Total facturado por mes categorizado según la media de facturación mensual.
-- -----------------------------------------------------------------------------

SELECT
    resumen_mensual.mes,
    resumen_mensual.total_facturado,
    CASE
        WHEN resumen_mensual.total_facturado > (
            SELECT AVG(CAST(promedios.total_facturado AS DECIMAL(18,2)))
            FROM (
                SELECT
                    MONTH(fecha_venta) AS mes,
                    SUM(cantidad * precio_unitario) AS total_facturado
                FROM ventas
                GROUP BY MONTH(fecha_venta)
            ) AS promedios
        )
        THEN 'Por encima'
        ELSE 'Por debajo'
    END AS comparacion_promedio
FROM (
    SELECT
        MONTH(fecha_venta) AS mes,
        SUM(cantidad * precio_unitario) AS total_facturado
    FROM ventas
    GROUP BY MONTH(fecha_venta)
) AS resumen_mensual
ORDER BY resumen_mensual.mes;

-- ===============================================
-- Bloque de cierre: comentarios finales
-- ===============================================

-- 1. La facturación total registrada es de 6.444 y todas las ventas cargadas
--    corresponden a marzo de 2024; por eso todavía no existe una comparación
--    real entre distintos meses.

-- 2. El producto con id_producto = 1 genera 3.600 de facturación,
--    aproximadamente el 55,9% del total registrado.

-- 3. Los cinco clientes realizaron más de 1 pedido. El cliente 1 es quien
--    más gastó, con un total de 2.640, seguido por el cliente 5 con 2.100.