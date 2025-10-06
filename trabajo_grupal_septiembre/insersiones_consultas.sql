USE `mydb` ;

-- Inserciones para tabla historiales (10 registros)
INSERT INTO `mydb`.`historiales` (`promedio_mensual`, `fecha`) VALUES
(85, '2025-01-15'),
(92, '2025-02-20'),
(78, '2025-03-10'),
(88, '2025-04-05'),
(95, '2025-05-12'),
(82, '2025-06-18'),
(90, '2025-07-22'),
(87, '2025-08-30'),
(93, '2025-09-08'),
(79, '2025-10-01');

-- Inserciones para tabla tipos_usuarios (3 registros)
INSERT INTO `mydb`.`tipos_usuarios` (`nombre_tipo`, `descripcion_tipo`) VALUES
('Administrador', 'Usuario con permisos completos del sistema'),
('Docente', 'Usuario profesor con acceso a módulos académicos'),
('Estudiante', 'Usuario alumno con acceso limitado');

-- Inserciones para tabla cargo (3 registros)
INSERT INTO `mydb`.`cargo` (`nombre_cargo`, `descripcion_cargo`) VALUES
('Director', 'Director de la institución educativa'),
('Docente', 'Profesor a cargo de asignaturas'),
('Coordinador', 'Coordinador académico');

-- Inserciones para tabla asignatura (3 registros)
INSERT INTO `mydb`.`asignatura` (`nombre_asig`, `descripcion_asig`) VALUES
('Matemáticas', 'Álgebra, cálculo y geometría'),
('Lenguaje', 'Comunicación y literatura'),
('Ciencias', 'Biología, física y química');

-- Inserciones para tabla tipos_institucion (3 registros)
INSERT INTO `mydb`.`tipos_institucion` (`nombre_tipo`, `descripcion_tipo`) VALUES
('Colegio', 'Institución de educación básica y media'),
('Liceo', 'Establecimiento de educación secundaria'),
('Universidad', 'Institución de educación superior');

-- Inserciones para tabla tipo_capacitaciones (3 registros)
INSERT INTO `mydb`.`tipo_capacitaciones` (`nombre_tipo`, `descripcion_tipo`) VALUES
('Presencial', 'Capacitación en formato presencial'),
('Online', 'Capacitación en línea virtual'),
('Taller', 'Capacitación práctica tipo taller');

-- Inserciones para tabla personas (10 registros)
INSERT INTO `mydb`.`personas` (`RUT`, `nombre`, `apellido`, `fecha_nac`, `direccion`, `id_Historiales`) VALUES
(12345678, 'Juan', 'Pérez', '1985-03-15', 'Av. Principal 123, Santiago', 1),
(23456789, 'María', 'González', '1990-07-22', 'Calle Secundaria 456, Valparaíso', 2),
(34567890, 'Carlos', 'López', '1988-11-30', 'Pasaje Los Olivos 789, Concepción', 3),
(45678901, 'Ana', 'Martínez', '1992-05-14', 'Av. Central 321, La Serena', 4),
(56789012, 'Pedro', 'Rodríguez', '1987-09-08', 'Calle Norte 654, Antofagasta', 5),
(67890123, 'Laura', 'Silva', '1993-12-25', 'Av. Sur 987, Temuco', 6),
(78901234, 'Diego', 'Fernández', '1986-08-17', 'Pasaje Este 147, Iquique', 7),
(89012345, 'Carmen', 'Vargas', '1991-04-03', 'Calle Oeste 258, Puerto Montt', 8),
(90123456, 'Roberto', 'Mendoza', '1989-06-19', 'Av. Los Andes 369, Rancagua', 9),
(11223344, 'Elena', 'Castro', '1994-02-28', 'Calle Los Plátanos 741, Arica', 10);

-- Inserciones para tabla instituciones (10 registros)
INSERT INTO `mydb`.`instituciones` (`nombre`, `direccion`, `email`, `id_tipos_institucion`) VALUES
('Colegio San Marcos', 'Av. Educación 123, Santiago', 'contacto@colegiosanmarcos.cl', 1),
('Liceo Bicentenario', 'Cle. del Estudiante 456, Valparaíso', 'info@liceobicentenario.cl', 2),
('Universidad Central', 'Av. Universitaria 789, Santiago', 'admision@universidadcentral.cl', 3),
('Colegio Los Alerces', 'Pasaje Verde 321, Concepción', 'administracion@colegiolosalerces.cl', 1),
('Liceo Técnico Profesional', 'Av. Industrial 654, Antofagasta', 'contacto@liceotecnico.cl', 2),
('Universidad del Pacífico', 'Costa Mar 987, La Serena', 'info@udelpacifico.cl', 3),
('Colegio Santa María', 'Av. Principal 147, Temuco', 'direccion@colegiosantamaria.cl', 1),
('Liceo Comercial', 'Calle Comercio 258, Iquique', 'secretaria@liceocomercial.cl', 2),
('Universidad Austral', 'Av. Los Pinos 369, Puerto Montt', 'admision@uaustral.cl', 3),
('Colegio Andino', 'Pasaje Montaña 741, Rancagua', 'contacto@colegioandino.cl', 1);

-- Inserciones para tabla capacitaciones (10 registros)
INSERT INTO `mydb`.`capacitaciones` (`nombre`, `duracion_horas`, `id_tipo_capacitaciones`) VALUES
('Metodologías Activas', '20 horas', 1),
('Tecnología Educativa', '30 horas', 2),
('Evaluación por Competencias', '15 horas', 3),
('Gestión del Aula', '25 horas', 1),
('Plataformas Virtuales', '18 horas', 2),
('Didáctica de la Matemática', '22 horas', 3),
('Inclusión Educativa', '28 horas', 1),
('Herramientas Digitales', '16 horas', 2),
('Neuroeducación', '24 horas', 3),
('Liderazgo Educativo', '20 horas', 1);

-- Inserciones para tabla usuarios (10 registros) - CORREGIDAS
INSERT INTO `mydb`.`usuarios` (`username`, `password`, `email`, `id_tipo_usuarios`, `RUT`, `id_cargo`, `id_asignatura`, `id_instituciones`, `id_capacitaciones`) VALUES
('juanperez', 'password123', 'juan.perez@colegiosanmarcos.cl', 1, 12345678, 1, 1, 1, 1),
('mariagonzalez', 'securepass456', 'maria.gonzalez@liceobicentenario.cl', 2, 23456789, 2, 2, 2, 2),
('carloslopez', 'mypassword789', 'carlos.lopez@universidadcentral.cl', 3, 34567890, 3, 3, 3, 3),
('anamartinez', 'ana_pass2024', 'ana.martinez@colegiolosalerces.cl', 2, 45678901, 2, 1, 4, 4),
('pedrorodriguez', 'pedro_secure99', 'pedro.rodriguez@liceotecnico.cl', 2, 56789012, 2, 2, 5, 5),
('laurasilva', 'laura123456', 'laura.silva@udelpacifico.cl', 3, 67890123, 3, 3, 6, 6),
('diegofernandez', 'diego_pass789', 'diego.fernandez@colegiosantamaria.cl', 2, 78901234, 2, 1, 7, 7),
('carmenvargas', 'carmen_2024', 'carmen.vargas@liceocomercial.cl', 2, 89012345, 2, 2, 8, 8),
('robertomendoza', 'roberto_pass', 'roberto.mendoza@uaustral.cl', 3, 90123456, 3, 3, 9, 9),
('elenacastro', 'elena_secure', 'elena.castro@colegioandino.cl', 2, 11223344, 2, 1, 10, 10);


-- 1. Consultas básicas para ver registros
SELECT * FROM tipos_usuarios;
SELECT * FROM personas;
SELECT * FROM usuarios;

-- 2. Consultas para registros activos
SELECT * FROM personas WHERE deleted = 0;
SELECT * FROM usuarios WHERE deleted = 0;

-- 3. Validación de relaciones entre tablas
-- Usuarios con sus datos de persona
SELECT u.username, p.nombre, p.apellido, tu.nombre_tipo as tipo_usuario
FROM usuarios u
JOIN personas p ON u.RUT = p.RUT
JOIN tipos_usuarios tu ON u.id_tipo_usuarios = tu.id_tipo_usuarios;

-- 4. Validación de CHECK constraints
-- Verificar que emails tengan formato válido
SELECT email FROM usuarios WHERE email REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$';

-- Verificar que passwords tengan al menos 8 caracteres
SELECT username, LENGTH(password) as largo_password 
FROM usuarios 
WHERE LENGTH(password) >= 8;

-- 5. Validación de tipos específicos
-- Tipos de usuario con cantidad de usuarios
SELECT tu.nombre_tipo, COUNT(u.id_usuarios) as cantidad
FROM tipos_usuarios tu
LEFT JOIN usuarios u ON tu.id_tipo_usuarios = u.id_tipo_usuarios
GROUP BY tu.nombre_tipo;