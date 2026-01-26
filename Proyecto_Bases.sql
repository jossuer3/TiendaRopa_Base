-- =========================================
-- BASE DE DATOS TIENDA DE ROPA
-- SCRIPT COMPLETO Y FINAL
-- =========================================

DROP DATABASE IF EXISTS tienda_ropa;
CREATE DATABASE tienda_ropa;
USE tienda_ropa;

-- =========================================
-- TABLAS PRINCIPALES
-- =========================================

CREATE TABLE usuarios (
    id_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    rol ENUM('admin','vendedor') NOT NULL,
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    cedula VARCHAR(10) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    telefono VARCHAR(15),
    email VARCHAR(100),
    direccion VARCHAR(150),
    fecha_registro DATE NOT NULL
);

CREATE TABLE categorias (
    id_categoria INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(150)
);

CREATE TABLE productos (
    id_producto INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    descripcion VARCHAR(150),
    precio DECIMAL(10,2) NOT NULL CHECK (precio > 0),
    stock INT NOT NULL CHECK (stock >= 0),
    talla ENUM('xs','s','m','l','xl') NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_categoria) REFERENCES categorias(id_categoria)
);

CREATE TABLE ventas (
    id_venta INT AUTO_INCREMENT PRIMARY KEY,
    fecha_venta DATETIME NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    id_cliente INT NOT NULL,
    id_usuario INT NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario)
);

CREATE TABLE detalle_ventas (
    id_detalle INT AUTO_INCREMENT PRIMARY KEY,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    FOREIGN KEY (id_venta) REFERENCES ventas(id_venta),
    FOREIGN KEY (id_producto) REFERENCES productos(id_producto)
);

-- =========================================
-- DATOS DE PRUEBA
-- =========================================

insert into usuarios(nombre,email,password_hash,rol) values 
('Juan','admin@tienda.com','123456','admin'),
('Pepe','pepe@cliente.com','123456','vendedor'),
('Lolita','lola@tienda.com','654321','admin'),
('Ana','ana@tienda.com','abc123','admin'),
('Luis','luis@tienda.com','pass789','vendedor'),
('Maria','maria@cliente.com','maria456','vendedor'),
('Jose','jose@tienda.com','jose321','admin'),
('Sofia','sofia@tienda.com','sofia999','vendedor');

insert into clientes(cedula,nombre,telefono,email,direccion,fecha_registro) values
('2100000000','Carlos Peralta','0999999999','carlos@gmail.com','Nueva Loja','2025-12-01'),
('1712000000','Pablo Arturo','0999999999','pablito@gmail.com','Real Audiencia','2026-02-12'), 
('1030000000','Martina Popus','0987654321','popusm@gmail.com','Los cedros','2025-11-30'),
('1100000001','Andrea Molina','0981111111','andrea@gmail.com','Centro','2025-10-10'),
('1100000002','Luis Torres','0982222222','luis@gmail.com','San Pedro','2025-10-12'),
('1100000003','Martha Ruiz','0983333333','martha@gmail.com','El Dorado','2025-11-01'),
('1100000004','Kevin Lopez','0984444444','kevin@gmail.com','La Pradera','2026-01-05'),
('1100000005','Diana Salas','0985555555','diana@gmail.com','El Valle','2026-02-01');

insert into categorias(nombre,descripcion) values
('Ropa Hombre','Camiseta de hombre talla L'),
('Ropa Mujer','Pantalon de mujer talla 12'),
('Ropa Niña','Disfraz mickey mouse'),
('Calzado Hombre','Zapatos casuales para hombre'),
('Calzado Mujer','Tacones y sandalias'),
('Accesorios','Cinturones y carteras'),
('Ropa Deportiva','Prendas deportivas'),
('Ropa Infantil','Ropa para niños');

insert into productos(nombre,descripcion,precio,stock,talla,id_categoria) values
('Camisa Formal', 'Camisa para ocasiones formales', 35.00, 50, 'M', 1),
('Vestido de gala', 'Vestido listo para un evento de negocios', 45.90, 15, 'L', 2),
('Terno de baño','Prenda de vestir para quienes practican actividades acuáticas',25.16,40,'M',7),
('Zapato Casual','Zapato cómodo para uso diario',55.00,30,'xs',5),
('Tacón Elegante','Tacón alto para eventos',60.50,20,'XL',5),
('Cinturón Cuero','Cinturón de cuero genuino',18.75,100,'M',6),
('Conjunto Deportivo','Ropa para entrenar',35.90,25,'M',7),
('Chaqueta Infantil','Chaqueta para clima frío',28.40,40,'S',8);

insert into ventas (fecha_venta, total, id_cliente, id_usuario) VALUES 
('2025-01-15 10:30:00', 80.00, 1, 2),
(NOW(), 45.00, 2, 2),('2025-12-01 09:46:00',66.08,3,3),
('2025-11-15 11:20:00', 55.00, 4, 4),
('2025-11-20 16:45:00', 121.00, 5, 5),
('2026-01-10 09:10:00', 18.75, 6, 6),
('2026-01-22 14:30:00', 71.80, 7, 7),
(NOW(), 28.40, 8, 8);

insert into detalle_ventas(id_venta, id_producto, cantidad, precio_unitario, subtotal) values
(8, 8, 3, 28.40, 85.20),
(2, 2, 4, 45.90, 183.6),
(3, 3, 3, 25.16,75.48),
(1, 1, 1, 35.00, 35.00),
(2, 2, 2, 45.90, 91.80),
(3, 3, 1, 25.16, 25.16),
(4, 4, 1, 55.00, 55.00),
(5, 6, 3, 18.75, 56.25);


-- =========================================
-- VISTA
-- =========================================

CREATE VIEW v_factura AS
SELECT v.id_venta, c.nombre AS cliente, u.nombre AS vendedor, v.total
FROM ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
JOIN usuarios u ON v.id_usuario = u.id_usuario;

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

-- =========================================
-- PROCEDIMIENTO (ACID)
-- =========================================

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

-- =========================================
-- SEGURIDAD
-- =========================================

INSERT INTO usuarios VALUES
(NULL,'Admin Seguro','admin_seguro@tienda.com',SHA2('Admin123',256),'admin',NOW()),
(NULL,'Vendedor Seguro','vendedor_seguro@tienda.com',SHA2('Vende123',256),'vendedor',NOW());

CREATE ROLE 'rol_admin';
CREATE ROLE 'rol_vendedor';

GRANT ALL PRIVILEGES ON tienda_ropa.* TO 'rol_admin';
GRANT SELECT,INSERT,UPDATE ON tienda_ropa.* TO 'rol_vendedor';
REVOKE DELETE,DROP,ALTER ON tienda_ropa.* FROM 'rol_vendedor';

CREATE USER 'admin_db'@'localhost' IDENTIFIED BY 'Admin123';
CREATE USER 'vendedor_db'@'localhost' IDENTIFIED BY 'Vende123';

GRANT 'rol_admin' TO 'admin_db'@'localhost';
GRANT 'rol_vendedor' TO 'vendedor_db'@'localhost';

SET DEFAULT ROLE ALL TO 'admin_db'@'localhost','vendedor_db'@'localhost';

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

