
DROP SCHEMA IF EXISTS `agencia_viajes` ;

CREATE SCHEMA IF NOT EXISTS `agencia_viajes` DEFAULT CHARACTER SET utf8 ;
USE `agencia_viajes` ;

-- -----------------------------------------------------
-- Tabla `tipo_usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia_viajes`.`tipo_usuario` (
  `id_tipo_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo_usuario` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `usuario_id` INT NOT NULL,
  `delete` TINYINT NOT NULL,
  PRIMARY KEY (`id_tipo_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia_viajes`.`personas` (
  `RUT` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `fecha_nac` VARCHAR(45) NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `usuario_id` INT NOT NULL,
  `delete` TINYINT NOT NULL,
  PRIMARY KEY (`RUT`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia_viajes`.`usuarios` (
  `id_usuarios` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `usuario_id` INT NOT NULL,
  `delete` TINYINT NOT NULL,
  `RUT` INT NOT NULL,
  `id_tipo_usuario` INT NOT NULL,
  PRIMARY KEY (`id_usuarios`, `RUT`, `id_tipo_usuario`),
  CONSTRAINT `fk_usuarios_personas1`
    FOREIGN KEY (`RUT`)
    REFERENCES `agencia_viajes`.`personas` (`RUT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_tipo_usuario1`
    FOREIGN KEY (`id_tipo_usuario`)
    REFERENCES `agencia_viajes`.`tipo_usuario` (`id_tipo_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_usuarios_personas1_idx` ON `agencia_viajes`.`usuarios` (`RUT` ASC) VISIBLE;

CREATE INDEX `fk_usuarios_tipo_usuario1_idx` ON `agencia_viajes`.`usuarios` (`id_tipo_usuario` ASC) VISIBLE;


-- -----------------------------------------------------
-- Tabla `tipo_viaje`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia_viajes`.`tipo_viaje` (
  `id_tipo_viaje` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo_viaje` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(100) NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `usuario_id` INT NOT NULL,
  `delete` TINYINT NOT NULL,
  PRIMARY KEY (`id_tipo_viaje`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `registro_viajes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia_viajes`.`registro_viajes` (
  `id_registro_viajes` INT NOT NULL,
  `agencia` VARCHAR(45) NOT NULL,
  `llegada` DATETIME NOT NULL,
  `salida` DATETIME NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `usuario_id` INT NOT NULL,
  `delete` TINYINT NOT NULL,
  `id_tipo_viaje` INT NOT NULL,
  PRIMARY KEY (`id_registro_viajes`, `id_tipo_viaje`),
  CONSTRAINT `fk_registro_viajes_tipo_viaje1`
    FOREIGN KEY (`id_tipo_viaje`)
    REFERENCES `agencia_viajes`.`tipo_viaje` (`id_tipo_viaje`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_registro_viajes_tipo_viaje1_idx` ON `agencia_viajes`.`registro_viajes` (`id_tipo_viaje` ASC) VISIBLE;


-- -----------------------------------------------------
-- Tabla `aeropuertos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia_viajes`.`aeropuertos` (
  `id_aereopuertos` INT NOT NULL,
  `nombre_aeropuerto` VARCHAR(50) NOT NULL,
  `ubicacion` VARCHAR(100) NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `usuario_id` INT NOT NULL,
  `delete` TINYINT NOT NULL,
  PRIMARY KEY (`id_aereopuertos`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `metodo_pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia_viajes`.`metodo_pago` (
  `id_metodo_pago` INT NOT NULL,
  `nombre_metodo` VARCHAR(50) NOT NULL,
  `descripcion_metodo` VARCHAR(100) NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `usuario_id` INT NOT NULL,
  `delete` TINYINT NOT NULL,
  PRIMARY KEY (`id_metodo_pago`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Tabla `tarifa`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia_viajes`.`tarifa` (
  `id_tarifa` INT NOT NULL,
  `costo` INT NOT NULL,
  `descuento` INT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `usuario_id` INT NOT NULL,
  `delete` TINYINT NOT NULL,
  `id_metodo_pago` INT NOT NULL,
  PRIMARY KEY (`id_tarifa`, `id_metodo_pago`),
  CONSTRAINT `fk_tarifa_metodo_pago1`
    FOREIGN KEY (`id_metodo_pago`)
    REFERENCES `agencia_viajes`.`metodo_pago` (`id_metodo_pago`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_tarifa_metodo_pago1_idx` ON `agencia_viajes`.`tarifa` (`id_metodo_pago` ASC) VISIBLE;


-- -----------------------------------------------------
-- Tabla `viajes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia_viajes`.`viajes` (
  `id_viajes` INT NOT NULL AUTO_INCREMENT,
  `numero_vuelo` INT NOT NULL,
  `asientos` INT NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `usuario_id` INT NOT NULL,
  `delete` TINYINT NOT NULL,
  `id_registro_viajes` INT NOT NULL,
  `origen` INT NOT NULL,
  `destino` INT NOT NULL,
  `id_tarifa` INT NOT NULL,
  PRIMARY KEY (`id_viajes`, `id_registro_viajes`, `origen`, `destino`, `id_tarifa`),
  CONSTRAINT `fk_viajes_registro_viajes1`
    FOREIGN KEY (`id_registro_viajes`)
    REFERENCES `agencia_viajes`.`registro_viajes` (`id_registro_viajes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_viajes_aereopuertos1`
    FOREIGN KEY (`origen`)
    REFERENCES `agencia_viajes`.`aeropuertos` (`id_aereopuertos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_viajes_aereopuertos2`
    FOREIGN KEY (`destino`)
    REFERENCES `agencia_viajes`.`aeropuertos` (`id_aereopuertos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_viajes_tarifa1`
    FOREIGN KEY (`id_tarifa`)
    REFERENCES `agencia_viajes`.`tarifa` (`id_tarifa`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_viajes_registro_viajes1_idx` ON `agencia_viajes`.`viajes` (`id_registro_viajes` ASC) VISIBLE;

CREATE INDEX `fk_viajes_aereopuertos1_idx` ON `agencia_viajes`.`viajes` (`origen` ASC) VISIBLE;

CREATE INDEX `fk_viajes_aereopuertos2_idx` ON `agencia_viajes`.`viajes` (`destino` ASC) VISIBLE;

CREATE INDEX `fk_viajes_tarifa1_idx` ON `agencia_viajes`.`viajes` (`id_tarifa` ASC) VISIBLE;


-- -----------------------------------------------------
-- Tabla `usuarios_has_viajes`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `agencia_viajes`.`usuarios_has_viajes` (
  `usuarios_id_usuarios` INT NOT NULL,
  `viajes_id_viajes` INT NOT NULL,
  PRIMARY KEY (`usuarios_id_usuarios`, `viajes_id_viajes`),
  CONSTRAINT `fk_usuarios_has_viajes_usuarios`
    FOREIGN KEY (`usuarios_id_usuarios`)
    REFERENCES `agencia_viajes`.`usuarios` (`id_usuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_usuarios_has_viajes_viajes1`
    FOREIGN KEY (`viajes_id_viajes`)
    REFERENCES `agencia_viajes`.`viajes` (`id_viajes`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_usuarios_has_viajes_viajes1_idx` ON `agencia_viajes`.`usuarios_has_viajes` (`viajes_id_viajes` ASC) VISIBLE;

CREATE INDEX `fk_usuarios_has_viajes_usuarios_idx` ON `agencia_viajes`.`usuarios_has_viajes` (`usuarios_id_usuarios` ASC) VISIBLE;
