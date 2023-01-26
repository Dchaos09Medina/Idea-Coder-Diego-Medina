-- MySQL Script generated by MySQL Workbench
-- Wed Jan 25 23:54:37 2023
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`Entidades`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Entidades` (
  `idEntidades` INT GENERATED ALWAYS AS () VIRTUAL,
  `Nombre entidad` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  `Link de pag` LONGTEXT NULL,
  PRIMARY KEY (`idEntidades`),
  UNIQUE INDEX `idEntidades_UNIQUE` (`idEntidades` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Producto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Producto` (
  `idProducto` INT GENERATED ALWAYS AS () VIRTUAL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Productocol` VARCHAR(45) NULL,
  `IdEntidades` INT NOT NULL,
  `Fecha actulizada` DATE NOT NULL,
  `Fecha arranque` DATE NOT NULL,
  `Riesgo Categorizado` VARCHAR(45) NOT NULL,
  `Moneda` VARCHAR(45) NOT NULL,
  `Tiempo esperado` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `idProducto_UNIQUE` (`idProducto` ASC) VISIBLE,
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC) VISIBLE,
  PRIMARY KEY (`idProducto`),
  CONSTRAINT `idEntidades`
    FOREIGN KEY (`IdEntidades`)
    REFERENCES `mydb`.`Entidades` (`idEntidades`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Rendimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Rendimientos` (
  `IdRendimientos` INT GENERATED ALWAYS AS () VIRTUAL,
  `Fecha` DATE NOT NULL,
  `Rendimiento%` DOUBLE NOT NULL,
  `IdProducto` INT NOT NULL,
  PRIMARY KEY (`IdRendimientos`),
  UNIQUE INDEX `IdRendimientos_UNIQUE` (`IdRendimientos` ASC) VISIBLE,
  INDEX `IdProducto_idx` (`IdProducto` ASC) VISIBLE,
  CONSTRAINT `IdProducto`
    FOREIGN KEY (`IdProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Calculo Riesgo Rendimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Calculo Riesgo Rendimientos` (
  `Id Riesgo Rendimientos` INT GENERATED ALWAYS AS () VIRTUAL,
  `Rend prom` NVARCHAR(50) NOT NULL,
  `Riesgo%` NVARCHAR(50) NOT NULL,
  `Var rend` NVARCHAR(50) NOT NULL,
  `Max Var` NVARCHAR(50) NOT NULL,
  `Min Var` NVARCHAR(50) NOT NULL,
  `Idproducto` INT NOT NULL,
  PRIMARY KEY (`Id Riesgo Rendimientos`),
  UNIQUE INDEX `Id Riesgo Rendimientos_UNIQUE` (`Id Riesgo Rendimientos` ASC) VISIBLE,
  INDEX `Idproducto_idx` (`Idproducto` ASC) VISIBLE,
  CONSTRAINT `Idproducto`
    FOREIGN KEY (`Idproducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Personas` (
  `idPersonas` INT GENERATED ALWAYS AS () VIRTUAL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Edad` VARCHAR(45) NOT NULL,
  `Dni` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idPersonas`),
  UNIQUE INDEX `idPersonas_UNIQUE` (`idPersonas` ASC) VISIBLE,
  UNIQUE INDEX `Dni_UNIQUE` (`Dni` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Requerimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Requerimientos` (
  `idRequerimientos` INT GENERATED ALWAYS AS () VIRTUAL,
  `Apertura minima` VARCHAR(45) NULL,
  `Contrato` LONGTEXT NOT NULL,
  `Prescripcion inicial` LONGTEXT NOT NULL,
  `Permanencia minima` VARCHAR(45) NOT NULL,
  `IdProducto` INT NOT NULL,
  `IdEntidades` INT NOT NULL,
  PRIMARY KEY (`idRequerimientos`),
  UNIQUE INDEX `idRequerimientos_UNIQUE` (`idRequerimientos` ASC) VISIBLE,
  UNIQUE INDEX `IdProducto_UNIQUE` (`IdProducto` ASC) VISIBLE,
  INDEX `idEntidades_idx` (`IdEntidades` ASC) VISIBLE,
  CONSTRAINT `idProducto`
    FOREIGN KEY (`IdProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idEntidades`
    FOREIGN KEY (`IdEntidades`)
    REFERENCES `mydb`.`Entidades` (`idEntidades`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Costos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Costos` (
  `idCostos` INT GENERATED ALWAYS AS () VIRTUAL,
  `Costomantenimiento` VARCHAR(45) NOT NULL,
  `Costosuscripcion` VARCHAR(45) NOT NULL,
  `Rescate antcipado` VARCHAR(45) NOT NULL,
  `Costo sin rescate` VARCHAR(45) NOT NULL,
  `IdCuota` INT NOT NULL,
  PRIMARY KEY (`idCostos`),
  UNIQUE INDEX `idCostos_UNIQUE` (`idCostos` ASC) VISIBLE,
  UNIQUE INDEX `IdCuota_UNIQUE` (`IdCuota` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Contacto`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Contacto` (
  `idContacto` INT GENERATED ALWAYS AS () VIRTUAL,
  `idEntidades` INT NOT NULL,
  `Numero-Mail` VARCHAR(45) NOT NULL,
  `Horario de antencion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idContacto`),
  UNIQUE INDEX `idContacto_UNIQUE` (`idContacto` ASC) VISIBLE,
  INDEX `idEntidades_idx` (`idEntidades` ASC) VISIBLE,
  UNIQUE INDEX `Numero-Mail_UNIQUE` (`Numero-Mail` ASC) VISIBLE,
  CONSTRAINT `idEntidades`
    FOREIGN KEY (`idEntidades`)
    REFERENCES `mydb`.`Entidades` (`idEntidades`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Inversiones Primarias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Inversiones Primarias` (
  `idInversiones Primarias` INT GENERATED ALWAYS AS () VIRTUAL,
  `Nombre` VARCHAR(45) NOT NULL,
  `Origen` VARCHAR(45) NOT NULL,
  `Tipo` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idInversiones Primarias`),
  UNIQUE INDEX `idInversiones Primarias_UNIQUE` (`idInversiones Primarias` ASC) VISIBLE,
  UNIQUE INDEX `Nombre_UNIQUE` (`Nombre` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pesos Region`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pesos Region` (
  `idPesos Region` INT GENERATED ALWAYS AS () VIRTUAL,
  `IdProducto` INT NOT NULL,
  `IdInversiones Primarias` INT NOT NULL,
  `Pesos` DECIMAL NOT NULL,
  PRIMARY KEY (`idPesos Region`),
  UNIQUE INDEX `idPesos Region_UNIQUE` (`idPesos Region` ASC) VISIBLE,
  INDEX `IdProducto_idx` (`IdProducto` ASC) VISIBLE,
  INDEX `IdInversiones Primarias_idx` (`IdInversiones Primarias` ASC) VISIBLE,
  CONSTRAINT `IdProducto`
    FOREIGN KEY (`IdProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IdInversiones Primarias`
    FOREIGN KEY (`IdInversiones Primarias`)
    REFERENCES `mydb`.`Inversiones Primarias` (`idInversiones Primarias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Pesos Tipo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Pesos Tipo` (
  `idPesos Tipo` INT GENERATED ALWAYS AS () VIRTUAL,
  `IdProducto` INT NOT NULL,
  `idInversiones Primarias` INT NOT NULL,
  `Pesos` DECIMAL NOT NULL,
  PRIMARY KEY (`idPesos Tipo`),
  UNIQUE INDEX `idPesos Tipo_UNIQUE` (`idPesos Tipo` ASC) VISIBLE,
  INDEX `idInversiones Primaria_idx` (`idInversiones Primarias` ASC) VISIBLE,
  INDEX `IdProducto_idx` (`IdProducto` ASC) VISIBLE,
  CONSTRAINT `idInversiones Primaria`
    FOREIGN KEY (`idInversiones Primarias`)
    REFERENCES `mydb`.`Inversiones Primarias` (`idInversiones Primarias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IdProducto`
    FOREIGN KEY (`IdProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Cuotas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Cuotas` (
  `idCuotas` INT GENERATED ALWAYS AS () VIRTUAL,
  `Valor cuota` DOUBLE NOT NULL,
  `Fecha actualizacion` DATE NOT NULL,
  `IdProducto` INT NOT NULL,
  PRIMARY KEY (`idCuotas`),
  UNIQUE INDEX `idCuotas_UNIQUE` (`idCuotas` ASC) VISIBLE,
  UNIQUE INDEX `IdProducto_UNIQUE` (`IdProducto` ASC) VISIBLE,
  CONSTRAINT `IdProducto`
    FOREIGN KEY (`IdProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`TC`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`TC` (
  `idTC` INT GENERATED ALWAYS AS () VIRTUAL,
  `Tc` DOUBLE NOT NULL,
  `Fecha del TC` DATE NOT NULL,
  PRIMARY KEY (`idTC`),
  UNIQUE INDEX `idTC_UNIQUE` (`idTC` ASC) VISIBLE,
  UNIQUE INDEX `Fecha del TC_UNIQUE` (`Fecha del TC` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Costoxpersona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Costoxpersona` (
  `idCostoxpersona` INT GENERATED ALWAYS AS () VIRTUAL,
  `Costo total sin retiro` NVARCHAR(50) NOT NULL,
  `Costo de rescates hechos` NVARCHAR(50) NOT NULL,
  `Idcostos` INT NOT NULL,
  PRIMARY KEY (`idCostoxpersona`),
  UNIQUE INDEX `idCuotaxpersona_UNIQUE` (`idCostoxpersona` ASC) VISIBLE,
  INDEX `idcostos_idx` (`Idcostos` ASC) VISIBLE,
  CONSTRAINT `idcostos`
    FOREIGN KEY (`Idcostos`)
    REFERENCES `mydb`.`Costos` (`idCostos`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`RendimientoPersonal`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`RendimientoPersonal` (
  `idRendimientoPersonal` INT GENERATED ALWAYS AS () VIRTUAL,
  `Covarianza productos` NVARCHAR(50) NOT NULL,
  `Riesgo Promedio` NVARCHAR(50) NOT NULL,
  `InversionTotal` NVARCHAR(50) NOT NULL,
  `Costo total personal` NVARCHAR(50) NOT NULL,
  `Id costoxpersona` INT NOT NULL,
  PRIMARY KEY (`idRendimientoPersonal`),
  UNIQUE INDEX `idRendimientoPersonal_UNIQUE` (`idRendimientoPersonal` ASC) VISIBLE,
  INDEX `id costoxpersona_idx` (`Id costoxpersona` ASC) VISIBLE,
  CONSTRAINT `id costoxpersona`
    FOREIGN KEY (`Id costoxpersona`)
    REFERENCES `mydb`.`Costoxpersona` (`idCostoxpersona`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`Historial`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`Historial` (
  `idHistorial` INT GENERATED ALWAYS AS () VIRTUAL,
  `Idpersonas` INT NOT NULL,
  `IdProducto` INT NOT NULL,
  `IdpersonaXproducto` INT NOT NULL,
  `Cambio por tc` NVARCHAR(50) NULL,
  `Cantidad de cuotas` NVARCHAR(50) NOT NULL,
  `Idcuotas` INT NOT NULL,
  PRIMARY KEY (`idHistorial`),
  UNIQUE INDEX `idHistorial_UNIQUE` (`idHistorial` ASC) INVISIBLE,
  UNIQUE INDEX `IdpersonaXproducto_UNIQUE` (`IdpersonaXproducto` ASC) VISIBLE,
  INDEX `idcuotas_idx` (`Idcuotas` ASC) VISIBLE,
  INDEX `Idproducto_idx` (`IdProducto` ASC) VISIBLE,
  INDEX `idPersonas_idx` (`Idpersonas` ASC) VISIBLE,
  CONSTRAINT `idcuotas`
    FOREIGN KEY (`Idcuotas`)
    REFERENCES `mydb`.`Cuotas` (`idCuotas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `Idproducto`
    FOREIGN KEY (`IdProducto`)
    REFERENCES `mydb`.`Producto` (`idProducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `idPersonas`
    FOREIGN KEY (`Idpersonas`)
    REFERENCES `mydb`.`Personas` (`idPersonas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`CuotasxPersona`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`CuotasxPersona` (
  `idCuotasxPersona` INT GENERATED ALWAYS AS () VIRTUAL,
  `Numero de cuotas` DOUBLE NOT NULL,
  `IdpersonaXProductos` INT NOT NULL,
  `Idpersonas` INT NOT NULL,
  PRIMARY KEY (`idCuotasxPersona`),
  UNIQUE INDEX `idCuotasxPersona_UNIQUE` (`idCuotasxPersona` ASC) VISIBLE,
  UNIQUE INDEX `IdpersonaProducto_UNIQUE` (`IdpersonaXProductos` ASC) VISIBLE,
  INDEX `Idpersonas_idx` (`Idpersonas` ASC) VISIBLE,
  CONSTRAINT `Idpersonas`
    FOREIGN KEY (`Idpersonas`)
    REFERENCES `mydb`.`Personas` (`idPersonas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `IdPersonaxProducto`
    FOREIGN KEY (`IdpersonaXProductos`)
    REFERENCES `mydb`.`Historial` (`IdpersonaXproducto`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
