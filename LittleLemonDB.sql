-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema littlelemondb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `littlelemondb` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `littlelemondb` ;

-- -----------------------------------------------------
-- Table `littlelemondb`.`customerdetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`customerdetails` (
  `CustomerID` INT NOT NULL,
  `FirstName` VARCHAR(45) NOT NULL,
  `LastName` VARCHAR(45) NOT NULL,
  `Phone Number` VARCHAR(45) NOT NULL,
  `Email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`CustomerID`),
  UNIQUE INDEX `Phone Number_UNIQUE` (`Phone Number` ASC) VISIBLE,
  UNIQUE INDEX `Email_UNIQUE` (`Email` ASC) VISIBLE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondb`.`bookings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`bookings` (
  `BookingID` INT NOT NULL,
  `ReservationDT` DATETIME NOT NULL,
  `AssignedTable` VARCHAR(45) NOT NULL,
  `CustomerID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`BookingID`),
  INDEX `FK_CustomerID_idx` (`CustomerID` ASC) VISIBLE,
  CONSTRAINT `FK_CustomerID`
    FOREIGN KEY (`CustomerID`)
    REFERENCES `littlelemondb`.`customerdetails` (`CustomerID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondb`.`staffdetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`staffdetails` (
  `StaffID` INT NOT NULL,
  `FirstName` VARCHAR(45) NULL,
  `LastName` VARCHAR(45) NULL,
  `Role` VARCHAR(45) NOT NULL,
  `Salary` DECIMAL(10,0) NOT NULL,
  PRIMARY KEY (`StaffID`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondb`.`menus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`menus` (
  `MenuID` INT NOT NULL,
  `MenuName` VARCHAR(45) NULL,
  PRIMARY KEY (`MenuID`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `littlelemondb`.`orders`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`orders` (
  `OrderID` INT NOT NULL,
  `OrderDate` DATE NOT NULL,
  `OrderItems` VARCHAR(255) NULL DEFAULT NULL,
  `OrderCost` DECIMAL(10,0) NULL DEFAULT NULL,
  `BookingID` INT NULL DEFAULT NULL,
  `StaffID` INT NULL DEFAULT NULL,
  `ItemQuantity` INT NULL DEFAULT NULL,
  `MenuID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`OrderID`),
  INDEX `FK_BookingID_idx` (`BookingID` ASC) VISIBLE,
  INDEX `FK_StaffID_idx` (`StaffID` ASC) VISIBLE,
  INDEX `FK_MenuID_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `FK_BookingID`
    FOREIGN KEY (`BookingID`)
    REFERENCES `littlelemondb`.`bookings` (`BookingID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_StaffID`
    FOREIGN KEY (`StaffID`)
    REFERENCES `littlelemondb`.`staffdetails` (`StaffID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `FK_MenuID2`
    FOREIGN KEY (`MenuID`)
    REFERENCES `littlelemondb`.`menus` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondb`.`orderstatus`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`orderstatus` (
  `FulfillmentStatus` VARCHAR(45) NOT NULL,
  `CompletionTime` DATETIME NULL DEFAULT NULL,
  `OrderID` INT NULL DEFAULT NULL,
  PRIMARY KEY (`FulfillmentStatus`),
  INDEX `FK_OrderID_idx` (`OrderID` ASC) VISIBLE,
  CONSTRAINT `FK_OrderID`
    FOREIGN KEY (`OrderID`)
    REFERENCES `littlelemondb`.`orders` (`OrderID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `littlelemondb`.`menuitems`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `littlelemondb`.`menuitems` (
  `MenuItemID` INT NOT NULL,
  `ItemName` VARCHAR(45) NULL,
  `MenuID` INT NULL,
  `SubCategory` VARCHAR(45) NULL,
  `RegionID` VARCHAR(45) NULL,
  `ItemPrice` DECIMAL NULL,
  PRIMARY KEY (`MenuItemID`),
  INDEX `FK_MenuID_idx` (`MenuID` ASC) VISIBLE,
  CONSTRAINT `FK_MenuID`
    FOREIGN KEY (`MenuID`)
    REFERENCES `littlelemondb`.`menus` (`MenuID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
