CREATE DATABASE tienda_ropa;
USE tienda_ropa;
create table usuarios (
    id_usuario int auto_increment primary key,
    nombre varchar(100) not null,
    email varchar(100) not null unique,
    password_hash varchar(255) not null,
    rol enum('admin','vendedor') not null,
    fecha_creacion timestamp default current_timestamp
);

create table clientes (
    id_cliente int auto_increment primary key,
    cedula varchar(10) not null unique,
    nombre varchar(100) not null,
    telefono varchar(15),
    email varchar(100),
    direccion varchar(150),
    fecha_registro date not null
);

create table categorias (
    id_categoria int auto_increment primary key,
    nombre varchar(50) not null unique,
    descripcion varchar(150)
);

create table productos (
    id_producto int auto_increment primary key,
    nombre varchar(100) not null,
    descripcion varchar(150),
    precio decimal(10,2) not null check (precio > 0),
    stock int not null check (stock >= 0),
    talla enum('xs','s','m','l','xl') not null,
    id_categoria int not null,
    foreign key (id_categoria) references categorias(id_categoria)
);

create table ventas (
    id_venta int auto_increment primary key,
    fecha_venta datetime not null,
    total decimal(10,2) not null,
    id_cliente int not null,
    id_usuario int not null,
    foreign key (id_cliente) references clientes(id_cliente),
    foreign key (id_usuario) references usuarios(id_usuario)
);

create table detalle_ventas (
    id_detalle int auto_increment primary key,
    id_venta int not null,
    id_producto int not null,
    cantidad int not null check (cantidad > 0),
    precio_unitario decimal(10,2) not null,
    subtotal decimal(10,2) not null,
    foreign key (id_venta) references ventas(id_venta),
    foreign key (id_producto) references productos(id_producto)
);

-- Inserta datos de prueba para validar el modelo.
insert into usuarios(nombre,email,password_hash,rol) values ('Juan','admin@tienda.com','123456','admin'),('Pepe','pepe@cliente.com','123456','vendedor'),('Lolita','lola@tienda.com','654321','admin'),('Ana','ana@tienda.com','abc123','admin'),
('Luis','luis@tienda.com','pass789','vendedor'),
('Maria','maria@cliente.com','maria456','vendedor'),
('Jose','jose@tienda.com','jose321','admin'),
('Sofia','sofia@tienda.com','sofia999','vendedor');
insert into clientes(cedula,nombre,telefono,email,direccion,fecha_registro) values('2100000000','Carlos Peralta','0999999999','carlos@gmail.com','Nueva Loja','2025-12-01'),('1712000000','Pablo Arturo','0999999999','pablito@gmail.com','Real Audiencia','2026-02-12'), ('1030000000','Martina Popus','0987654321','popusm@gmail.com','Los cedros','2025-11-30'),('1100000001','Andrea Molina','0981111111','andrea@gmail.com','Centro','2025-10-10'),
('1100000002','Luis Torres','0982222222','luis@gmail.com','San Pedro','2025-10-12'),
('1100000003','Martha Ruiz','0983333333','martha@gmail.com','El Dorado','2025-11-01'),
('1100000004','Kevin Lopez','0984444444','kevin@gmail.com','La Pradera','2026-01-05'),
('1100000005','Diana Salas','0985555555','diana@gmail.com','El Valle','2026-02-01');
insert into categorias(nombre,descripcion) values('Ropa Hombre','Camiseta de hombre talla L'),('Ropa Mujer','Pantalon de mujer talla 12'),('Ropa Niña','Disfraz mickey mouse'),('Calzado Hombre','Zapatos casuales para hombre'),
('Calzado Mujer','Tacones y sandalias'),
('Accesorios','Cinturones y carteras'),
('Ropa Deportiva','Prendas deportivas'),
('Ropa Infantil','Ropa para niños');
insert into productos(nombre,descripcion,precio,stock,talla,id_categoria) values('Camisa Formal', 'Camisa para ocasiones formales', 35.00, 50, 'M', 1),('Vestido de gala', 'Vestido listo para un evento de negocios', 45.90, 15, 'L', 2),('Terno de baño','Prenda de vestir para quienes practican actividades acuáticas',25.16,40,'M',7),('Zapato Casual','Zapato cómodo para uso diario',55.00,30,'xs',5),
('Tacón Elegante','Tacón alto para eventos',60.50,20,'XL',5),
('Cinturón Cuero','Cinturón de cuero genuino',18.75,100,'M',6),
('Conjunto Deportivo','Ropa para entrenar',35.90,25,'M',7),
('Chaqueta Infantil','Chaqueta para clima frío',28.40,40,'S',8);
insert into ventas (fecha_venta, total, id_cliente, id_usuario) VALUES ('2025-01-15 10:30:00', 80.00, 1, 2),(NOW(), 45.00, 2, 2),('2025-12-01 09:46:00',66.08,3,3),('2025-11-15 11:20:00', 55.00, 4, 4),
('2025-11-20 16:45:00', 121.00, 5, 5),
('2026-01-10 09:10:00', 18.75, 6, 6),
('2026-01-22 14:30:00', 71.80, 7, 7),
(NOW(), 28.40, 8, 8);
insert into detalle_ventas(id_venta, id_producto, cantidad, precio_unitario, subtotal) values(8, 8, 3, 28.40, 85.20),(2, 2, 4, 45.90, 183.6),(3, 3, 3, 25.16,75.48),
(1, 1, 1, 35.00, 35.00),
(2, 2, 2, 45.90, 91.80),
(3, 3, 1, 25.16, 25.16),
(4, 4, 1, 55.00, 55.00),
(5, 6, 3, 18.75, 56.25);


SELECT * FROM usuarios;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;
SELECT * FROM detalle_ventas;
select * from categorias;

-- 4. Consultas y operaciones
-- Diseña al menos 10 consultas SQL que respondan a necesidades del sistema:
-- simple
SELECT nombre, email FROM usuarios;
SELECT nombre, descripcion FROM categorias;
-- condición
SELECT * FROM productos WHERE stock > 20;
select * from clientes where nombre like '%A%';
-- Join
-- 1.total ventas cliente
Select v.id_venta, c.nombre, v.total
From ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente;
-- 2.ventas vendedor
Select v.id_venta, u.nombre AS vendedor, v.fecha_venta
FROM ventas v
JOIN usuarios u ON v.id_usuario = u.id_usuario;
-- 3. Cliente, fecha y total
SELECT c.nombre, v.fecha_venta, v.total
FROM clientes c
JOIN ventas v ON c.id_cliente = v.id_cliente;
-- 4.por categoria
Select p.nombre, c.nombre AS categoria
From productos p 
JOIN categorias c ON p.id_categoria = c.id_categoria;
-- 5.ventas por ID vendedor
Select v.id_venta, c.nombre AS cliente
From ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
Where v.id_usuario = 2;
-- 6. Multiplicacion con JOIN
Select dv.cantidad, p.nombre,precio_unitario* cantidad AS SUBTOTAL
From detalle_ventas dv
JOIN productos p ON dv.id_producto = p.id_producto;

-- Funciones de agregación (SUM, COUNT, AVG)
Select c.nombre, sum(v.total) AS total_compras
From ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
group by c.nombre;

Select nombre, count(*) AS total_productos 
From productos
group by nombre;

select nombre, avg(precio) AS promedio_precios
from productos
group by nombre;

-- Función de cadena
SELECT UPPER(nombre) AS nombre_mayuscula FROM clientes;
SELECT LOWER(u.email) AS correo,
       SUM(v.total) AS total_vendido
FROM usuarios u
JOIN ventas v ON u.id_usuario = v.id_usuario
GROUP BY u.email;

Select concat('Producto: ', p.nombre) AS Informacion,
sum(dv.cantidad) AS total_productos
FROM productos p
JOIN detalle_ventas dv ON p.id_producto = dv.id_producto
Group by p.nombre;

-- Subconsulta y vista
SELECT nombre, precio
FROM productos
WHERE precio > (SELECT AVG(precio) FROM productos);

CREATE VIEW v_factura AS
SELECT 
v.id_venta,
c.nombre AS cliente,
u.nombre AS vendedor,
v.total
FROM ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
JOIN usuarios u ON v.id_usuario = u.id_usuario;

select * from v_factura;

-- Incluye ejemplos de actualización, eliminación e inserción de datos.
INSERT INTO categorias(nombre, descripcion)
VALUES ('Sapatos', 'Calzado para todas las edades');
select * from categorias;
UPDATE categorias
set nombre = 'Zapatos'
WHERE nombre LIKE 'Sapatos';
Delete From categorias 
where nombre = 'Zapatos';

