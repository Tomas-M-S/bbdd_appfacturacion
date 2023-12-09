-- =============================================================================================================
-- Estructura de la base de datos de la AppFacturacion                                             // 04/12/2023
-- =============================================================================================================
-- MySQL / MariaDB
-- BBDD COMUN -> Tablas comunes
-- BBDD Administración -> Únicamente para gestión del servicio de los diferentes contratos
-- BBDD Empresa0000 -> Base de datos de la aplicación en si misma
-- =============================================================================================================

CREATE DATABASE IF NOT EXISTS `COMUN`;

-- =============================================================================================================
USE `COMUN`;
-- =============================================================================================================

-- DROP TABLE `COMUN`.`Tipovias`
CREATE TABLE IF NOT EXISTS `COMUN`.`Tipovias` (
    id_tipovia INT NOT NULL AUTO_INCREMENT,
    Tipo VARCHAR(50) NOT NULL
)
ENGINE=InnoDB
COMMENT="Almacena los tipos de vía posibles (Calle, Avenida, Plaza, Carretera, etc.)";
ALTER TABLE `COMUN`.`Tipovias`
    ADD CONSTRAINT pk_id_tipovia PRIMARY KEY (id_tipovia);


-- DROP TABLE `COMUN`.`IVA`
CREATE TABLE IF NOT EXISTS `COMUN`.`IVA` (
    id_iva INT NOT NULL AUTO_INCREMENT,
    Tipo_iva INT NOT NULL
)
ENGINE=InnoDB
COMMENT="Almacena los diferentes tipos impositivos del IVA";
ALTER TABLE `COMUN`.`IVA`
    ADD CONSTRAINT pk_id_iva PRIMARY KEY (id_iva);

-- DROP TABLE `COMUN`.`IVA`
CREATE TABLE IF NOT EXISTS `COMUN`.`IGIC` (
    id_igic INT NOT NULL AUTO_INCREMENT,
    Tipo_igic INT NOT NULL
)
ENGINE=InnoDB
COMMENT="Almacena los diferentes tipos impositivos del IGIC (IVA Canario)";
ALTER TABLE `COMUN`.`IGIC`
    ADD CONSTRAINT pk_id_igic PRIMARY KEY (id_igic);

-- DROP TABLE `COMUN`.`Sociedades`
CREATE TABLE IF NOT EXISTS `COMUN`.`Sociedades` (
    id_formasocial INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(50) NOT NULL,
    Abreviatura VARCHAR(10) NOT NULL
)
ENGINE=InnoDB
COMMENT="Almacena todos los tipos posibles de formas sociales (Sociedad Limitada, Sociedad Anonima, Persona Física, etc.)";
ALTER TABLE `COMUN`.`Sociedades`
    ADD CONSTRAINT pk_id_formasocial PRIMARY KEY (id_formasocial);

-- DROP TABLE `COMUN`.`Autonomias`
CREATE TABLE IF NOT EXISTS `COMUN`.`Provincias` (
    id_autonomia INT NOT NULL AUTO_INCREMENT,
    Nombre VARCHAR(50) NOT NULL,
    Nombre_local VARCHAR(50)
)
ENGINE=InnoDB
COMMENT="Almacena las comunidades autónomas (Cantabria, Andalucía, etc.)";
ALTER TABLE `COMUN`.`Provincias`
    ADD CONSTRAINT pk_id_autonomia PRIMARY KEY (id_autonomia);

-- DROP TABLE `COMUN`.`Provincias`
CREATE TABLE IF NOT EXISTS `COMUN`.`Provincias` (
   id_provincia INT NOT NULL AUTO_INCREMENT,
   Nombre VARCHAR(50) NOT NULL,
   Nombre_local VARCHAR(50)
)
ENGINE=InnoDB
COMMENT="Almacena las provincias de España (Albacete, oria, Teruel, Gerona, etc.)";
ALTER TABLE `COMUN`.`Provincias`
    ADD CONSTRAINT pk_id_provincia PRIMARY KEY (id_provincia);

-- DROP TABLE `COMUN`.`Localidades`
CREATE TABLE IF NOT EXISTS `COMUN`.`Localidades` (
    id_localidad INT NOT NULL AUTO_INCREMENT,
    fk_provincia INT NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Nombre_local VARCHAR(50)
)
ENGINE=InnoDB
COMMENT="Almacena todas las localidades oficialmente reconocidas extraídas del INE";
ALTER TABLE `COMUN`.`Localidades`
    ADD CONSTRAINT pk_id_localidad PRIMARY KEY (id_localidad);
ALTER TABLE `COMUN`.`Localidades`
    ADD CONSTRAINT fk_provincia FOREIGN KEY (id_provincia)
    REFERENCES `COMUN`.`Provincias` (id_provincia);

