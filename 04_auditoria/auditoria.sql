-- =========================================
-- AUDITORIA
-- =========================================

CREATE TABLE auditoria (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    tabla_afectada VARCHAR(100),
    operacion ENUM('INSERT','UPDATE','DELETE'),
    fecha_operacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_bd VARCHAR(100)
);

DELIMITER //

CREATE TRIGGER trg_insert_productos
AFTER INSERT ON productos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria VALUES (NULL,'productos','INSERT',CURRENT_TIMESTAMP,CURRENT_USER());
END//

CREATE TRIGGER trg_update_productos
AFTER UPDATE ON productos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria VALUES (NULL,'productos','UPDATE',CURRENT_TIMESTAMP,CURRENT_USER());
END//

CREATE TRIGGER trg_delete_productos
AFTER DELETE ON productos
FOR EACH ROW
BEGIN
    INSERT INTO auditoria VALUES (NULL,'productos','DELETE',CURRENT_TIMESTAMP,CURRENT_USER());
END//

-- ========================
-- CONSULTA DE AUDITORIA
-- ========================
SELECT 
    id_auditoria,
    tabla_afectada,
    operacion,
    fecha_operacion,
    usuario_bd
FROM auditoria;
