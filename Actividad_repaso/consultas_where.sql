USE ejemploSelect;

-- 1.-  Mostrar todos los usuarios de tipo Cliente
-- Seleccionar nombre de usuario, correo y tipo_usuario
SELECT u.username, u.email, t.nombre_tipo FROM usuarios u, tipo_usuarios t WHERE u.id_tipo_usuario = 2 AND u.id_tipo_usuario = t.id_tipo;

-- 2.-  Mostrar Personas nacidas despues del año 1990
-- Seleccionar Nombre, fecha de nacimiento y username.
SELECT rut, nombre_completo FROM personas WHERE "1990-01-01" <= fecha_nac;

-- 3.- Seleccionar nombres de personas que comiencen con la 
-- letra A - Seleccionar nombre y correo la persona.
SELECT p.nombre_completo , u.email FROM usuarios u, personas p WHERE p.nombre_completo LIKE "A%" AND u.id_usuario = p.id_usuario;

-- 4.- Mostrar usuarios cuyos dominios de correo sean
-- mail.commit LIKE '%mail.com%'
SELECT id_usuario, username, email FROM usuarios WHERE email LIKE "%mail.com%";

-- 5.- Mostrar todas las personas que no viven en 
 -- Valparaiso y su usuario + ciudad.
 -- select * from ciudad; -- ID 2 VALPARAISO
SELECT u.username , c.nombre_ciudad FROM usuarios u, ciudad c, personas p WHERE c.id_ciudad != 2 and p.id_ciudad = c.id_ciudad AND p.id_usuario = u.id_usuario;

-- 6.- Mostrar usuarios que contengan más de 7 
-- carácteres de longitud.


-- 7.- Mostrar username de personas nacidas entre
-- 1990 y 1995