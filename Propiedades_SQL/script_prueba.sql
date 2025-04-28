
drop database if exists sistema_ventas;
create database sistema_ventas;
use sistema_ventas;

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

insert into tipo_usuarios(nombre_tipo, descripcion_tipo, created_by, updated_by) values(
"Gerente","Encargado de supervisar a los empleados y gestionados administrativo", 1, 1);

select * from tipo_usuarios;