-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema MiBaseDeDatos
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema MiBaseDeDatos
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `MiBaseDeDatos` DEFAULT CHARACTER SET utf8 ;
USE `MiBaseDeDatos` ;

-- -----------------------------------------------------
-- Table `MiBaseDeDatos`.`ROL`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiBaseDeDatos`.`ROL` (
  `id_rol` INT NOT NULL AUTO_INCREMENT,
  `nombre` VARCHAR(50) NOT NULL,
  PRIMARY KEY (`id_rol`),
  UNIQUE INDEX `nombre_UNIQUE` (`nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiBaseDeDatos`.`USUARIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiBaseDeDatos`.`USUARIO` (
  `dni_usuario` INT NOT NULL,
  `nombre` VARCHAR(50) NOT NULL,
  `apellido_1` VARCHAR(50) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `password` VARCHAR(225) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  `ROL_id_rol` INT NOT NULL,
  `apellido_2` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`dni_usuario`),
  UNIQUE INDEX `correo_UNIQUE` (`correo` ASC) VISIBLE,
  INDEX `fk_USUARIO_ROL1_idx` (`ROL_id_rol` ASC) VISIBLE,
  CONSTRAINT `fk_USUARIO_ROL1`
    FOREIGN KEY (`ROL_id_rol`)
    REFERENCES `MiBaseDeDatos`.`ROL` (`id_rol`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiBaseDeDatos`.`CLIENTE`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiBaseDeDatos`.`CLIENTE` (
  `id_cliente` INT NOT NULL AUTO_INCREMENT,
  `razon_social` VARCHAR(100) NOT NULL,
  `ruc` VARCHAR(20) NOT NULL,
  `correo` VARCHAR(100) NOT NULL,
  `telefono` VARCHAR(20) NULL,
  PRIMARY KEY (`id_cliente`),
  UNIQUE INDEX `ruc_UNIQUE` (`ruc` ASC) VISIBLE,
  UNIQUE INDEX `correo_UNIQUE` (`correo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiBaseDeDatos`.`ACTIVIDAD_MANTENIMIENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiBaseDeDatos`.`ACTIVIDAD_MANTENIMIENTO` (
  `id_actividad` INT NOT NULL AUTO_INCREMENT,
  `descripcion` TEXT NOT NULL,
  `fecha` DATE NOT NULL,
  `hora` TIME NOT NULL,
  `tiempo_invertido` TIME NOT NULL,
  `titulo` TEXT NOT NULL,
  PRIMARY KEY (`id_actividad`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiBaseDeDatos`.`FINALIZACION_MANTENIMIENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiBaseDeDatos`.`FINALIZACION_MANTENIMIENTO` (
  `id_finalizacion` INT NOT NULL AUTO_INCREMENT,
  `resultado` VARCHAR(50) NOT NULL,
  `resumen_final` TEXT NOT NULL,
  `observacion` TEXT NULL,
  `fecha_fin` DATETIME NOT NULL,
  `estado_servicios` VARCHAR(30) NOT NULL,
  PRIMARY KEY (`id_finalizacion`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiBaseDeDatos`.`HIST_MANTENIMIENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiBaseDeDatos`.`HIST_MANTENIMIENTO` (
  `id_historial` INT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(30) NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id_historial`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiBaseDeDatos`.`MANTENIMIENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiBaseDeDatos`.`MANTENIMIENTO` (
  `codigo_mantenimiento` VARCHAR(10) NOT NULL,
  `tipo` VARCHAR(30) NOT NULL,
  `estado` VARCHAR(30) NOT NULL,
  `fecha_programada` DATE NOT NULL,
  `hora_inicio` TIME NULL,
  `duracion_estimada` TIME NOT NULL,
  `ACTIVIDAD_MANTENIMIENTO_id_actividad` INT NULL,
  `FINALIZACION_MANTENIMIENTO_id_finalizacion` INT NULL,
  `HIST_MANTENIMIENTO_id_historial` INT NULL,
  PRIMARY KEY (`codigo_mantenimiento`),
  INDEX `fk_MANTENIMIENTO_ACTIVIDAD_MANTENIMIENTO1_idx` (`ACTIVIDAD_MANTENIMIENTO_id_actividad` ASC) VISIBLE,
  INDEX `fk_MANTENIMIENTO_FINALIZACION_MANTENIMIENTO1_idx` (`FINALIZACION_MANTENIMIENTO_id_finalizacion` ASC) VISIBLE,
  INDEX `fk_MANTENIMIENTO_HIST_MANTENIMIENTO1_idx` (`HIST_MANTENIMIENTO_id_historial` ASC) VISIBLE,
  CONSTRAINT `fk_MANTENIMIENTO_ACTIVIDAD_MANTENIMIENTO1`
    FOREIGN KEY (`ACTIVIDAD_MANTENIMIENTO_id_actividad`)
    REFERENCES `MiBaseDeDatos`.`ACTIVIDAD_MANTENIMIENTO` (`id_actividad`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MANTENIMIENTO_FINALIZACION_MANTENIMIENTO1`
    FOREIGN KEY (`FINALIZACION_MANTENIMIENTO_id_finalizacion`)
    REFERENCES `MiBaseDeDatos`.`FINALIZACION_MANTENIMIENTO` (`id_finalizacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_MANTENIMIENTO_HIST_MANTENIMIENTO1`
    FOREIGN KEY (`HIST_MANTENIMIENTO_id_historial`)
    REFERENCES `MiBaseDeDatos`.`HIST_MANTENIMIENTO` (`id_historial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiBaseDeDatos`.`LANDING_STATION`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiBaseDeDatos`.`LANDING_STATION` (
  `id_landing` VARCHAR(10) NOT NULL,
  `nombre` VARCHAR(20) NOT NULL,
  `ciudad` VARCHAR(50) NOT NULL,
  `pais` VARCHAR(50) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  `MANTENIMIENTO_id_mantenimiento1` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`id_landing`),
  INDEX `fk_LANDING_STATION_MANTENIMIENTO2_idx` (`MANTENIMIENTO_id_mantenimiento1` ASC) VISIBLE,
  CONSTRAINT `fk_LANDING_STATION_MANTENIMIENTO2`
    FOREIGN KEY (`MANTENIMIENTO_id_mantenimiento1`)
    REFERENCES `MiBaseDeDatos`.`MANTENIMIENTO` (`codigo_mantenimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiBaseDeDatos`.`UTILIZACION_HIST`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiBaseDeDatos`.`UTILIZACION_HIST` (
  `id_registro` INT NOT NULL AUTO_INCREMENT,
  `fecha` DATE NOT NULL,
  `capacidad_utilizada` DECIMAL(10,2) NOT NULL,
  `capacidad_disponible` DECIMAL(10,2) NOT NULL,
  `capacidad_total` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_registro`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiBaseDeDatos`.`SEGMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiBaseDeDatos`.`SEGMENTO` (
  `codigo_segmento` VARCHAR(12) NOT NULL,
  `capacidad_total` DECIMAL(10,2) NOT NULL,
  `capacidad_utilizada` DECIMAL(10,2) NOT NULL,
  `capacidad_reservada` DECIMAL(10,2) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  `UTILIZACION_HIST_id_registro` INT NOT NULL,
  `LANDING_STATION_id_origen` VARCHAR(10) NOT NULL,
  `LANDING_STATION_id_destino` VARCHAR(10) NOT NULL,
  `MANTENIMIENTO_id_mantenimiento` VARCHAR(10) NOT NULL,
  PRIMARY KEY (`codigo_segmento`),
  INDEX `fk_SEGMENTO_UTILIZACION_HIST1_idx` (`UTILIZACION_HIST_id_registro` ASC) VISIBLE,
  INDEX `fk_SEGMENTO_LANDING_STATION1_idx` (`LANDING_STATION_id_origen` ASC) VISIBLE,
  INDEX `fk_SEGMENTO_LANDING_STATION2_idx` (`LANDING_STATION_id_destino` ASC) VISIBLE,
  INDEX `fk_SEGMENTO_MANTENIMIENTO1_idx` (`MANTENIMIENTO_id_mantenimiento` ASC) VISIBLE,
  CONSTRAINT `fk_SEGMENTO_UTILIZACION_HIST1`
    FOREIGN KEY (`UTILIZACION_HIST_id_registro`)
    REFERENCES `MiBaseDeDatos`.`UTILIZACION_HIST` (`id_registro`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SEGMENTO_LANDING_STATION1`
    FOREIGN KEY (`LANDING_STATION_id_origen`)
    REFERENCES `MiBaseDeDatos`.`LANDING_STATION` (`id_landing`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SEGMENTO_LANDING_STATION2`
    FOREIGN KEY (`LANDING_STATION_id_destino`)
    REFERENCES `MiBaseDeDatos`.`LANDING_STATION` (`id_landing`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SEGMENTO_MANTENIMIENTO1`
    FOREIGN KEY (`MANTENIMIENTO_id_mantenimiento`)
    REFERENCES `MiBaseDeDatos`.`MANTENIMIENTO` (`codigo_mantenimiento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiBaseDeDatos`.`HIST_SOLICITUD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiBaseDeDatos`.`HIST_SOLICITUD` (
  `id_historial` INT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(30) NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id_historial`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiBaseDeDatos`.`SOLICITUD_CAPACIDAD`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiBaseDeDatos`.`SOLICITUD_CAPACIDAD` (
  `id_solicitud` INT NOT NULL AUTO_INCREMENT,
  `id_ruta_propuesta` INT NOT NULL,
  `capacidad_requerida` DECIMAL(10,2) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  `fecha_solicitud` DATE NOT NULL,
  `HIST_SOLICITUD_id_historial` INT NOT NULL,
  `USUARIO_id_usuario` INT NOT NULL,
  `fecha_requerida` DATE NOT NULL,
  `observaciones` VARCHAR(45) NULL,
  PRIMARY KEY (`id_solicitud`),
  INDEX `fk_SOLICITUD_CAPACIDAD_HIST_SOLICITUD1_idx` (`HIST_SOLICITUD_id_historial` ASC) VISIBLE,
  INDEX `fk_SOLICITUD_CAPACIDAD_USUARIO1_idx` (`USUARIO_id_usuario` ASC) VISIBLE,
  CONSTRAINT `fk_SOLICITUD_CAPACIDAD_HIST_SOLICITUD1`
    FOREIGN KEY (`HIST_SOLICITUD_id_historial`)
    REFERENCES `MiBaseDeDatos`.`HIST_SOLICITUD` (`id_historial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SOLICITUD_CAPACIDAD_USUARIO1`
    FOREIGN KEY (`USUARIO_id_usuario`)
    REFERENCES `MiBaseDeDatos`.`USUARIO` (`dni_usuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiBaseDeDatos`.`RUTA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiBaseDeDatos`.`RUTA` (
  `id_ruta` INT NOT NULL AUTO_INCREMENT,
  `codigo` VARCHAR(20) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_ruta`),
  UNIQUE INDEX `codigo_UNIQUE` (`codigo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiBaseDeDatos`.`SERVICIO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiBaseDeDatos`.`SERVICIO` (
  `id_servicio` INT NOT NULL AUTO_INCREMENT,
  `capacidad_contratada` DECIMAL(10,2) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  `RUTA_id_ruta` INT NOT NULL,
  `CLIENTE_id_cliente` INT NOT NULL,
  `fecha_activacion` DATE NOT NULL,
  PRIMARY KEY (`id_servicio`),
  INDEX `fk_SERVICIO_RUTA1_idx` (`RUTA_id_ruta` ASC) VISIBLE,
  INDEX `fk_SERVICIO_CLIENTE1_idx` (`CLIENTE_id_cliente` ASC) VISIBLE,
  CONSTRAINT `fk_SERVICIO_RUTA1`
    FOREIGN KEY (`RUTA_id_ruta`)
    REFERENCES `MiBaseDeDatos`.`RUTA` (`id_ruta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_SERVICIO_CLIENTE1`
    FOREIGN KEY (`CLIENTE_id_cliente`)
    REFERENCES `MiBaseDeDatos`.`CLIENTE` (`id_cliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiBaseDeDatos`.`HIST_INCIDENCIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiBaseDeDatos`.`HIST_INCIDENCIA` (
  `id_historial` INT NOT NULL AUTO_INCREMENT,
  `estado` VARCHAR(30) NOT NULL,
  `fecha` DATETIME NOT NULL,
  PRIMARY KEY (`id_historial`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiBaseDeDatos`.`INCIDENCIA`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiBaseDeDatos`.`INCIDENCIA` (
  `codigo_incidencia` VARCHAR(10) NOT NULL,
  `descripcion` TEXT NOT NULL,
  `severidad` VARCHAR(20) NOT NULL,
  `estado` VARCHAR(20) NOT NULL,
  `fecha_deteccion` DATETIME NOT NULL,
  `titulo` TEXT NOT NULL,
  `SEGMENTO_codigo_segmento` VARCHAR(12) NOT NULL,
  `LANDING_STATION_id_landing` VARCHAR(10) NOT NULL,
  `hora` TIME NOT NULL,
  `HIST_INCIDENCIA_id_historial` INT NOT NULL,
  PRIMARY KEY (`codigo_incidencia`),
  INDEX `fk_INCIDENCIA_SEGMENTO1_idx` (`SEGMENTO_codigo_segmento` ASC) VISIBLE,
  INDEX `fk_INCIDENCIA_LANDING_STATION1_idx` (`LANDING_STATION_id_landing` ASC) VISIBLE,
  INDEX `fk_INCIDENCIA_HIST_INCIDENCIA1_idx` (`HIST_INCIDENCIA_id_historial` ASC) VISIBLE,
  CONSTRAINT `fk_INCIDENCIA_SEGMENTO1`
    FOREIGN KEY (`SEGMENTO_codigo_segmento`)
    REFERENCES `MiBaseDeDatos`.`SEGMENTO` (`codigo_segmento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_INCIDENCIA_LANDING_STATION1`
    FOREIGN KEY (`LANDING_STATION_id_landing`)
    REFERENCES `MiBaseDeDatos`.`LANDING_STATION` (`id_landing`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_INCIDENCIA_HIST_INCIDENCIA1`
    FOREIGN KEY (`HIST_INCIDENCIA_id_historial`)
    REFERENCES `MiBaseDeDatos`.`HIST_INCIDENCIA` (`id_historial`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `MiBaseDeDatos`.`RUTA_has_SEGMENTO`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `MiBaseDeDatos`.`RUTA_has_SEGMENTO` (
  `RUTA_id_ruta` INT NOT NULL,
  `SEGMENTO_codigo_segmento` VARCHAR(10) NOT NULL,
  `orden` INT NOT NULL,
  PRIMARY KEY (`RUTA_id_ruta`, `SEGMENTO_codigo_segmento`),
  INDEX `fk_RUTA_has_SEGMENTO_SEGMENTO1_idx` (`SEGMENTO_codigo_segmento` ASC) VISIBLE,
  INDEX `fk_RUTA_has_SEGMENTO_RUTA1_idx` (`RUTA_id_ruta` ASC) VISIBLE,
  CONSTRAINT `fk_RUTA_has_SEGMENTO_RUTA1`
    FOREIGN KEY (`RUTA_id_ruta`)
    REFERENCES `MiBaseDeDatos`.`RUTA` (`id_ruta`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_RUTA_has_SEGMENTO_SEGMENTO1`
    FOREIGN KEY (`SEGMENTO_codigo_segmento`)
    REFERENCES `MiBaseDeDatos`.`SEGMENTO` (`codigo_segmento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
