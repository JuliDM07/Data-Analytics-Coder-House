-- =============================================================================
-- PROYECTO: RetailPro - Extrayendo métricas clave con SQL
-- TITULO: Cruzando tablas para enriquecer el análisis
-- ARCHIVO: m5_consultas_joins.sql
-- AUTOR: Julian Di Marco
-- BASE DE DATOS: Ventas_Tech_DB
-- =============================================================================

----------------------------------------------------
----------------------------------------------------
-- Consulta 1: Vista base del proyecto (INNER JOIN)
-- Sirve para combinar ventas con clientes, productos y categorías, generando
-- una vista enriquecida que podrá utilizarse como fuente principal en Power BI.
----------------------------------------------------
----------------------------------------------------
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

-- Hallazgo: la vista consolidada reúne las 10 ventas registradas y permite 
-- analizarlas por cliente, ciudad, producto y categoría desde una única consulta.

-------------
-- Consulta 2: Clientes sin ventas (LEFT JOIN)
-- Sirve para identificar clientes registrados que todavía no realizaron compras,
-- de modo que el área de CRM pueda detectarlos y definir acciones de contacto.
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

-- Hallazgo: aparecen 0 clientes sin ventas; los 5 clientes registrados ya
-- realizaron al menos una compra, por lo que CRM no tiene clientes inactivos en esta muestra.

--------------
-- Consulta 3: Productos sin ventas (LEFT JOIN)
-- Sirve para detectar productos del catálogo que todavía no registran ventas,
-- permitiendo al área de Producto identificar artículos sin movimiento.
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

-- Hallazgo: aparecen 0 productos sin ventas; los 6 productos del catálogo
-- tienen al menos una operación registrada, por lo que no hay artículos sin movimiento.

-------------
-- Consulta 4: Consolidado por canal (UNION ALL)
-- Sirve para crear una columna de canal como valor literal, unir dos grupos
-- de ventas con UNION ALL y comparar la facturación total de cada canal.
-- Nota: como la tabla ventas no contiene un canal real, las etiquetas Online
-- y Presencial se asignan a dos períodos distintos únicamente para este ejercicio.
--------------

SELECT
    canal,
    SUM(total) AS total_canal
FROM (
    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Online' AS canal
    FROM ventas
    WHERE fecha_venta <= '2024-03-10'

    UNION ALL

    SELECT
        fecha_venta,
        cantidad * precio_unitario AS total,
        'Presencial' AS canal
    FROM ventas
    WHERE fecha_venta >= '2024-03-11'
) AS consolidado
GROUP BY canal
ORDER BY total_canal DESC;

-- Hallazgo: el canal etiquetado como Online facturó $3.620 y el canal etiquetado
-- como Presencial facturó $2.824. En esta muestra, Online concentra aproximadamente
-- el 56,2% de la facturación total.