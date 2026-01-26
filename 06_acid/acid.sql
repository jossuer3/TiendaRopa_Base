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
CREATE PROCEDURE registrar_venta()
BEGIN
    DECLARE filas INT;

    START TRANSACTION;

    INSERT INTO ventas VALUES (NULL,NOW(),50.00,1,2);
    SET @id_venta = LAST_INSERT_ID();

    UPDATE productos
    SET stock = stock - 2
    WHERE id_producto = 3 AND stock >= 2;

    SET filas = ROW_COUNT();

    IF filas = 0 THEN
        ROLLBACK;
    ELSE
        INSERT INTO detalle_ventas VALUES (NULL,@id_venta,3,2,25.00,50.00);
        COMMIT;
    END IF;
END//

DELIMITER ;
