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
