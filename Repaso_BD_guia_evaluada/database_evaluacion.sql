-- =========================================
-- CREACIÓN DE BASE DE DATOS
-- =========================================
DROP DATABASE IF EXISTS hotel_reservas;
CREATE DATABASE IF NOT EXISTS hotel_reservas;
USE hotel_reservas;


-- =========================================
-- TABLA TIPO_CLIENTES
-- =========================================
CREATE TABLE tipo_clientes (
    id_tipo_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL UNIQUE,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    deleted BOOLEAN DEFAULT 0
);


-- =========================================
-- TABLA CLIENTES
-- =========================================
CREATE TABLE clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    rut VARCHAR(12),
    nombre_completo VARCHAR(100) NOT NULL,
    correo VARCHAR(100),
    telefono VARCHAR(15),
    id_tipo_cliente INT NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    deleted BOOLEAN DEFAULT 0,
    FOREIGN KEY (id_tipo_cliente) REFERENCES tipo_clientes(id_tipo_cliente)
);


-- =========================================
-- TABLA TIPOS_HABITACION
-- =========================================
CREATE TABLE tipos_habitacion (
    id_tipo_habitacion INT AUTO_INCREMENT PRIMARY KEY,
    nombre_tipo VARCHAR(50) NOT NULL UNIQUE,
    precio_noche DECIMAL(10,2) NOT NULL,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    deleted BOOLEAN DEFAULT 0
);


-- =========================================
-- TABLA HABITACIONES
-- =========================================
CREATE TABLE habitaciones (
    id_habitacion INT AUTO_INCREMENT PRIMARY KEY,
    numero_habitacion VARCHAR(10) NOT NULL UNIQUE,
    id_tipo_habitacion INT NOT NULL,
    estado VARCHAR(20) DEFAULT 'disponible',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    deleted BOOLEAN DEFAULT 0,
    FOREIGN KEY (id_tipo_habitacion) REFERENCES tipos_habitacion(id_tipo_habitacion)
);


-- =========================================
-- TABLA PERSONAL
-- =========================================
CREATE TABLE personal (
    id_personal INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(100),
    cargo VARCHAR(50),
    correo VARCHAR(100),
    telefono VARCHAR(15),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    deleted BOOLEAN DEFAULT 0
);


-- =========================================
-- TABLA RESERVAS
-- =========================================
CREATE TABLE reservas (
    id_reserva INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    id_habitacion INT NOT NULL,
    id_personal INT NOT NULL,
    fecha_ingreso DATE,
    fecha_salida DATE,
    estado VARCHAR(20),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME NULL,
    deleted BOOLEAN DEFAULT 0,
    FOREIGN KEY (id_cliente) REFERENCES clientes(id_cliente),
    FOREIGN KEY (id_habitacion) REFERENCES habitaciones(id_habitacion),
    FOREIGN KEY (id_personal) REFERENCES personal(id_personal)
);


-- =========================================
-- INSERCIÓN DE DATOS
-- =========================================


-- TIPOS DE CLIENTE
INSERT INTO tipo_clientes (nombre_tipo) VALUES
('Regular'),
('VIP'),
('Corporativo');


-- TIPOS DE HABITACIÓN
INSERT INTO tipos_habitacion (nombre_tipo, precio_noche) VALUES
('Single', 35000),
('Doble', 50000),
('Suite', 95000);


-- CLIENTES (con algunos campos nulos)
INSERT INTO clientes (rut, nombre_completo, correo, telefono, id_tipo_cliente) VALUES
('11.111.111-1', 'Carlos Gómez', 'carlos.gomez@email.com', '987654321', 1),
(NULL, 'María Torres', 'maria.torres@email.com', '987654322', 2), -- Rut nulo
('13.333.333-3', 'Andrés López', NULL, '987654323', 1), -- Correo nulo
('14.444.444-4', 'Paula Reyes', 'paula.reyes@email.com', NULL, 3), -- Teléfono nulo
('15.555.555-5', 'Javier Silva', 'javier.silva@email.com', '987654324', 2),
(NULL, 'Daniela Rojas', 'daniela.rojas@email.com', '987654325', 1), -- Rut nulo
('17.777.777-7', 'Tomás Vidal', 'tomas.vidal@email.com', '987654326', 3),
('18.888.888-8', 'Lorena Fuentes', 'lorena.fuentes@email.com', '987654327', 1),
('19.999.999-9', 'Felipe Araya', NULL, '987654328', 2), -- Correo nulo
('10.000.000-0', 'Cecilia Castro', 'cecilia.castro@email.com', '987654329', 3);


-- HABITACIONES
INSERT INTO habitaciones (numero_habitacion, id_tipo_habitacion, estado) VALUES
('101', 1, 'disponible'),
('102', 1, 'disponible'),
('201', 2, 'ocupada'),
('202', 2, 'disponible'),
('301', 3, 'ocupada'),
('302', 3, 'disponible'),
('303', 2, 'mantenimiento'),
('304', 1, 'disponible'),
('401', 3, 'ocupada'),
('402', 2, 'disponible');


-- PERSONAL (con campos nulos)
INSERT INTO personal (nombre_completo, cargo, correo, telefono) VALUES
('Andrea Soto', 'Recepcionista', 'andrea.soto@email.com', '912345678'),
('Luis Rojas', 'Recepcionista', NULL, '912345679'), -- Correo nulo
('María López', 'Administrador', 'maria.lopez@email.com', NULL), -- Teléfono nulo
('Pedro González', 'Recepcionista', 'pedro.gonzalez@email.com', '912345680'),
('Claudia Díaz', 'Gerente', 'claudia.diaz@email.com', '912345681'),
('Javier Silva', 'Botones', 'javier.silva@email.com', '912345682'),
(NULL, 'Recepcionista', 'anonimo@email.com', '912345683'), -- Nombre nulo
('Patricia Reyes', 'Administrador', 'patricia.reyes@email.com', '912345684'),
('Daniel Hernández', 'Recepcionista', 'daniel.hernandez@email.com', '912345685'),
('Carolina Vega', 'Botones', 'carolina.vega@email.com', '912345686');


-- RESERVAS (con campos nulos)
INSERT INTO reservas (id_cliente, id_habitacion, id_personal, fecha_ingreso, fecha_salida, estado) VALUES
(1, 1, 1, '2025-08-01', '2025-08-05', 'confirmada'),
(2, 2, 2, NULL, '2025-08-10', 'pendiente'), -- Fecha ingreso nula
(3, 3, 3, '2025-08-05', '2025-08-12', 'confirmada'),
(4, 4, 4, '2025-08-07', NULL, 'pendiente'), -- Fecha salida nula
(5, 5, 5, '2025-08-09', '2025-08-11', 'finalizada'),
(6, 6, 6, '2025-08-12', '2025-08-14', NULL), -- Estado nulo
(7, 7, 7, '2025-08-13', '2025-08-15', 'confirmada'),
(8, 8, 8, '2025-08-15', '2025-08-17', 'cancelada'),
(9, 9, 9, NULL, '2025-08-19', 'pendiente'), -- Fecha ingreso nula
(10, 10, 10, '2025-08-18', '2025-08-20', 'confirmada');