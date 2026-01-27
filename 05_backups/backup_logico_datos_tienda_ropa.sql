-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: localhost    Database: tienda_ropa
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Dumping data for table `auditoria`
--

LOCK TABLES `auditoria` WRITE;
/*!40000 ALTER TABLE `auditoria` DISABLE KEYS */;
/*!40000 ALTER TABLE `auditoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Ropa Hombre','Camiseta de hombre talla L'),(2,'Ropa Mujer','Pantalon de mujer talla 12'),(3,'Ropa Niña','Disfraz mickey mouse'),(4,'Calzado Hombre','Zapatos casuales para hombre'),(5,'Calzado Mujer','Tacones y sandalias'),(6,'Accesorios','Cinturones y carteras'),(7,'Ropa Deportiva','Prendas deportivas'),(8,'Ropa Infantil','Ropa para niños');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `clientes`
--

LOCK TABLES `clientes` WRITE;
/*!40000 ALTER TABLE `clientes` DISABLE KEYS */;
INSERT INTO `clientes` VALUES (1,'2100000000','Carlos Peralta','0999999999','carlos@gmail.com','Nueva Loja','2025-12-01'),(2,'1712000000','Pablo Arturo','0999999999','pablito@gmail.com','Real Audiencia','2026-02-12'),(3,'1030000000','Martina Popus','0987654321','popusm@gmail.com','Los cedros','2025-11-30'),(4,'1100000001','Andrea Molina','0981111111','andrea@gmail.com','Centro','2025-10-10'),(5,'1100000002','Luis Torres','0982222222','luis@gmail.com','San Pedro','2025-10-12'),(6,'1100000003','Martha Ruiz','0983333333','martha@gmail.com','El Dorado','2025-11-01'),(7,'1100000004','Kevin Lopez','0984444444','kevin@gmail.com','La Pradera','2026-01-05'),(8,'1100000005','Diana Salas','0985555555','diana@gmail.com','El Valle','2026-02-01');
/*!40000 ALTER TABLE `clientes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `detalle_ventas`
--

LOCK TABLES `detalle_ventas` WRITE;
/*!40000 ALTER TABLE `detalle_ventas` DISABLE KEYS */;
INSERT INTO `detalle_ventas` VALUES (1,8,8,3,28.40,85.20),(2,2,2,4,45.90,183.60),(3,3,3,3,25.16,75.48),(4,1,1,1,35.00,35.00),(5,2,2,2,45.90,91.80),(6,3,3,1,25.16,25.16),(7,4,4,1,55.00,55.00),(8,5,6,3,18.75,56.25);
/*!40000 ALTER TABLE `detalle_ventas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `productos`
--

LOCK TABLES `productos` WRITE;
/*!40000 ALTER TABLE `productos` DISABLE KEYS */;
INSERT INTO `productos` VALUES (1,'Camisa Formal','Camisa para ocasiones formales',35.00,50,'m',1),(2,'Vestido de gala','Vestido listo para un evento de negocios',45.90,15,'l',2),(3,'Terno de baño','Prenda de vestir para quienes practican actividades acuáticas',25.16,40,'m',7),(4,'Zapato Casual','Zapato cómodo para uso diario',55.00,30,'xs',5),(5,'Tacón Elegante','Tacón alto para eventos',60.50,20,'xl',5),(6,'Cinturón Cuero','Cinturón de cuero genuino',18.75,100,'m',6),(7,'Conjunto Deportivo','Ropa para entrenar',35.90,25,'m',7),(8,'Chaqueta Infantil','Chaqueta para clima frío',28.40,40,'s',8);
/*!40000 ALTER TABLE `productos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Juan','admin@tienda.com','123456','admin','2026-01-27 00:42:37'),(2,'Pepe','pepe@cliente.com','123456','vendedor','2026-01-27 00:42:37'),(3,'Lolita','lola@tienda.com','654321','admin','2026-01-27 00:42:37'),(4,'Ana','ana@tienda.com','abc123','admin','2026-01-27 00:42:37'),(5,'Luis','luis@tienda.com','pass789','vendedor','2026-01-27 00:42:37'),(6,'Maria','maria@cliente.com','maria456','vendedor','2026-01-27 00:42:37'),(7,'Jose','jose@tienda.com','jose321','admin','2026-01-27 00:42:37'),(8,'Sofia','sofia@tienda.com','sofia999','vendedor','2026-01-27 00:42:37'),(9,'Admin Seguro','admin_seguro@tienda.com','3b612c75a7b5048a435fb6ec81e52ff92d6d795a8b5a9c17070f6a63c97a53b2','admin','2026-01-27 00:42:37'),(10,'Vendedor Seguro','vendedor_seguro@tienda.com','071cd980e4f7cbca334d1c36d34e65ce0825b8d522fc13b9519567eb799b1444','vendedor','2026-01-27 00:42:37');
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping data for table `ventas`
--

LOCK TABLES `ventas` WRITE;
/*!40000 ALTER TABLE `ventas` DISABLE KEYS */;
INSERT INTO `ventas` VALUES (1,'2025-01-15 10:30:00',80.00,1,2),(2,'2026-01-26 19:42:37',45.00,2,2),(3,'2025-12-01 09:46:00',66.08,3,3),(4,'2025-11-15 11:20:00',55.00,4,4),(5,'2025-11-20 16:45:00',121.00,5,5),(6,'2026-01-10 09:10:00',18.75,6,6),(7,'2026-01-22 14:30:00',71.80,7,7),(8,'2026-01-26 19:42:37',28.40,8,8);
/*!40000 ALTER TABLE `ventas` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-01-26 19:56:11
