--1 crear_tablas.sql
CREATE TABLE Clientes (
    id INT PRIMARY KEY,
    nombre VARCHAR(255),
    direccion VARCHAR(255),
    email VARCHAR(255)
);

CREATE TABLE Productos (
    id INT PRIMARY KEY,
    nombre VARCHAR(255),
    descripcion VARCHAR(255),
    precio DECIMAL(10, 2)
);

CREATE TABLE Ordenes (
    id INT PRIMARY KEY,
    cliente_id INT,
    producto_id INT,
    fecha DATETIME,
    total DECIMAL(10, 2),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id),
    FOREIGN KEY (producto_id) REFERENCES Productos(id)
);

CREATE TABLE Opiniones (
    id INT PRIMARY KEY,
    producto_id INT,
    cliente_id INT,
    opinion TEXT,
    FOREIGN KEY (producto_id) REFERENCES Productos(id),
    FOREIGN KEY (cliente_id) REFERENCES Clientes(id)
);
--2 insertar_datos.sql
-- Inserta datos en las tablas Clientes, Productos, Ordenes, y Opiniones
INSERT INTO Clientes VALUES (1, 'Juan Perez', 'Calle 123, Ciudad A', 'juan.perez@example.com');
INSERT INTO Clientes VALUES (2, 'Maria Lopez', 'Av. Principal, Ciudad B', 'maria.lopez@example.com');
INSERT INTO Clientes VALUES (3, 'Carlos Ramirez', 'Calle 456, Ciudad C', 'carlos.ramirez@example.com');

INSERT INTO Productos VALUES (1, 'Camiseta', 'Camiseta de algodon', 19.99);
INSERT INTO Productos VALUES (2, 'Pantalon', 'Pantalon de mezclilla', 39.99);
INSERT INTO Productos VALUES (3, 'Zapatos', 'Zapatos de cuero', 59.99);

INSERT INTO Ordenes VALUES (1, 1, 2, '2023-06-01 09:00:00', 39.99);
INSERT INTO Ordenes VALUES (2, 2, 1, '2023-06-02 15:30:00', 19.99);
INSERT INTO Ordenes VALUES (3, 3, 3, '2023-06-03 11:45:00', 59.99);

INSERT INTO Opiniones VALUES (1, 1, 2, 'Me encanta esta camiseta');
INSERT INTO Opiniones VALUES (2, 2, 1, 'Los pantalones son geniales');
INSERT INTO Opiniones VALUES (3, 3, 3, 'Los zapatos son muy comodos');

--3 obtener_ordenes.sql
SELECT c.nombre AS nombre_cliente, p.nombre AS nombre_producto, o.fecha
FROM Ordenes o
JOIN Clientes c ON o.cliente_id = c.id
JOIN Productos p ON o.producto_id = p.id
ORDER BY o.fecha ASC;

--4 total_ventas_por_cliente.sql
SELECT c.nombre AS nombre_cliente, SUM(o.total) AS total_ventas
FROM Ordenes o
JOIN Clientes c ON o.cliente_id = c.id
GROUP BY c.id
ORDER BY total_ventas ASC;

--5 cantidad_opiniones_por_cliente.sql
SELECT c.nombre AS nombre_cliente, COUNT(o.id) AS cantidad_opiniones
FROM Opiniones o
JOIN Clientes c ON o.cliente_id = c.id
GROUP BY c.id
ORDER BY nombre_cliente ASC;

-- 6 opiniones_por_producto.sql
SELECT p.nombre AS nombre_producto, COUNT(o.id) AS numero_opiniones
FROM Opiniones o
JOIN Productos p ON o.producto_id = p.id
GROUP BY p.id
ORDER BY numero_opiniones ASC, nombre_producto ASC;
