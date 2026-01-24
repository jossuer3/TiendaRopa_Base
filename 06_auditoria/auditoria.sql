-- ========================
-- Auditoria
-- ========================

CREATE TABLE auditoria (
    id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    tabla_afectada VARCHAR(100) NOT NULL,
    operacion ENUM('INSERT','UPDATE','DELETE') NOT NULL,
    fecha_operacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_bd VARCHAR(100) NOT NULL
);

-- ========================
-- TRIGGERS DE AUDITORIA
-- ========================

CREATE TRIGGER trg_auditoria_insert_productos
AFTER INSERT ON productos
FOR EACH ROW
INSERT INTO auditoria (tabla_afectada, operacion, usuario_bd)
VALUES ('productos', 'INSERT', CURRENT_USER());

CREATE TRIGGER trg_auditoria_update_productos
AFTER UPDATE ON productos
FOR EACH ROW
INSERT INTO auditoria (tabla_afectada, operacion, usuario_bd)
VALUES ('productos', 'UPDATE', CURRENT_USER());

CREATE TRIGGER trg_auditoria_delete_productos
AFTER DELETE ON productos
FOR EACH ROW
INSERT INTO auditoria (tabla_afectada, operacion, usuario_bd)
VALUES ('productos', 'DELETE', CURRENT_USER());

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
