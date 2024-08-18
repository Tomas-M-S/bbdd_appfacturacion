-- =============================================================================================================
-- Estructura de la base de datos de la AppFacturacion                                             // 04/12/2023
-- =============================================================================================================
-- MySQL / MariaDB
-- BBDD COMUN -> Tablas comunes
-- BBDD Administracion -> Únicamente para gestión del servicio de los diferentes contratos
-- BBDD Empresa0000 -> Base de datos de la aplicación en si misma
-- =============================================================================================================

CREATE DATABASE IF NOT EXISTS `Administracion`;

-- =============================================================================================================
USE `Administracion`;
-- =============================================================================================================

-- DROP TABLE `Administracion`.`Contratos`
CREATE TABLE IF NOT EXISTS `Administracion`.`Contratos` (
    id INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre_social VARCHAR(100) NOT NULL,
    Clave_acceso VARCHAR(50) NOT NULL,
    NIF VARCHAR(9) NOT NULL,
    Email VARCHAR(50) NOT NULL,
    Telefono VARCHAR(9) NOT NULL,
    fk_tipovia INT NOT NULL,
    Dir_calle VARCHAR(100) NOT NULL,
    Dir_numero VARCHAR(5),
    Dir_otros VARCHAR(50),
    fk_localidad INT NOT NULL,
    fecha_alta DATETIME NOT NULL,
    fecha_cambio DATETIME,
    fk_formasocial INT NOT NULL,
    Activo BOOLEAN NOT NULL
)
ENGINE=InnoDB
COMMENT="Tabla común en la que se almacenan los datos de todas los contratos con acceso a la aplicación";