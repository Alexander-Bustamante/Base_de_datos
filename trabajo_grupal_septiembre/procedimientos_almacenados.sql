-- =============================================
-- PROCEDIMIENTOS ALMACENADOS PARA TABLA usuarios
-- =============================================

-- =============================================
-- PROCEDIMIENTOS ALMACENADOS PARA TABLA usuarios
-- =============================================

DELIMITER //
CREATE PROCEDURE insertarUsuarios(
IN usuario_username VARCHAR(100),
IN usuario_passwords VARCHAR(50),
IN usuario_email VARCHAR(50),
IN usuario_id_tipo_usuarios INT,
IN usuario_RUT INT,
IN usuario_id_cargo INT,
IN usuario_id_asignatura INT,
IN usuario_id_instituciones INT,
IN usuario_id_capacitaciones INT)
BEGIN
    INSERT INTO usuarios(
        username, passwords, email, 
        id_tipo_usuarios, RUT, 
        id_cargo, id_asignatura, 
        id_instituciones, id_capacitaciones
    ) VALUES (
        usuario_username, usuario_passwords, usuario_email, 
        usuario_id_tipo_usuarios, usuario_RUT, 
        usuario_id_cargo, usuario_id_asignatura, 
        usuario_id_instituciones, usuario_id_capacitaciones
    );
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE borradoLogicoUsuarios(
IN id_ingresado INT
)
BEGIN
	UPDATE `edukit`.`usuarios` 
	SET `deleted` = 1 
	WHERE `id_usuarios` = id_ingresado;
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE usuariosActivos()
BEGIN
    SELECT id_usuarios, username, email, 
           id_tipo_usuarios, RUT, id_cargo, id_asignatura, 
           id_instituciones, id_capacitaciones,
           created_at, updated_at
    FROM `edukit`.`usuarios` 
    WHERE deleted = 0
    ORDER BY id_usuarios;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE todosUsuarios()
BEGIN
    SELECT * FROM usuarios;
END //
DELIMITER ;


-- =============================================
-- PROCEDIMIENTOS ALMACENADOS PARA TABLA historiales
-- =============================================

DELIMITER //
CREATE PROCEDURE insertarHistoriales(
IN historial_promedio_mensual INT,
IN historial_fecha DATE)
BEGIN
	INSERT INTO historiales(promedio_mensual, fecha) VALUES
		(historial_promedio_mensual, historial_fecha);
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE borradoLogicoHistoriales(
IN id_ingresado INT
)
BEGIN
	UPDATE `edukit`.`historiales` 
	SET `deleted` = 1 
	WHERE `id_Historiales` = id_ingresado;
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE historialesActivos()
BEGIN
    SELECT id_Historiales, promedio_mensual, fecha,
           created_at, updated_at
    FROM `edukit`.`historiales` 
    WHERE deleted = 0
    ORDER BY id_Historiales;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE todosHistoriales()
BEGIN
    SELECT * FROM historiales;
END //
DELIMITER ;


-- =============================================
-- PROCEDIMIENTOS ALMACENADOS PARA TABLA personas
-- =============================================

DELIMITER //
CREATE PROCEDURE insertarPersonas(
IN persona_RUT INT,
IN persona_nombre VARCHAR(50),
IN persona_apellido VARCHAR(50),
IN persona_fecha_nac DATE,
IN persona_direccion VARCHAR(200),
IN persona_id_Historiales INT)
BEGIN
	INSERT INTO personas(RUT, nombre, apellido, fecha_nac, direccion, id_Historiales) VALUES
		(persona_RUT, persona_nombre, persona_apellido, persona_fecha_nac, persona_direccion, persona_id_Historiales);
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE borradoLogicoPersonas(
IN id_ingresado INT
)
BEGIN
	UPDATE `edukit`.`personas` 
	SET `deleted` = 1 
	WHERE `RUT` = id_ingresado;
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE personasActivas()
BEGIN
    SELECT RUT, nombre, apellido, fecha_nac, direccion,
           id_Historiales, created_at, updated_at
    FROM `edukit`.`personas` 
    WHERE deleted = 0
    ORDER BY RUT;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE todasPersonas()
BEGIN
    SELECT * FROM personas;
END //
DELIMITER ;


-- =============================================
-- PROCEDIMIENTOS ALMACENADOS PARA TABLA tipos_usuarios
-- =============================================

DELIMITER //
CREATE PROCEDURE insertarTipos_usuarios(
IN tipo_nombre_tipo VARCHAR(50),
IN tipo_descripcion_tipo VARCHAR(300))
BEGIN
	INSERT INTO tipos_usuarios(nombre_tipo, descripcion_tipo) VALUES
		(tipo_nombre_tipo, tipo_descripcion_tipo);
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE borradoLogicoTipos_usuarios(
IN id_ingresado INT
)
BEGIN
	UPDATE `edukit`.`tipos_usuarios` 
	SET `deleted` = 1 
	WHERE `id_tipo_usuarios` = id_ingresado;
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE tipos_usuariosActivos()
BEGIN
    SELECT id_tipo_usuarios, nombre_tipo, descripcion_tipo,
           created_at, updated_at
    FROM `edukit`.`tipos_usuarios` 
    WHERE deleted = 0
    ORDER BY id_tipo_usuarios;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE todosTipos_usuarios()
BEGIN
    SELECT * FROM tipos_usuarios;
END //
DELIMITER ;


-- =============================================
-- PROCEDIMIENTOS ALMACENADOS PARA TABLA cargo
-- =============================================

DELIMITER //
CREATE PROCEDURE insertarCargo(
IN cargo_nombre_cargo VARCHAR(45),
IN cargo_descripcion_cargo VARCHAR(45))
BEGIN
	INSERT INTO cargo(nombre_cargo, descripcion_cargo) VALUES
		(cargo_nombre_cargo, cargo_descripcion_cargo);
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE borradoLogicoCargo(
IN id_ingresado INT
)
BEGIN
	UPDATE `edukit`.`cargo` 
	SET `deleted` = 1 
	WHERE `id_cargo` = id_ingresado;
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE cargoActivos()
BEGIN
    SELECT id_cargo, nombre_cargo, descripcion_cargo,
           created_at, updated_at
    FROM `edukit`.`cargo` 
    WHERE deleted = 0
    ORDER BY id_cargo;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE todosCargo()
BEGIN
    SELECT * FROM cargo;
END //
DELIMITER ;


-- =============================================
-- PROCEDIMIENTOS ALMACENADOS PARA TABLA asignatura
-- =============================================

DELIMITER //
CREATE PROCEDURE insertarAsignatura(
IN asignatura_nombre_asig VARCHAR(45),
IN asignatura_descripcion_asig VARCHAR(45))
BEGIN
	INSERT INTO asignatura(nombre_asig, descripcion_asig) VALUES
		(asignatura_nombre_asig, asignatura_descripcion_asig);
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE borradoLogicoAsignatura(
IN id_ingresado INT
)
BEGIN
	UPDATE `edukit`.`asignatura` 
	SET `deleted` = 1 
	WHERE `id_asignatura` = id_ingresado;
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE asignaturaActivos()
BEGIN
    SELECT id_asignatura, nombre_asig, descripcion_asig,
           created_at, updated_at
    FROM `edukit`.`asignatura` 
    WHERE deleted = 0
    ORDER BY id_asignatura;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE todasAsignatura()
BEGIN
    SELECT * FROM asignatura;
END //
DELIMITER ;


-- =============================================
-- PROCEDIMIENTOS ALMACENADOS PARA TABLA tipos_institucion
-- =============================================

DELIMITER //
CREATE PROCEDURE insertarTipos_institucion(
IN tipo_nombre_tipo VARCHAR(50),
IN tipo_descripcion_tipo VARCHAR(300))
BEGIN
	INSERT INTO tipos_institucion(nombre_tipo, descripcion_tipo) VALUES
		(tipo_nombre_tipo, tipo_descripcion_tipo);
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE borradoLogicoTipos_institucion(
IN id_ingresado INT
)
BEGIN
	UPDATE `edukit`.`tipos_institucion` 
	SET `deleted` = 1 
	WHERE `id_tipos_institucion` = id_ingresado;
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE tipos_institucionActivos()
BEGIN
    SELECT id_tipos_institucion, nombre_tipo, descripcion_tipo,
           created_at, updated_at
    FROM `edukit`.`tipos_institucion` 
    WHERE deleted = 0
    ORDER BY id_tipos_institucion;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE todosTipos_institucion()
BEGIN
    SELECT * FROM tipos_institucion;
END //
DELIMITER ;


-- =============================================
-- PROCEDIMIENTOS ALMACENADOS PARA TABLA instituciones
-- =============================================

DELIMITER //
CREATE PROCEDURE insertarInstituciones(
IN institucion_nombre VARCHAR(100),
IN institucion_direccion VARCHAR(100),
IN institucion_email VARCHAR(100),
IN institucion_id_tipos_institucion INT)
BEGIN
	INSERT INTO instituciones(nombre, direccion, email, id_tipos_institucion) VALUES
		(institucion_nombre, institucion_direccion, institucion_email, institucion_id_tipos_institucion);
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE borradoLogicoInstituciones(
IN id_ingresado INT
)
BEGIN
	UPDATE `edukit`.`instituciones` 
	SET `deleted` = 1 
	WHERE `id_instituciones` = id_ingresado;
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE institucionesActivos()
BEGIN
    SELECT id_instituciones, nombre, direccion, email,
           id_tipos_institucion, created_at, updated_at
    FROM `edukit`.`instituciones` 
    WHERE deleted = 0
    ORDER BY id_instituciones;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE todasInstituciones()
BEGIN
    SELECT * FROM instituciones;
END //
DELIMITER ;


-- =============================================
-- PROCEDIMIENTOS ALMACENADOS PARA TABLA tipo_capacitaciones
-- =============================================

DELIMITER //
CREATE PROCEDURE insertarTipo_capacitaciones(
IN tipo_nombre_tipo VARCHAR(45),
IN tipo_descripcion_tipo VARCHAR(45))
BEGIN
	INSERT INTO tipo_capacitaciones(nombre_tipo, descripcion_tipo) VALUES
		(tipo_nombre_tipo, tipo_descripcion_tipo);
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE borradoLogicoTipo_capacitaciones(
IN id_ingresado INT
)
BEGIN
	UPDATE `edukit`.`tipo_capacitaciones` 
	SET `deleted` = 1 
	WHERE `id_tipo_capacitaciones` = id_ingresado;
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE tipo_capacitacionesActivos()
BEGIN
    SELECT id_tipo_capacitaciones, nombre_tipo, descripcion_tipo,
           created_at, updated_at
    FROM `edukit`.`tipo_capacitaciones` 
    WHERE deleted = 0
    ORDER BY id_tipo_capacitaciones;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE todosTipo_capacitaciones()
BEGIN
    SELECT * FROM tipo_capacitaciones;
END //
DELIMITER ;


-- =============================================
-- PROCEDIMIENTOS ALMACENADOS PARA TABLA capacitaciones
-- =============================================

DELIMITER //
CREATE PROCEDURE insertarCapacitaciones(
IN capacitacion_nombre VARCHAR(45),
IN capacitacion_duracion_horas VARCHAR(45),
IN capacitacion_id_tipo_capacitaciones INT)
BEGIN
	INSERT INTO capacitaciones(nombre, duracion_horas, id_tipo_capacitaciones) VALUES
		(capacitacion_nombre, capacitacion_duracion_horas, capacitacion_id_tipo_capacitaciones);
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE borradoLogicoCapacitaciones(
IN id_ingresado INT
)
BEGIN
	UPDATE `edukit`.`capacitaciones` 
	SET `deleted` = 1 
	WHERE `id_capacitaciones` = id_ingresado;
END// 
DELIMITER ;

DELIMITER //
CREATE PROCEDURE capacitacionesActivos()
BEGIN
    SELECT id_capacitaciones, nombre, duracion_horas,
           id_tipo_capacitaciones, created_at, updated_at
    FROM `edukit`.`capacitaciones` 
    WHERE deleted = 0
    ORDER BY id_capacitaciones;
END //
DELIMITER ;

DELIMITER //
CREATE PROCEDURE todasCapacitaciones()
BEGIN
    SELECT * FROM capacitaciones;
END //
DELIMITER ;


-- =============================================
-- LLAMADAS A PROCEDIMIENTOS ALMACENADOS
-- =============================================

-- =============================================
-- SECCIÓN: usuarios
-- =============================================
CALL insertarUsuarios('nuevo_usuario1', 'password123', 'usuario1@email.com', 1, 12345678, 1, 1, 1, 1);
CALL insertarUsuarios('nuevo_usuario2', 'password456', 'usuario2@email.com', 2, 23456789, 2, 2, 2, 2);
CALL insertarUsuarios('nuevo_usuario3', 'password789', 'usuario3@email.com', 3, 34567890, 3, 3, 3, 3);
CALL borradoLogicoUsuarios(1);
CALL usuariosActivos();
CALL todosUsuarios();

-- =============================================
-- SECCIÓN: historiales
-- =============================================
CALL insertarHistoriales(85, '2025-01-15');
CALL insertarHistoriales(90, '2025-01-16');
CALL insertarHistoriales(78, '2025-01-17');
CALL borradoLogicoHistoriales(1);
CALL historialesActivos();
CALL todosHistoriales();

-- =============================================
-- SECCIÓN: personas
-- =============================================
CALL insertarPersonas(22334477, 'Ana', 'García', '1990-01-01', 'Dirección 123', 1);
CALL insertarPersonas(33445599, 'Luis', 'Martínez', '1991-02-02', 'Dirección 456', 2);
CALL insertarPersonas(44556600, 'Marta', 'López', '1992-03-03', 'Dirección 789', 3);
CALL borradoLogicoPersonas(22334455);
CALL personasActivas();
CALL todasPersonas();

-- =============================================
-- SECCIÓN: tipos_usuarios
-- =============================================
CALL insertarTipos_usuarios('Administrador', 'Usuario supervisor del sistema');
CALL insertarTipos_usuarios('Docente', 'Usuario auditor con permisos de revisión');
CALL insertarTipos_usuarios('Estudiante', 'Usuario invitado con permisos limitados');
CALL borradoLogicoTipos_usuarios(1);
CALL tipos_usuariosActivos();
CALL todosTipos_usuarios();

-- =============================================
-- SECCIÓN: cargo
-- =============================================
CALL insertarCargo('Director', 'Jefe de departamento académico');
CALL insertarCargo('Subdirector', 'Secretario administrativo');
CALL insertarCargo('Docente', 'Tutor académico');
CALL borradoLogicoCargo(1);
CALL cargoActivos();
CALL todosCargo();

-- =============================================
-- SECCIÓN: asignatura
-- =============================================
CALL insertarAsignatura('Historia', 'Historia universal y nacional');
CALL insertarAsignatura('Geografía', 'Geografía física y política');
CALL insertarAsignatura('Inglés', 'Idioma inglés');
CALL borradoLogicoAsignatura(1);
CALL asignaturaActivos();
CALL todasAsignatura();

-- =============================================
-- SECCIÓN: tipos_institucion
-- =============================================
CALL insertarTipos_institucion('Escuela', 'Institución de enseñanza especializada');
CALL insertarTipos_institucion('Liceo', 'Centro de formación técnica');
CALL insertarTipos_institucion('Instituto', 'Escuela de enseñanza técnica');
CALL borradoLogicoTipos_institucion(1);
CALL tipos_institucionActivos();
CALL todosTipos_institucion();

-- =============================================
-- SECCIÓN: instituciones
-- =============================================
CALL insertarInstituciones('Colegio Nuevo Amanecer', 'Av. Nueva 123', 'info@nuevoamanecer.cl', 1);
CALL insertarInstituciones('Liceo Tecnológico', 'Calle Tecnología 456', 'contacto@liceotecnologico.cl', 2);
CALL insertarInstituciones('Instituto Profesional', 'Pasaje Profesional 789', 'admision@institutoprofesional.cl', 3);
CALL borradoLogicoInstituciones(1);
CALL institucionesActivos();
CALL todasInstituciones();

-- =============================================
-- SECCIÓN: tipo_capacitaciones
-- =============================================
CALL insertarTipo_capacitaciones('Presencial', 'Curso intensivo de corta duración');
CALL insertarTipo_capacitaciones('Online', 'Curso extensivo de larga duración');
CALL insertarTipo_capacitaciones('Híbrido', 'Curso con certificación oficial');
CALL borradoLogicoTipo_capacitaciones(1);
CALL tipo_capacitacionesActivos();
CALL todosTipo_capacitaciones();

-- =============================================
-- SECCIÓN: capacitaciones
-- =============================================
CALL insertarCapacitaciones('Primeros Auxilios', '16 horas', 1);
CALL insertarCapacitaciones('Office Avanzado', '24 horas', 2);
CALL insertarCapacitaciones('Liderazgo Educativo', '30 horas', 3);
CALL borradoLogicoCapacitaciones(1);
CALL capacitacionesActivos();
CALL todasCapacitaciones();