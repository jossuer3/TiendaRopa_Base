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
-- usuarios
insert into usuarios(nombre,email,password_hash,rol) values ('Juan','admin@tienda.com','123456','admin'),('Pepe','pepe@cliente.com','123456','vendedor'),('Lolita','lola@tienda.com','654321','admin');
insert into clientes(cedula,nombre,telefono,email,direccion,fecha_registro) values('2100000000','Carlos Peralta','0999999999','carlos@gmail.com','Nueva Loja','2025-12-01'),('1712000000','Pablo Arturo','0999999999','pablito@gmail.com','Real Audiencia','2026-02-12'), ('1030000000','Martina Popus','0987654321','popusm@gmail.com','Los cedros','2025-11-30');
insert into categorias(nombre,descripcion) values('Ropa Hombre','Camiseta de hombre talla L'),('Ropa Mujer','Pantalon de mujer talla 12'),('Ropa Niña','Disfraz mickey mouse');
insert into productos(nombre,descripcion,precio,stock,talla,id_categoria) values('Camisa Formal', 'Camisa para ocasiones formales', 35.00, 50, 'M', 1),('Vestido de gala', 'Vestido listo para un evento de negocios', 45.90, 15, 'L', 2),('Terno de baño','Prenda de vestir para quienes practican actividades acuáticas',25.16,40,'M',3);
insert into ventas (fecha_venta, total, id_cliente, id_usuario) VALUES ('2025-01-15 10:30:00', 80.00, 1, 2),(NOW(), 45.00, 2, 2),('2025-12-01 09:46:00',66.08,3,3);
insert into detalle_ventas(id_venta, id_producto, cantidad, precio_unitario, subtotal) values(1, 1, 1, 12.50, 12.50),(2, 2, 4, 45.90, 183.6),(3, 3, 3, 25.16,75.48);

SELECT * FROM usuarios;
SELECT * FROM clientes;
SELECT * FROM productos;
SELECT * FROM ventas;
SELECT * FROM detalle_ventas;

-- 4. Consultas y operaciones
-- Diseña al menos 10 consultas SQL que respondan a necesidades del sistema:
-- simple
SELECT nombre, email FROM usuarios;
-- condición
SELECT * FROM productos WHERE stock > 20;
-- Join
-- 1.total ventas cliente
Select v.id_venta, c.nombre, v.total
From ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente;
-- 2.ventas vendedor
Select v.id_venta, u.nombre AS vendedor, v.fecha_venta
FROM ventas v
JOIN usuarios u ON v.id_usuario = u.id_usuario;
-- 3.total de compras por cliente
Select c.nombre, sum(v.total) AS total_compras
From ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
group by c.nombre;
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

Select nombre, count(*) AS total_productos 
From productos
group by nombre;

select nombre, avg(precio) AS promedio_precios
from productos
group by nombre;

-- Función de cadena
SELECT UPPER(nombre) AS nombre_mayuscula FROM clientes;
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

