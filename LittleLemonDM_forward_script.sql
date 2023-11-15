-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db-capstone-project
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db-capstone-project
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db-capstone-project` DEFAULT CHARACTER SET utf8 ;
USE `db-capstone-project` ;

-- -----------------------------------------------------
-- Table `db-capstone-project`.`Country`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db-capstone-project`.`Country` ;

CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Country` (
  `Country` VARCHAR(255) NOT NULL,
  `CountryCode` VARCHAR(2) NOT NULL,
  PRIMARY KEY (`Country`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`Address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db-capstone-project`.`Address` ;

CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Address` (
  `AddressID` INT NOT NULL AUTO_INCREMENT,
  `Country` VARCHAR(255) NOT NULL,
  `City` VARCHAR(255) NOT NULL,
  `PostalCode` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`AddressID`),
  INDEX `country_fk_idx` (`Country` ASC) VISIBLE,
  CONSTRAINT `country_fk`
    FOREIGN KEY (`Country`)
    REFERENCES `db-capstone-project`.`Country` (`Country`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`Customers`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db-capstone-project`.`Customers` ;

CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Customers` (
  `CustomerID` VARCHAR(255) NOT NULL,
  `CustomerName` VARCHAR(255) NOT NULL,
  `AddressID` INT NOT NULL,
  `ContactNumber` INT NOT NULL,
  `Email` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`CustomerID`),
  INDEX `contactdetails_id_fk_idx` (`AddressID` ASC) VISIBLE,
  CONSTRAINT `address_id_fk`
    FOREIGN KEY (`AddressID`)
    REFERENCES `db-capstone-project`.`Address` (`AddressID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`Bookings`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db-capstone-project`.`Bookings` ;

CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Bookings` (
  `BookingID` INT NOT NULL AUTO_INCREMENT,
  `BookingDate` DATE NOT NULL,
  `TableNo` INT NOT NULL,
  `CustomerID` VARCHAR(255) NOT NULL,
  `BookingSlot` DATETIME NOT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `customer_id_fk_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `customer_id_fk`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `db-capstone-project`.`Customers` (`CustomerID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`MenuItems`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db-capstone-project`.`MenuItems` ;

CREATE TABLE IF NOT EXISTS `db-capstone-project`.`MenuItems` (
  `MenuItemID` INT NOT NULL AUTO_INCREMENT,
  `Starter` VARCHAR(255) NOT NULL,
  `CourseName` VARCHAR(255) NOT NULL,
  `Dessert` VARCHAR(255) NOT NULL,
  `Drink` VARCHAR(255) NOT NULL,
  `Side` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`MenuItemID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`Menu`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db-capstone-project`.`Menu` ;

CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Menu` (
  `MenuID` INT NOT NULL AUTO_INCREMENT,
  `Cuisine` VARCHAR(255) NOT NULL,
  `MenuItemID` INT NOT NULL,
  `Cost` DECIMAL NOT NULL,
  PRIMARY KEY (`MenuID`),
  INDEX `menuitem_id_fk_idx` (`MenuItemID` ASC) VISIBLE,
  CONSTRAINT `menuitem_id_fk`
    FOREIGN KEY (`MenuItemID`)
    REFERENCES `db-capstone-project`.`MenuItems` (`MenuItemID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`Status`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db-capstone-project`.`Status` ;

CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Status` (
  `StatusID` INT NOT NULL AUTO_INCREMENT,
  `DeliveryDate` DATE NOT NULL,
  `Status` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`StatusID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`Staff`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db-capstone-project`.`Staff` ;

CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Staff` (
  `StaffID` INT NOT NULL AUTO_INCREMENT,
  `Role` VARCHAR(255) NOT NULL,
  `Salary` DECIMAL NOT NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db-capstone-project`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `db-capstone-project`.`Orders` ;

CREATE TABLE IF NOT EXISTS `db-capstone-project`.`Orders` (
  `OrderID` VARCHAR(255) NOT NULL,
  `OrderDate` DATE NOT NULL,
  `Quantity` INT NOT NULL,
  `Sales` DECIMAL NOT NULL,
  `Discount` DECIMAL NOT NULL,
  `MenuID` INT NOT NULL,
  `StatusID` INT NOT NULL,
  `StaffID` INT NOT NULL,
  `BookingID` INT NOT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `menu_id_fk_idx` (`MenuID` ASC) VISIBLE,
  INDEX `status_id_fk_idx` (`StatusID` ASC) VISIBLE,
  INDEX `staff_id_fk_idx` (`StaffID` ASC) VISIBLE,
  INDEX `booking_id_fk_idx` (`BookingID` ASC) VISIBLE,
  CONSTRAINT `menu_id_fk`
    FOREIGN KEY (`MenuID`)
    REFERENCES `db-capstone-project`.`Menu` (`MenuID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `status_id_fk`
    FOREIGN KEY (`StatusID`)
    REFERENCES `db-capstone-project`.`Status` (`StatusID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `staff_id_fk`
    FOREIGN KEY (`StaffID`)
    REFERENCES `db-capstone-project`.`Staff` (`StaffID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `booking_id_fk`
    FOREIGN KEY (`BookingID`)
    REFERENCES `db-capstone-project`.`Bookings` (`BookingID`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
