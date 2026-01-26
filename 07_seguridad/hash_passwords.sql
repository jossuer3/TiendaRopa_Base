-- =========================================
-- HASH DE CONTRASEÑAS (SEGURIDAD)
-- =========================================

-- Ejemplo: inserción de usuario con contraseña hasheada
INSERT INTO usuarios (nombre, email, password_hash, rol)
VALUES (
    'Admin Seguro',
    'admin_seguro@tienda.com',
    SHA2('Admin123', 256),
    'admin'
);

-- Ejemplo vendedor
INSERT INTO usuarios (nombre, email, password_hash, rol)
VALUES (
    'Vendedor Seguro',
    'vendedor_seguro@tienda.com',
    SHA2('Vende123', 256),
    'vendedor'
);

-- =========================================
-- VERIFICACIÓN DEL HASH
-- =========================================
SELECT id_usuario, nombre, email, password_hash
FROM usuarios;
