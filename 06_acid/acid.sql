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
-- Cambiamos el delimitador para poder crear el procedimiento
DELIMITER //

-- Procedimiento almacenado para registrar una venta completa
CREATE PROCEDURE registrar_venta()
BEGIN
    -- Variable que almacenará cuántas filas fueron afectadas
    -- Se usa para verificar si hubo stock suficiente
    DECLARE filas INT;

    -- Define el nivel de aislamiento de la transacción
    -- Evita leer datos no confirmados de otras transacciones (Aislamiento - ACID)
    SET TRANSACTION ISOLATION LEVEL READ COMMITTED;

    -- Inicia la transacción
    -- Todas las operaciones se ejecutan como una sola unidad (Atomicidad - ACID)
    START TRANSACTION;

    -- Inserta el registro de la venta
    -- NULL permite que el id de la venta sea autoincremental
    INSERT INTO ventas (fecha_venta, total, id_cliente, id_usuario)
    VALUES (NOW(), 50.00, 1, 2);


    -- Obtiene el ID generado de la venta recién insertada
    -- Se usará para relacionar el detalle de la venta
    SET @id_venta = LAST_INSERT_ID();

    -- Actualiza el stock del producto
    -- Solo descuenta si existe stock suficiente (Consistencia - ACID)
    UPDATE productos
    SET stock = stock - 2
    WHERE id_producto = 3 AND stock >= 2;

    -- Guarda el número de filas afectadas por el UPDATE
    -- Si es 0, significa que no había stock suficiente
    SET filas = ROW_COUNT();

    -- Verifica si la actualización del stock fue exitosa
    IF filas = 0 THEN
        -- Si no hubo stock suficiente, se deshacen todos los cambios
        -- Garantiza que no existan operaciones incompletas (Atomicidad)
        ROLLBACK;
    ELSE
        -- Inserta el detalle de la venta
        -- Relaciona la venta con el producto vendido
          INSERT INTO detalle_ventas (id_venta, id_producto, cantidad, precio_unitario, subtotal)
           VALUES (@id_venta, 3, 2, 25.00, 50.00);

        -- Confirma definitivamente la transacción
        -- Los datos quedan guardados aun si ocurre un fallo (Durabilidad - ACID)
        
        COMMIT;
    END IF;
END//

-- Se restaura el delimitador original
DELIMITER ;

SELECT id_producto, nombre, stock FROM productos WHERE id_producto = 3;
SELECT * FROM ventas;
SELECT * FROM detalle_ventas;

UPDATE productos SET stock = 8 WHERE id_producto = 3;

CALL registrar_venta();
