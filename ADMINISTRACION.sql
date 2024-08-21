-- =============================================================================================================
-- Estructura de la base de datos de la AppFacturacion                                             // 04/12/2023
-- =============================================================================================================
-- MySQL / MariaDB
-- BBDD COMUN -> Tablas comunes
-- BBDD Administracion -> Únicamente para gestión del servicio de los diferentes contratos
-- BBDD Empresa0000 -> Base de datos de la aplicación en si misma
-- =============================================================================================================

-- DROP DATABASE IF EXISTS `Administracion`;
CREATE DATABASE IF NOT EXISTS `Administracion`;

-- =============================================================================================================
USE `Administracion`;
-- =============================================================================================================


-- DROP TABLE `Administracion`.`Clientes`;
CREATE TABLE IF NOT EXISTS `Administracion`.`Tipocontratos` (
    id_tipocontrato INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Tipo VARCHAR(50) NOT NULL,
    Cuota FLOAT NOT NULL,
    comentario TEXT
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci
COMMENT="Tabla común en la que se almacenan los datos de los clientes";
INSERT IGNORE INTO `Administracion`.`Tipocontratos` (id_tipocontrato, Tipo) VALUES (1,"crm");


-- DROP TABLE `Administracion`.`Clientes`;
CREATE TABLE IF NOT EXISTS `Administracion`.`Clientes` (
    id_cliente INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    NIF VARCHAR(9) NOT NULL,
    fk_formasocial INT NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Telefono VARCHAR(9) NOT NULL,
    fk_tipovia INT NOT NULL,
    Dir_calle VARCHAR(100) NOT NULL,
    Dir_numero VARCHAR(5),
    Dir_otros VARCHAR(50),
    fk_localidad INT NOT NULL,
    fecha_alta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_cambio DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci
COMMENT="Tabla común en la que se almacenan los datos de los clientes";
ALTER TABLE `Administracion`.`Clientes`
    ADD CONSTRAINT fk_localidad FOREIGN KEY (fk_localidad)
    REFERENCES `Administracion`.`Localidades` (id_localidad);
ALTER TABLE `Administracion`.`Clientes`
    ADD CONSTRAINT fk_cliente FOREIGN KEY (fk_formasocial)
    REFERENCES `Administracion`.`Clientes` (id_cliente);


-- DROP TABLE `Administracion`.`Contratos`;
CREATE TABLE IF NOT EXISTS `Administracion`.`Contratos` (
    id_contrato INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_tipocontrato INT NOT NULL,
    fk_cliente INT NOT NULL,
    Clave_acceso VARCHAR(50) NOT NULL UNIQUE,
    fecha_alta DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_cambio DATETIME DEFAULT CURRENT_TIMESTAMP,
    Activo BOOLEAN NOT NULL DEFAULT true,
    Demo BOOLEAN NOT NULL DEFAULT false
)
ENGINE=InnoDB
DEFAULT CHARSET=utf8mb4
COLLATE=utf8mb4_unicode_ci
COMMENT="Tabla común en la que se almacenan los datos de todas los contratos con acceso a la aplicación";
ALTER TABLE `Administracion`.`Contratos`
    ADD CONSTRAINT fk_formasocial FOREIGN KEY (fk_formasocial)
    REFERENCES `Administracion`.`Sociedades` (id_formasocial);
ALTER TABLE `Administracion`.`Contratos`
    ADD CONSTRAINT fk_tipocontrado FOREIGN KEY (fk_tipocontrato)
    REFERENCES `Administracion`.`Tipocontratos` (id_tipocontrato);
