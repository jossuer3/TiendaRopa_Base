
-- ==============================
-- CREACIÓN DE ROLES
-- ===============================
CREATE ROLE 'rol_admin';
CREATE ROLE 'rol_vendedor';

-- ===============================
-- ASIGNACIÓN DE PERMISOS
-- ===============================

-- Rol ADMIN: control total del sistema
GRANT ALL PRIVILEGES ON tienda_ropa.* TO 'rol_admin'; 

-- Rol VENDEDOR: operaciones del día a día
GRANT SELECT, INSERT, UPDATE ON tienda_ropa.* TO 'rol_vendedor';  

-- El vendedor NO puede borrar ni modificar estructura
REVOKE DELETE, DROP, ALTER ON tienda_ropa.* FROM 'rol_vendedor';  

-- ===============================
-- CREACIÓN DE USUARIOS BD
-- ===============================
CREATE USER 'admin_db'@'localhost' IDENTIFIED BY 'Admin123';
CREATE USER 'vendedor_db'@'localhost' IDENTIFIED BY 'Vende123';

-- ===============================
-- ASIGNACIÓN DE ROLES A USUARIOS
-- ===============================
GRANT 'rol_admin' TO 'admin_db'@'localhost';
GRANT 'rol_vendedor' TO 'vendedor_db'@'localhost';

-- ===============================
-- ACTIVAR ROLES POR DEFECTO
-- ===============================
SET DEFAULT ROLE ALL TO
'admin_db'@'localhost',
'vendedor_db'@'localhost';

-- =========================================
-- PREVENCIÓN DE SQL INJECTION
-- USO DE PROCEDIMIENTOS ALMACENADOS
-- =========================================

DELIMITER //

CREATE PROCEDURE buscar_cliente_seguro (
    IN p_cedula VARCHAR(10)
)
BEGIN
    SELECT id_cliente, nombre, email, direccion
    FROM clientes
    WHERE cedula = p_cedula;
END//

DELIMITER ;
