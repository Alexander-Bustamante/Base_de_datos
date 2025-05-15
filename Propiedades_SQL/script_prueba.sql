
drop database if exists sistema_ventas_4C;
create database sistema_ventas_4C;
use sistema_ventas_4C;

-- Creamos la tabla tipo_usuario
CREATE TABLE tipo_usuarios (
	id_tipo INT AUTO_INCREMENT PRIMARY KEY NOT NULL, -- Identificador único
	nombre_tipo VARCHAR(50) NOT NULL, -- Tipo de usuario (Admin, Cliente)
	descripcion_tipo VARCHAR(300) NOT NULL,
-- Campos de auditoría
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
-- Fecha creación
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, -- Fecha modificación
	created_by INT,-- Usuario que crea,
	updated_by INT,-- Usuario que modifica,
	deleted BOOLEAN DEFAULT FALSE -- Borrado lógico
);

CREATE TABLE usuarios (
	id_usuario INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	username VARCHAR(50) NOT NULL,
	password_ VARCHAR(50) NOT NULL,
	email VARCHAR(100) NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, 
	created_by INT,
	updated_by INT,
	deleted BOOLEAN DEFAULT FALSE,
    id_tipo INT NOT NULL
);

ALTER TABLE usuarios ADD CONSTRAINT fk_usuario_tipo_ususario FOREIGN KEY (id_tipo) REFERENCES tipo_usuarios(id_tipo); 

CREATE TABLE productos (
	id_producto INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	descripcion VARCHAR(200) NOT NULL,
	precio INT NOT NULL,
	stock INT NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, 
	created_by INT,
	updated_by INT,
	deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE ventas (
	id_venta INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, 
	created_by INT,
	updated_by INT,
	deleted BOOLEAN DEFAULT FALSE,
	id_usuario INT NOT NULL
);

ALTER TABLE ventas ADD CONSTRAINT fk_ventas_usuario FOREIGN KEY (id_usuario) REFERENCES usuarios(id_usuario);

CREATE TABLE detalle_ventas (
	id_detalle_venta INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    cantidad INT NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, 
	created_by INT,
	updated_by INT,
	deleted BOOLEAN DEFAULT FALSE,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL
);

ALTER TABLE detalle_ventas ADD CONSTRAINT fk_detalle_ventas_ventas FOREIGN KEY (id_venta) REFERENCES ventas(id_venta);
ALTER TABLE detalle_ventas ADD CONSTRAINT fk_detalle_ventas_productos FOREIGN KEY (id_producto) REFERENCES productos(id_producto);

ALTER TABLE tipo_usuarios CHANGE COLUMN nombre_tipo name_type VARCHAR(50) NOT NULL;

ALTER TABLE ventas CHANGE COLUMN fecha dated DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE detalle_ventas CHANGE COLUMN cantidad amount INT NOT NULL;


INSERT INTO tipo_usuarios (
    name_type,
    descripcion_tipo,
    created_by,
    updated_by
)VALUES (
    'Administrador',
    'Accede a todas las funciones del sistema, incluida la administración de usuarios.',
    1, -- creado por el usuario inicial
    1  -- actualizado por el mismo
),(	'Vendedor',
	'Se encarga de las ventas',
    1,
    1
);

INSERT INTO usuarios (
    username, password_, email, id_tipo, created_by, updated_by
)VALUES (
    'sistema',
    '$2y$10$2pEjT0G2k9YzHs1oZ.abcde3Y8GkmHfvhO1/abcxyz', -- Contraseña encriptada (ejemplo realista con bcrypt)
    'sistema@plataforma.cl',
    1,
    NULL,
    NULL
),(
	'Vendedor 1',
    'Usuario1234',
    'vendedor1@gmail.com',
    2,
    1,
    1
),(
	'Vendedor 2',
    'Usuario5678',
    'vendedor2@gmail.com',
    2,
    1,
    1
);

INSERT INTO productos (nombre, descripcion, precio, stock, created_by, updated_by
)VALUES (
	'Chocolate',
    'Barra grande de Chocolate de 125g',
    1500,
    35,
    1,
    1
),(
	'Gelatina en polvo',
    'Paquete de gelatina en polvo de 100g',
    1000,
    30,
    1,
    1
),(
	'Jugo de naranja',
    'Jugo de naranja de 1.5L',
    1300,
    25,
    1,
    1
);


INSERT INTO ventas (dated, created_by, updated_by, id_usuario
) VALUES (
	now(),
    1,
    1,
    2
),(
	now(),
    1,
    1,
    3
);

INSERT INTO detalle_ventas (amount, created_by, updated_by, id_venta, id_producto
)VALUES (
	25,
    1,
    1,
    1,
    3
),(
	20,
    1,
    1,
	1,
    2
),(
	5,
    1,
    1,
	2,
    1
),(
	40,
    1,
    1,
	2,
    2
);