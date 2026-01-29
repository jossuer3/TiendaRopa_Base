# Proyecto Final – Base de Datos Distribuidas (BDD)

## Institución

**Escuela Politécnica Nacional (EPN)**
Quito – Ecuador

## Integrantes

* santiago vargas
* kyara altamirano
* josue patiño

---

## Descripción General del Proyecto

Este proyecto corresponde al **Proyecto Final de la asignatura Base de Datos Distribuidas (BDD)** y consiste en el diseño, implementación y administración de una **base de datos relacional para la gestión de una tienda de ropa**.

El modelo propuesto permite representar de forma adecuada las **relaciones uno a muchos y muchos a muchos** presentes en el sistema, asegurando integridad, escalabilidad y seguridad de la información.

---

## Estructura del Proyecto

```
TiendaRopa-db/
│── 01_Documentacion/
│── 02_Tablas/
│── 03_datos_prueba/
│── 04_auditoria/
│── 05_backups/
│── 06_acid/
│── 07_seguridad/
│── 08_rendimiento/
│── Proyecto_Bases.sql
│── README.md
```

Cada carpeta contiene los scripts SQL necesarios para demostrar los distintos aspectos del proyecto: modelado, seguridad, auditoría, backups, ACID y rendimiento.

---

## Definición de Entidades, Atributos y Relaciones

### Usuarios

* Representan a las personas que utilizan el sistema para gestionar la tienda.
* Almacenan información de identificación, credenciales de acceso y rol.
* Permiten controlar permisos y registrar qué usuario realiza cada venta.
* Un usuario puede registrar múltiples ventas.

### Clientes

* Almacenan información personal y de contacto.
* Permiten asociar cada venta a un cliente específico.
* Facilitan el historial de compras y la gestión de clientes frecuentes.
* Un cliente puede realizar varias ventas.

### Categorías

* Clasifican los productos disponibles en la tienda.
* Evitan la repetición del nombre de la categoría en cada producto.
* Permiten una organización clara del inventario.
* Una categoría puede agrupar varios productos.

### Productos

* Almacenan información de las prendas comercializadas.
* Incluyen precio, stock, talla y categoría.
* Permiten validar disponibilidad antes de registrar una venta.
* Un producto puede aparecer en múltiples ventas.

### Ventas

* Registran cada transacción realizada en la tienda.
* Contienen información del cliente, usuario y total de la venta.
* Actúan como el encabezado de la transacción.
* Una venta puede incluir varios productos.

### Detalle_Ventas

* Registran los productos vendidos en cada venta.
* Almacenan cantidad, precio unitario y subtotal.
* Manejan la relación entre ventas y productos.
* Conservan el histórico de precios al momento de la venta.

---

## Normalización hasta la Tercera Forma Normal (3FN)

### Primera Forma Normal (1FN)

* Todas las tablas tienen claves primarias.
* Los atributos contienen valores atómicos.
* No existen campos multivaluados ni repetidos.

### Segunda Forma Normal (2FN)

* Todos los atributos dependen completamente de la clave primaria.
* La información de los productos vendidos se separa en la tabla `detalle_ventas`.

### Tercera Forma Normal (3FN)

* No existen dependencias transitivas.
* La información de clientes, usuarios y categorías se almacena en tablas independientes.
* Cada atributo depende únicamente de la clave primaria.

---

## Justificación del Diseño

* La separación entre `ventas` y `detalle_ventas` permite registrar múltiples productos por venta.
* La tabla `categorías` evita redundancia de información en productos.
* La tabla `usuarios` permite control de accesos y trazabilidad de ventas.
* El diseño mejora la integridad, organización y escalabilidad del sistema.

---

## Aplicación de ACID en el Proyecto

### Atomicidad

* Cada venta se maneja como una única transacción lógica.
* Incluye registro de la venta, detalle de productos y actualización de stock.
* Si ocurre un error, la transacción se revierte completamente.

### Consistencia

* Uso de claves foráneas y restricciones.
* Evita ventas sin cliente o sin usuario responsable.
* Impide valores inválidos como precios negativos o cantidades incorrectas.

### Aislamiento

* Permite múltiples ventas simultáneas sin interferencia.
* Evita conflictos como descuentos dobles de stock.
* Cada transacción se ejecuta como si fuera única.

### Durabilidad

* Una vez confirmada la venta, los datos se almacenan permanentemente.
* La información se conserva ante fallos o apagones del sistema.

---

## Implementación en el SGBD

* Se utilizó MySQL Workbench para la implementación.
* Se crearon seis tablas principales con claves foráneas y restricciones.
* Se insertaron datos de prueba, ocho registros por sección.

---

## Consultas SQL

* Se diseñaron al menos diez consultas.
* Consultas simples y con condiciones.
* Se implementaron seis consultas JOIN entre múltiples tablas.

---

## Funciones Implementadas

* Función SUM para calcular el total de compras por cliente.
* Función COUNT para obtener la cantidad de productos disponibles.
* Función AVG para calcular el precio promedio de los productos.

---

## Seguridad, Administración y Auditoría

### Administración y Seguridad

* Creación de usuarios del sistema.
* Asignación de roles y permisos.
* Control de accesos según responsabilidades.

### Seguridad del Sistema

* Prevención de inyección SQL mediante consultas controladas.
* Cifrado de contraseñas usando funciones hash.
* Protección de la confidencialidad e integridad de los datos.

---

## Backups y Recuperación de la Información

### Backup Completo

* Copia total de la base de datos, incluyendo estructura y datos.
* Permite la restauración ante fallos graves.

### Backup Lógico o Incremental

* Respaldo mediante archivos SQL con sentencias de reconstrucción.
* Más ligero y adecuado para copias periódicas.

### Recuperación de la Información

* Restauración de la base de datos ante pérdida o errores.
* Garantiza la continuidad del sistema y la disponibilidad de la información.

---

## Pruebas del Sistema

### Pruebas de Carga

* Simulan múltiples usuarios realizando operaciones simultáneamente.
* Evalúan la estabilidad y el rendimiento del sistema.

### Pruebas de Estrés

* Somete al sistema a condiciones extremas.
* Permite identificar límites y posibles fallos.

---

## Auditoría del Sistema

* Implementación de triggers de auditoría.
* Registro de inserciones, actualizaciones y eliminaciones.
* Almacenamiento de la tabla afectada, tipo de operación y fecha.
* Facilita la trazabilidad y detección de modificaciones no autorizadas.
---

link video :https://youtu.be/w-Ts--KjgHw?si=xX9DH3p7JzRvcwPe

---

## Conclusión

El proyecto integra de manera correcta los principios de modelado relacional, normalización, ACID, seguridad, auditoría y respaldo, ofreciendo una solución robusta y confiable para la gestión de una tienda de ropa, alineada con las buenas prácticas de bases de datos.
