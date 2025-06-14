-- MySQL Script generated by MySQL Workbench
-- Sun Apr 20 18:25:40 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `mydb` ;

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Personas` (
  `RUT` INT NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido` VARCHAR(50) NOT NULL,
  `fecha_nac` DATE NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `deleted` TINYINT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`RUT`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tipos_usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tipos_usuarios` (
  `id_tipo_usuario` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo` VARCHAR(50) NOT NULL,
  `descripcion_tipo` VARCHAR(300) NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `deleted` TINYINT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id_tipo_usuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Usuarios` (
  `id_Usuario` INT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(50) NOT NULL,
  `password` VARCHAR(50) NOT NULL,
  `email` VARCHAR(50) NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `deleted` TINYINT NOT NULL,
  `usuario_id` INT NOT NULL,
  `RUT` INT NOT NULL,
  `id_tipo_usuario` INT NOT NULL,
  PRIMARY KEY (`id_Usuario`, `RUT`, `id_tipo_usuario`),
  CONSTRAINT `fk_Usuarios_Personas`
    FOREIGN KEY (`RUT`)
    REFERENCES `mydb`.`Personas` (`RUT`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Usuarios_Tipos_usuarios1`
    FOREIGN KEY (`id_tipo_usuario`)
    REFERENCES `mydb`.`Tipos_usuarios` (`id_tipo_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Usuarios_Personas_idx` ON `mydb`.`Usuarios` (`RUT` ASC) VISIBLE;

CREATE INDEX `fk_Usuarios_Tipos_usuarios1_idx` ON `mydb`.`Usuarios` (`id_tipo_usuario` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`tipos_asistencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`tipos_asistencias` (
  `id_tipo_asistencia` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `deleted` TINYINT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id_tipo_asistencia`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Asistencias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Asistencias` (
  `id_Asistencia` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATETIME NOT NULL,
  `asistio` TINYINT NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `deleted` TINYINT NOT NULL,
  `usuario_id` INT NOT NULL,
  `id_Usuario` INT NOT NULL,
  `id_tipo_asistencia` INT NOT NULL,
  PRIMARY KEY (`id_Asistencia`, `id_Usuario`, `id_tipo_asistencia`),
  CONSTRAINT `fk_Asistencias_Usuarios1`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `mydb`.`Usuarios` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Asistencias_tipos_asistencias1`
    FOREIGN KEY (`id_tipo_asistencia`)
    REFERENCES `mydb`.`tipos_asistencias` (`id_tipo_asistencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Asistencias_Usuarios1_idx` ON `mydb`.`Asistencias` (`id_Usuario` ASC) VISIBLE;

CREATE INDEX `fk_Asistencias_tipos_asistencias1_idx` ON `mydb`.`Asistencias` (`id_tipo_asistencia` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Tipos_cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tipos_cursos` (
  `id_tipo_curso` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `deleted` TINYINT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id_tipo_curso`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Modalidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Modalidades` (
  `id_modalidad` INT NOT NULL AUTO_INCREMENT,
  `tipo_modalidad` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `deleted` TINYINT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id_modalidad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Tipo_evaluacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Tipo_evaluacion` (
  `id_Tipo_evaluacion` INT NOT NULL AUTO_INCREMENT,
  `nombre_tipo` VARCHAR(50) NOT NULL,
  `descripcion` VARCHAR(500) NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `deleted` TINYINT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id_Tipo_evaluacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Calificaciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Calificaciones` (
  `id_calificacion` INT NOT NULL AUTO_INCREMENT,
  `calificacion` INT NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `deleted` TINYINT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`id_calificacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Evaluacion_final`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Evaluacion_final` (
  `id_Evaluacion` INT NOT NULL AUTO_INCREMENT,
  `observaciones` VARCHAR(1500) NOT NULL,
  `fecha_evaluacion` DATETIME NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `deleted` TINYINT NOT NULL,
  `usuario_id` INT NOT NULL,
  `id_Tipo_evaluacion` INT NOT NULL,
  `id_calificacion` INT NOT NULL,
  PRIMARY KEY (`id_Evaluacion`, `id_Tipo_evaluacion`, `id_calificacion`),
  CONSTRAINT `fk_Evaluacion_final_Tipo_evaluacion1`
    FOREIGN KEY (`id_Tipo_evaluacion`)
    REFERENCES `mydb`.`Tipo_evaluacion` (`id_Tipo_evaluacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Evaluacion_final_Calificaciones1`
    FOREIGN KEY (`id_calificacion`)
    REFERENCES `mydb`.`Calificaciones` (`id_calificacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Evaluacion_final_Tipo_evaluacion1_idx` ON `mydb`.`Evaluacion_final` (`id_Tipo_evaluacion` ASC) VISIBLE;

CREATE INDEX `fk_Evaluacion_final_Calificaciones1_idx` ON `mydb`.`Evaluacion_final` (`id_calificacion` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Cursos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cursos` (
  `id_Curso` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(100) NOT NULL,
  `descripcion` VARCHAR(300) NOT NULL,
  `fecha_inicio` DATE NOT NULL,
  `horas_curso` INT NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `deleted` TINYINT NOT NULL,
  `usuario_id` INT NOT NULL,
  `id_Asistencia` INT NOT NULL,
  `id_tipo_curso` INT NOT NULL,
  `id_modalidad` INT NOT NULL,
  `id_Evaluacion` INT NOT NULL,
  PRIMARY KEY (`id_Curso`, `id_Asistencia`, `id_tipo_curso`, `id_modalidad`, `id_Evaluacion`),
  CONSTRAINT `fk_Cursos_Asistencias1`
    FOREIGN KEY (`id_Asistencia`)
    REFERENCES `mydb`.`Asistencias` (`id_Asistencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cursos_Tipos_cursos1`
    FOREIGN KEY (`id_tipo_curso`)
    REFERENCES `mydb`.`Tipos_cursos` (`id_tipo_curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cursos_Modalidades1`
    FOREIGN KEY (`id_modalidad`)
    REFERENCES `mydb`.`Modalidades` (`id_modalidad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cursos_Evaluacion_final1`
    FOREIGN KEY (`id_Evaluacion`)
    REFERENCES `mydb`.`Evaluacion_final` (`id_Evaluacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Cursos_Asistencias1_idx` ON `mydb`.`Cursos` (`id_Asistencia` ASC) VISIBLE;

CREATE INDEX `fk_Cursos_Tipos_cursos1_idx` ON `mydb`.`Cursos` (`id_tipo_curso` ASC) VISIBLE;

CREATE INDEX `fk_Cursos_Modalidades1_idx` ON `mydb`.`Cursos` (`id_modalidad` ASC) VISIBLE;

CREATE INDEX `fk_Cursos_Evaluacion_final1_idx` ON `mydb`.`Cursos` (`id_Evaluacion` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Inscripciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Inscripciones` (
  `id_Inscripcion` INT NOT NULL AUTO_INCREMENT,
  `fecha_inscripcion` DATETIME NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `deleted` TINYINT NOT NULL,
  `usuario_id` INT NOT NULL,
  `id_Usuario` INT NOT NULL,
  PRIMARY KEY (`id_Inscripcion`, `id_Usuario`),
  CONSTRAINT `fk_Inscripciones_Usuarios1`
    FOREIGN KEY (`id_Usuario`)
    REFERENCES `mydb`.`Usuarios` (`id_Usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Inscripciones_Usuarios1_idx` ON `mydb`.`Inscripciones` (`id_Usuario` ASC) VISIBLE;


-- -----------------------------------------------------
-- Table `mydb`.`Cursos_has_Inscripciones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cursos_has_Inscripciones` (
  `Cursos_id_Curso` INT NOT NULL,
  `Inscripciones_id_Inscripcion` INT NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `deleted` TINYINT NOT NULL,
  `usuario_id` INT NOT NULL,
  PRIMARY KEY (`Cursos_id_Curso`, `Inscripciones_id_Inscripcion`),
  CONSTRAINT `fk_Cursos_has_Inscripciones_Cursos1`
    FOREIGN KEY (`Cursos_id_Curso`)
    REFERENCES `mydb`.`Cursos` (`id_Curso`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cursos_has_Inscripciones_Inscripciones1`
    FOREIGN KEY (`Inscripciones_id_Inscripcion`)
    REFERENCES `mydb`.`Inscripciones` (`id_Inscripcion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE INDEX `fk_Cursos_has_Inscripciones_Inscripciones1_idx` ON `mydb`.`Cursos_has_Inscripciones` (`Inscripciones_id_Inscripcion` ASC) VISIBLE;

CREATE INDEX `fk_Cursos_has_Inscripciones_Cursos1_idx` ON `mydb`.`Cursos_has_Inscripciones` (`Cursos_id_Curso` ASC) VISIBLE;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
