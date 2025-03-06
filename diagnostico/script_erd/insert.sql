USE `mydb` ;


-- -----------------------------------------------------
-- Inserciones
-- -----------------------------------------------------

-- Crear tipos de usuario
INSERT INTO `mydb`.`tipo_usuario` (`nombre_tipo_usuario`, `descripcion`, `created`)
VALUES 
('Paciente', 'Usuario que solicita consultas médicas', NOW()),
('Médico', 'Usuario que atiende consultas médicas', NOW()),
('Administrativo', 'Usuario que gestiona citas y consultas', NOW()),
('Enfermero', 'Usuario que brinda cuidados médicos', NOW()),
('Técnico', 'Usuario que realiza procedimientos técnicos', NOW());

-- Crear personas (pacientes, médicos, administrativos, etc.)
INSERT INTO `mydb`.`personas` (`RUT`, `nombre`, `apellido`, `fecha_nac`, `created`)
VALUES 
(12345678, 'Juan', 'Pérez', '1990-05-15', NOW()), -- Paciente
(87654321, 'María', 'Gómez', '1985-10-22', NOW()), -- Médico
(11223344, 'Carlos', 'López', '1978-03-30', NOW()), -- Administrativo
(22334455, 'Ana', 'Martínez', '1992-07-12', NOW()), -- Enfermero
(33445566, 'Pedro', 'Sánchez', '1980-11-25', NOW()); -- Técnico

-- Crear usuarios asociados a las personas
INSERT INTO `mydb`.`usuarios` (`username`, `password`, `email`, `created`, `id_tipo_usuario`, `RUT`)
VALUES 
('juanperez', 'password123', 'juan.perez@example.com', NOW(), 1, 12345678), -- Paciente
('mariagomez', 'password456', 'maria.gomez@example.com', NOW(), 2, 87654321), -- Médico
('carloslopez', 'password789', 'carlos.lopez@example.com', NOW(), 3, 11223344), -- Administrativo
('anamartinez', 'password101', 'ana.martinez@example.com', NOW(), 4, 22334455), -- Enfermero
('pedrosanchez', 'password112', 'pedro.sanchez@example.com', NOW(), 5, 33445566); -- Técnico

-- Crear citas
INSERT INTO `mydb`.`citas` (`fecha_cita`, `estado_cita`, `created`)
VALUES 
('2025-03-10 10:00:00', 'Pendiente', NOW()),
('2025-03-11 11:00:00', 'Aprobada', NOW()),
('2025-03-12 12:00:00', 'Rechazada', NOW()),
('2025-03-13 13:00:00', 'Pendiente', NOW()),
('2025-03-14 14:00:00', 'Aprobada', NOW());

-- Asociar citas a usuarios
INSERT INTO `mydb`.`citas_usuarios` (`id_citas`, `id_usuario`, `created`)
VALUES 
(1, 1, NOW()), -- Cita 1 asociada al usuario Juan Pérez (Paciente)
(2, 2, NOW()), -- Cita 2 asociada al usuario María Gómez (Médico)
(3, 3, NOW()), -- Cita 3 asociada al usuario Carlos López (Administrativo)
(4, 4, NOW()), -- Cita 4 asociada al usuario Ana Martínez (Enfermero)
(5, 5, NOW()); -- Cita 5 asociada al usuario Pedro Sánchez (Técnico)

-- Crear tipos de tratamiento
INSERT INTO `mydb`.`tipo_tratamiento` (`id_tipo_tratamiento`, `nombre_tipo_tratamiento`, `descripcion`, `created`)
VALUES 
(1, 'Fisioterapia', 'Tratamiento para rehabilitación física', NOW()),
(2, 'Cirugía', 'Intervención quirúrgica', NOW()),
(3, 'Medicación', 'Tratamiento con fármacos', NOW()),
(4, 'Terapia', 'Sesiones de terapia psicológica', NOW()),
(5, 'Rehabilitación', 'Programa de recuperación', NOW());

-- Crear tratamientos
INSERT INTO `mydb`.`tratamiento` (`id_tratamiento`, `fecha_tratamiento`, `created`, `id_tipo_tratamiento`)
VALUES 
(1, '2025-03-10 11:00:00', NOW(), 1), -- Fisioterapia
(2, '2025-03-11 12:00:00', NOW(), 2), -- Cirugía
(3, '2025-03-12 13:00:00', NOW(), 3), -- Medicación
(4, '2025-03-13 14:00:00', NOW(), 4), -- Terapia
(5, '2025-03-14 15:00:00', NOW(), 5); -- Rehabilitación

-- Crear consultas
INSERT INTO `mydb`.`consulta` (`id_consulta`, `motivo`, `diagnostico`, `fecha`, `created`, `id_tratamiento`, `id_citas`)
VALUES 
(1, 'Dolor de espalda', 'Espasmo muscular', '2025-03-10 10:30:00', NOW(), 1, 1), -- Consulta 1
(2, 'Fractura de brazo', 'Fractura expuesta', '2025-03-11 11:30:00', NOW(), 2, 2), -- Consulta 2
(3, 'Fiebre alta', 'Infección viral', '2025-03-12 12:30:00', NOW(), 3, 3), -- Consulta 3
(4, 'Ansiedad', 'Trastorno de ansiedad', '2025-03-13 13:30:00', NOW(), 4, 4), -- Consulta 4
(5, 'Lesión deportiva', 'Esguince de tobillo', '2025-03-14 14:30:00', NOW(), 5, 5); -- Consulta 5