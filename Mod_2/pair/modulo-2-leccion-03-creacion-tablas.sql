-- p-modulo-2-leccion-05-creacion-tablas

CREATE SCHEMA IF NOT EXISTS `tienda_zapatillas` DEFAULT CHARACTER SET utf8 ;
USE `tienda_zapatillas`;

-- Tabla  Zapatillas
CREATE TABLE IF NOT EXISTS `tienda_zapatillas`.`Zapatillas` (
  `idZapatillas` INT NOT NULL AUTO_INCREMENT,
  `Modelo` VARCHAR(45) NOT NULL,
  `Year` VARCHAR(45) NOT NULL,
  `Color` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idZapatillas`))
ENGINE = InnoDB;

-- Tabla Empleados
CREATE TABLE IF NOT EXISTS `tienda_zapatillas`.`Empleados` (
  `idEmpleado` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Tienda` VARCHAR(45) NOT NULL,
  `Salario` int, 
  `Fecha_incorporacion` date NOT NULL,  
  PRIMARY KEY (`idEmpleado`))
ENGINE = InnoDB;


-- Tabla Clientes

CREATE TABLE IF NOT EXISTS `tienda_zapatillas`.`Clientes` (
  `idCliente` INT NOT NULL AUTO_INCREMENT,
  `Nombre` VARCHAR(45) NOT NULL,
  `Numero_Telf` int(9) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  `Direccion` VARCHAR(45) NOT NULL,
  `Ciudad` VARCHAR(45) NOT NULL,
  `Provincia` VARCHAR(45) NOT NULL,
  `Pais` VARCHAR(45) NOT NULL,
  `Código_Postal` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idCliente`))
ENGINE = InnoDB;


-- Tabla Facturas

CREATE TABLE IF NOT EXISTS `tienda_zapatillas`.`Factura` (
  `idFactura` INT NOT NULL AUTO_INCREMENT,
  `Numero_Factura` VARCHAR(45) NOT NULL,
  `Fecha` date NOT NULL,
  `idZapatillas` INT NOT NULL,
  `idEmpleado` INT NOT NULL,
  `idCliente` INT NOT NULL,
  PRIMARY KEY (`idFactura`, `idZapatillas`, `idEmpleado`, `idCliente`),
  INDEX `fk_Factura_Clientes1_idx` (`idCliente` ASC) ,
  INDEX `fk_Factura_Zapatillas1_idx` (`idZapatillas` ASC) ,
  INDEX `fk_Factura_Empleados1_idx` (`idEmpleado` ASC) ,
  CONSTRAINT `fk_Factura_Clientes1`
    FOREIGN KEY (`idCliente`)
    REFERENCES `tienda_zapatillas`.`Clientes` (`idCliente`),
  CONSTRAINT `fk_Factura_Zapatillas1`
    FOREIGN KEY (`idZapatillas`)
    REFERENCES `tienda_zapatillas`.`Zapatillas` (`idZapatillas`),
  CONSTRAINT `fk_Factura_Empleados1`
    FOREIGN KEY (`idEmpleado`)
    REFERENCES `tienda_zapatillas`.`Empleados` (`idEmpleado`))
ENGINE = InnoDB;