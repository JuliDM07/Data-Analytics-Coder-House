-- =============================================================================
-- PROYECTO: RetailPro - Extrayendo métricas clave con SQL
-- ARCHIVO: m5_consultas_joins.sql
-- AUTOR: Julian Di Marco
-- BASE DE DATOS: Ventas_Tech_DB
-- =============================================================================

select*from clientes

-- Consulta 1
SELECT
    v.id_venta,
    v.fecha_venta,
    c.id_cliente,
    c.nombre AS nombre_cliente,
    c.ciudad,
    p.id_producto,
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    v.cantidad,
    v.precio_unitario,
    (v.cantidad * v.precio_unitario) AS total_venta
FROM ventas AS v
INNER JOIN clientes AS c
    ON v.id_cliente = c.id_cliente
INNER JOIN productos AS p
    ON v.id_producto = p.id_producto
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
ORDER BY v.fecha_venta, v.id_venta;

-------------
-- Consulta 2
-------------
SELECT
    c.nombre,
    c.email,
    c.fecha_registro
FROM clientes AS c
LEFT JOIN ventas AS v
    ON c.id_cliente = v.id_cliente
WHERE v.id_venta IS NULL
ORDER BY c.nombre;

-------------
-- Consulta 3
--------------
SELECT
    p.nombre_producto,
    cat.nombre_categoria AS categoria,
    p.precio
FROM productos AS p
INNER JOIN categorias AS cat
    ON p.id_categoria = cat.id_categoria
LEFT JOIN ventas AS v
    ON p.id_producto = v.id_producto
WHERE v.id_venta IS NULL
ORDER BY p.nombre_producto;

-------------
-- Consulta 4
--------------

SELECT
    consolidado.canal,
    SUM(consolidado.total_venta) AS total_facturado
FROM (
    SELECT
        'Primer periodo' AS canal,
        (cantidad * precio_unitario) AS total_venta
    FROM ventas
    WHERE fecha_venta < '2024-03-11'

    UNION ALL

    SELECT
        'Segundo periodo' AS canal,
        (cantidad * precio_unitario) AS total_venta
    FROM ventas
    WHERE fecha_venta >= '2024-03-11'
) AS consolidado
GROUP BY consolidado.canal
ORDER BY total_facturado DESC;