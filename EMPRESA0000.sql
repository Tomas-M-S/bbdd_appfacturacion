-- =============================================================================================================
-- Estructura de la base de datos de la AppFacturacion                                             // 04/12/2023
-- =============================================================================================================
-- MySQL / MariaDB
-- BBDD COMUN -> Tablas comunes
-- BBDD Administracion -> Únicamente para gestión del servicio de los diferentes contratos
-- BBDD Empresa0000 -> Base de datos de la aplicación en si misma
-- =============================================================================================================

CREATE DATABASE IF NOT EXISTS `Empresa0000`;

-- =============================================================================================================
USE `Empresa0000`;
-- =============================================================================================================


-- DROP TABLE `Empresa0000`.`Usuarios`
CREATE TABLE IF NOT EXISTS `Empresa0000`.`Configuracion` (
    Idioma INT NOT NULL,
    Fecha_pagos DATETIME NOT NULL
)
ENGINE=InnoDB
COMMENT="Configuraciones generales";


-- DROP TABLE `Empresa0000`.`Usuarios`
CREATE TABLE IF NOT EXISTS `Empresa0000`.`Usuarios` (
    id_user INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido1 VARCHAR(50),
    Apellido2 VARCHAR(50),
    Email VARCHAR(50) NOT NULL,
    password VARCHAR(30) NOT NULL,
    Telefono VARCHAR(9) NOT NULL,
    -- Roles VARCHAR(100) NOT NULL
    roles longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`roles`))
)
ENGINE=InnoDB
COMMENT="Usuario y administradores con acceso al panel de gestión";


-- DROP TABLE `Empresa0000`.`Comunidades`
CREATE TABLE IF NOT EXISTS `Empresa0000`.`Comunidades` (
    id_comunidad INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    CIF VARCHAR(9),
    Clave_acceso VARCHAR(50) NOT NULL,
    fk_tipovia INT NOT NULL,
    Dir_calle VARCHAR(100) NOT NULL,
    Dir_numero VARCHAR(5),
    Dir_otros VARCHAR(50),
    fk_localidad INT NOT NULL,
    coord_x FLOAT,
    coord_y FLOAT,
    Cuota_defecto INT NOT NULL,
    Fecha_pagos DATETIME NOT NULL,
    Comentarios VARCHAR(500)
)
ENGINE=InnoDB
COMMENT="Comunidades de vecinos";
ALTER TABLE `Empresa0000`.`Comunidades`
    ADD CONSTRAINT fk_tipovia FOREIGN KEY (fk_tipovia)
    REFERENCES `Empresa0000`.`Tipovias` (id_tipovia);
ALTER TABLE `Empresa0000`.`Comunidades`
    ADD CONSTRAINT fk_localidad FOREIGN KEY (fk_localidad)
    REFERENCES `Empresa0000`.`Localidades` (id_localidad);


-- DROP TABLE `Empresa0000`.`Contactos`
CREATE TABLE IF NOT EXISTS `Empresa0000`.`Contactos` (
    id_contacto INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(50) NOT NULL,
    Apellido1 VARCHAR(50),
    Apellido2 VARCHAR(50),
    Nif_cif VARCHAR(9),
    Telefono1 VARCHAR(9),
    Telefono2 VARCHAR(9),
    Email1 VARCHAR(50),
    Email2 VARCHAR(50),
    fk_localidad INT,
    fk_tipovia INT,
    Dir_calle VARCHAR(100),
    Dir_numero VARCHAR(5),
    Dir_otros VARCHAR(50),
    Envio_comunicados INT NOT NULL,
    Password VARCHAR(30),
    Comentarios VARCHAR(500)
    -- Roles VARCHAR(100) NOT NULL,
    roles longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL COMMENT '(DC2Type:json)' CHECK (json_valid(`roles`))
)
ENGINE=InnoDB
COMMENT="Contactos asociados a las viviendas (propietario, inquilino, pagador, etc.)";


-- DROP TABLE `Empresa0000`.`Viviendas`
CREATE TABLE IF NOT EXISTS `Empresa0000`.`Viviendas` (
    id_vivienda INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_comunidad INT NOT NULL,
    fk_propietario INT NOT NULL,
    fk_residente INT NOT NULL,
    fk_pagador INT NOT NULL,
    Nombre VARCHAR(50) NOT NULL,
    Piso INT,
    Numero INT,
    Escalera INT,
    Clave_acceso VARCHAR(50) NOT NULL,
    Fecha_emision_pagos DATETIME NOT NULL,
    Cuota INT NOT NULL,
    Facturacion_activa BOOL NOT NULL,
    Comentarios VARCHAR(500)
)
ENGINE=InnoDB
COMMENT="Viviendas vinculadas a las comunidades";
ALTER TABLE `Empresa0000`.`Viviendas`
    ADD CONSTRAINT fk_comunidad FOREIGN KEY (fk_comunidad)
    REFERENCES `Empresa0000`.`Comunidades` (id_comunidad);
ALTER TABLE `Empresa0000`.`Viviendas`
    ADD CONSTRAINT fk_propietario FOREIGN KEY (fk_propietario)
    REFERENCES `Empresa0000`.`Contactos` (id_contacto);
ALTER TABLE `Empresa0000`.`Viviendas`
    ADD CONSTRAINT fk_residente FOREIGN KEY (fk_residente)
    REFERENCES `Empresa0000`.`Contactos` (id_contacto);
ALTER TABLE `Empresa0000`.`Viviendas`
    ADD CONSTRAINT fk_pagador FOREIGN KEY (fk_pagador)
    REFERENCES `Empresa0000`.`Contactos` (id_contacto);


-- DROP TABLE `Empresa0000`.`Pagos`
CREATE TABLE IF NOT EXISTS `Empresa0000`.`Pagos` (
    id_pago INT NOT NULL AUTO_INCREMENT PRIMARY KEY,
    fk_vivienda INT NOT NULL,
    Fecha_emision DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    Fecha_pago DATETIME,
    fk_modopago INT,
    Comentarios VARCHAR(500)
)
ENGINE=InnoDB
COMMENT="Historico de pagos de todas las viviendas registradas";
ALTER TABLE `Empresa0000`.`Pagos`
    ADD CONSTRAINT fk_vivienda FOREIGN KEY (fk_vivienda)
    REFERENCES `Empresa0000`.`Viviendas` (id_vivienda);
ALTER TABLE `Empresa0000`.`Pagos`
    ADD CONSTRAINT fk_modopago FOREIGN KEY (fk_modopago)
    REFERENCES `Empresa0000`.`Modopago` (id_modopago);
