
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
	created_by INT NOT NULL,-- Usuario que crea,
	updated_by INT NOT NULL,-- Usuario que modifica,
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
	created_by INT NOT NULL,
	updated_by INT NOT NULL,
	deleted BOOLEAN DEFAULT FALSE,
    id_tipo INT NOT NULL
);

ALTER TABLE usuarios ADD CONSTRAINT fk_usuario_tipo_ususario FOREIGN KEY (id_tipo) REFERENCES tipo_usuarios(id_tipo); 

CREATE TABLE productos (
	id_producto INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	nombre VARCHAR(50) NOT NULL,
	precio INT NOT NULL,
	stock INT NOT NULL,
	created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, 
	created_by INT NOT NULL,
	updated_by INT NOT NULL,
	deleted BOOLEAN DEFAULT FALSE
);

CREATE TABLE ventas (
	id_venta INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
	fecha DATETIME DEFAULT CURRENT_TIMESTAMP,
	updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
ON UPDATE CURRENT_TIMESTAMP, 
	created_by INT NOT NULL,
	updated_by INT NOT NULL,
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
	created_by INT NOT NULL,
	updated_by INT NOT NULL,
	deleted BOOLEAN DEFAULT FALSE,
    id_venta INT NOT NULL,
    id_producto INT NOT NULL
);

ALTER TABLE detalle_ventas ADD CONSTRAINT fk_detalle_ventas_ventas FOREIGN KEY (id_venta) REFERENCES ventas(id_venta);
ALTER TABLE detalle_ventas ADD CONSTRAINT fk_detalle_ventas_productos FOREIGN KEY (id_producto) REFERENCES productos(id_producto);

ALTER TABLE tipo_usuarios CHANGE COLUMN nombre_tipo name_type VARCHAR(50) NOT NULL;

ALTER TABLE ventas CHANGE COLUMN fecha dated DATETIME DEFAULT CURRENT_TIMESTAMP;

ALTER TABLE detalle_ventas CHANGE COLUMN cantidad amount INT NOT NULL;
