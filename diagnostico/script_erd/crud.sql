USE `mydb` ;


-- -----------------------------------------------------
-- Consultas
-- -----------------------------------------------------

-- Seleccionar todos los usuarios registrados
SELECT * FROM `usuarios`;

-- Seleccionar todas las citas con estado "Pendiente"
SELECT * FROM `citas`
WHERE `estado_cita` = 'Pendiente';

-- Seleccionar consultas con diagnóstico "Espasmo muscular"
SELECT * FROM `consulta`
WHERE `diagnostico` = 'Espasmo muscular';

-- Seleccionar usuarios que son médicos (id_tipo_usuario = 2)
SELECT * FROM `usuarios`
WHERE `id_tipo_usuario` = 2;

-- Seleccionar todos los usuarios registrados
SELECT * FROM `consulta`;

-- -----------------------------------------------------
-- Modificar datos
-- -----------------------------------------------------

-- Cambiar el estado de una cita específica (id_citas = 1) a "Aprobada"
UPDATE `citas`
SET `estado_cita` = 'Aprobada'
WHERE `id_citas` = 1;

-- Cambiar el diagnóstico de una consulta específica (id_consulta = 1) a "Lesión muscular"
UPDATE `consulta`
SET `diagnostico` = 'Lesión muscular'
WHERE `id_consulta` = 1;

-- Cambiar el correo electrónico de un usuario específico (id_usuario = 1)
UPDATE `usuarios`
SET `email` = 'juan.perez.nuevo@example.com'
WHERE `id_usuario` = 1;

-- Cambiar la descripción de un tipo de tratamiento específico (id_tipo_tratamiento = 1)
UPDATE `tipo_tratamiento`
SET `descripcion` = 'Rehabilitación física y fortalecimiento muscular'
WHERE `id_tipo_tratamiento` = 1;

-- Cambiar la contraseña de un usuario específico (id_usuario = 2)
UPDATE `usuarios`
SET `password` = 'nuevapassword456'
WHERE `id_usuario` = 2;


-- -----------------------------------------------------
-- Borrar datos
-- -----------------------------------------------------

SET SQL_SAFE_UPDATES = 0; -- desactiva el modo seguro

-- Eliminar el usuario con id_usuario = 2
DELETE FROM `usuarios`
WHERE `id_usuario` = 2;

-- Eliminar la cita con id_citas = 3
DELETE FROM `citas`
WHERE `id_citas` = 3;

-- Eliminar el tipo de tratamiento con id_tipo_tratamiento = 4
DELETE FROM `tipo_tratamiento`
WHERE `id_tipo_tratamiento` = 4;

-- Eliminar la consulta con id_consulta = 2
DELETE FROM `consulta`
WHERE `id_consulta` = 2;

-- Eliminar la persona con RUT = 22334455
DELETE FROM `personas`
WHERE `RUT` = 22334455;