-- ========================
-- APLICACIÓN DE ACID
-- ========================
-- Ejemplo: Registro de una venta
-- Tablas involucradas:
-- ventas, detalle_ventas, productos
-- ========================

-- ========================
-- INICIO DE TRANSACCIÓN
-- (Atomicidad)
-- ========================
START TRANSACTION;

-- ========================
-- REGISTRO DE LA VENTA
-- ========================
INSERT INTO ventas (id_cliente, id_usuario, fecha_venta, total)
VALUES (1, 2, NOW(), 50.00);

-- Guardar el ID de la venta
SET @id_venta = LAST_INSERT_ID();

-- ========================
-- REGISTRO DEL DETALLE
-- ========================
INSERT INTO detalle_ventas (
    id_venta,
    id_producto,
    cantidad,
    precio_unitario,
    subtotal
)
VALUES (@id_venta, 3, 2, 25.00, 50.00);

-- ========================
-- ACTUALIZACIÓN DE STOCK
-- (Consistencia)
-- ========================
UPDATE productos
SET stock = stock - 2
WHERE id_producto = 3
  AND stock >= 2;

-- ========================
-- VALIDACIÓN DE STOCK
-- Si no se actualizó el producto,
-- se cancela toda la transacción
-- ========================
IF ROW_COUNT() = 0 THEN
    ROLLBACK;
END IF;

-- ========================
-- CONFIRMACIÓN DE TRANSACCIÓN
-- (Durabilidad)
-- ========================
COMMIT;
