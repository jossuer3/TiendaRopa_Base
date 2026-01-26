-- 8.RENDIMIENTO
-- Consultas optimizadas
-- Agregaré en el ANTES las consultas de la sección de datos_consulta para mostrar el cambio al optimizar
-- ANTES
-- 1.total ventas cliente
Select v.id_venta, c.nombre, v.total
From ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente;

-- OPTIMIZADA
SELECT c.nombre, v.total
FROM ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
WHERE v.total > 50;

-- 2. FUncion de agregación ANTES
Select c.nombre, sum(v.total) AS total_compras
From ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
group by c.nombre;
-- DSPUES YA OPTIMIZADA
select c.nombre, sum(v.total) AS total_compras
From ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
group by c.id_cliente, c.nombre;

-- 3.Por categoria ANTES
Select p.nombre, c.nombre AS categoria
From productos p 
JOIN categorias c ON p.id_categoria = c.id_categoria;
-- DESPUES
SElect p.nombre, c.nombre AS categoria
FROM productos p
JOIN categorias c ON p.id_categoria= c.id_categoria
Where p.precio > 30;


-- Uso de índices
-- Busqueda y joins en ventas
CREATE INDEX idx_ventas_cliente ON ventas(id_cliente);
CREATE INDEX idx_ventas_usuario ON ventas(id_usuario);
-- Para detalle de ventas
CREATE INDEX idx_detalle_producto ON detalle_ventas(id_producto);
-- Para productos
CREATE INDEX idx_productos_categoria ON productos(id_categoria);

-- EXPLAIN
-- Optimizacion 1.
EXPLAIN
SELECT c.nombre, v.total
FROM ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
WHERE v.total > 50;
-- Optimizacion 2
EXPLAIN
Select c.nombre, sum(v.total) AS total_compras
From ventas v
JOIN clientes c ON v.id_cliente = c.id_cliente
Group by c.id_cliente, c.nombre;
-- Optimizacion 3
EXPLAIN
SELECT p.nombre, c.nombre AS categoria
FROM productos p
JOIN categorias c ON p.id_categoria = c.id_categoria
WHERE p.precio > 30;

