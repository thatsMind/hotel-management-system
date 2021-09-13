-- MySQL Script generated by MySQL Workbench
-- Thu Jul 16 13:45:42 2020
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

-- SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
-- SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
-- SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- CREATE DATABASE IF NOT EXISTS hotelmanagementdb;
CREATE DATABASE hotelmanagementdb;
USE hotelmanagementdb;
-- -----------------------------------------------------
-- Table `employee`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `employee` ;

CREATE TABLE IF NOT EXISTS `employee` (
  `employee_id` TINYINT(1) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `ssn` VARCHAR(45) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`employee_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `ssn_UNIQUE` (`ssn` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `accountType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accountType` ;

CREATE TABLE IF NOT EXISTS `accountType` (
  `account_type_id` TINYINT(1) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`account_type_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `guest`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `guest` ;

CREATE TABLE IF NOT EXISTS `guest` (
  `guest_id` TINYINT(1) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `post_code` VARCHAR(45) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`guest_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE,
  UNIQUE INDEX `phone_UNIQUE` (`phone` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `account`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `account` ;

CREATE TABLE IF NOT EXISTS `account` (
  `account_id` TINYINT(1) NOT NULL,
  `employee` TINYINT(1) NOT NULL,
  `type` TINYINT(1) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  `created` DATETIME NOT NULL,
  `guest` TINYINT(1) NOT NULL,
  PRIMARY KEY (`account_id`),
  INDEX `employee_idx` (`employee` ASC) VISIBLE,
  INDEX `type_idx` (`type` ASC) VISIBLE,
  INDEX `fk_account_guest_idx` (`guest` ASC) VISIBLE,
  CONSTRAINT `fk_account_employee`
    FOREIGN KEY (`employee`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_account_accountType`
    FOREIGN KEY (`type`)
    REFERENCES `accountType` (`account_type_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_account_guest`
    FOREIGN KEY (`guest`)
    REFERENCES `guest` (`guest_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `databaseSystem`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `databaseSystem` ;

CREATE TABLE IF NOT EXISTS `databaseSystem` (
  `database_id` TINYINT(1) NOT NULL,
  `guest` TINYINT(1) NOT NULL,
  `created` DATETIME NOT NULL,
  `account` TINYINT(1) NOT NULL,
  PRIMARY KEY (`database_id`),
  INDEX `fl_database_guest_idx` (`guest` ASC) VISIBLE,
  INDEX `fk_database_account_idx` (`account` ASC) VISIBLE,
  CONSTRAINT `fk_database_account`
    FOREIGN KEY (`account`)
    REFERENCES `account` (`account_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fl_database_guest`
    FOREIGN KEY (`guest`)
    REFERENCES `guest` (`guest_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `owner`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `owner` ;

CREATE TABLE IF NOT EXISTS `owner` (
  `owner_id` TINYINT(1) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`owner_id`),
  UNIQUE INDEX `email_UNIQUE` (`email` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hourlyWage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hourlyWage` ;

CREATE TABLE IF NOT EXISTS `hourlyWage` (
  `employee` TINYINT(1) NOT NULL,
  `money` INT NOT NULL,
  INDEX `fk_hourlyWage_employee_idx` (`employee` ASC) VISIBLE,
  PRIMARY KEY (`employee`),
  CONSTRAINT `fk_hourlyWage_employee`
    FOREIGN KEY (`employee`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clothe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clothe` ;

CREATE TABLE IF NOT EXISTS `clothe` (
  `clothe_id` TINYINT(1) NOT NULL,
  `clotheName` VARCHAR(45) NOT NULL,
  `size` VARCHAR(45) NOT NULL,
  `price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`clothe_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roomServicePorter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `roomServicePorter` ;

CREATE TABLE IF NOT EXISTS `roomServicePorter` (
  `roomServicePorter_id` TINYINT(1) NOT NULL,
  `employee` TINYINT(1) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`roomServicePorter_id`),
  INDEX `fk_roomServicePorter_employee_idx` (`employee` ASC) VISIBLE,
  CONSTRAINT `fk_roomServicePorter_employee`
    FOREIGN KEY (`employee`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hotelType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hotelType` ;

CREATE TABLE IF NOT EXISTS `hotelType` (
  `hotelType_id` TINYINT(1) NOT NULL,
  `hotel_type_name` VARCHAR(100) NOT NULL,
  `num_room` INT NOT NULL,
  PRIMARY KEY (`hotelType_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `lounge`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `lounge` ;

CREATE TABLE IF NOT EXISTS `lounge` (
  `lounge_id` TINYINT(1) NOT NULL,
  `loungeName` VARCHAR(45) NOT NULL,
  `rating` TINYINT(1) NOT NULL,
  PRIMARY KEY (`lounge_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hairSaloon`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hairSaloon` ;

CREATE TABLE IF NOT EXISTS `hairSaloon` (
  `hairSaloon_id` TINYINT(1) NOT NULL,
  `hairSaloonName` VARCHAR(45) NOT NULL,
  `rating` TINYINT(1) NOT NULL,
  PRIMARY KEY (`hairSaloon_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `clothingStore`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `clothingStore` ;

CREATE TABLE IF NOT EXISTS `clothingStore` (
  `clothingStore_id` TINYINT(1) NOT NULL,
  `store_brand_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`clothingStore_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `feature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `feature` ;

CREATE TABLE IF NOT EXISTS `feature` (
  `feature_id` TINYINT(1) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`feature_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `feedback`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `feedback` ;

CREATE TABLE IF NOT EXISTS `feedback` (
  `feedback_id` TINYINT(1) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  `rating` TINYINT(1) NOT NULL,
  PRIMARY KEY (`feedback_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roomCategory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `roomCategory` ;

CREATE TABLE IF NOT EXISTS `roomCategory` (
  `roomCategory_id` TINYINT(1) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `hotel` TINYINT(1) NOT NULL,
  `guest` TINYINT(1) NOT NULL,
  PRIMARY KEY (`roomCategory_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `room`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `room` ;

CREATE TABLE IF NOT EXISTS `room` (
  `room_id` TINYINT(1) NOT NULL,
  `to_date` DATETIME NOT NULL,
  `from_date` DATETIME NOT NULL,
  `roomCategory` TINYINT(1) NOT NULL,
  `guest` TINYINT(1) NOT NULL,
  PRIMARY KEY (`room_id`),
  INDEX `fk_room_roomCategory_idx` (`roomCategory` ASC) VISIBLE,
  INDEX `fk_room_guest_idx` (`guest` ASC) VISIBLE,
  CONSTRAINT `fk_room_roomCategory`
    FOREIGN KEY (`roomCategory`)
    REFERENCES `roomCategory` (`roomCategory_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_room_guest`
    FOREIGN KEY (`guest`)
    REFERENCES `guest` (`guest_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `deliveryService`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `deliveryService` ;

CREATE TABLE IF NOT EXISTS `deliveryService` (
  `deliveryService_id` TINYINT(1) NOT NULL,
  `deliveryServiceName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`deliveryService_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `meal`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meal` ;

CREATE TABLE IF NOT EXISTS `meal` (
  `meal_id` TINYINT(1) NOT NULL,
  `mealName` VARCHAR(45) NOT NULL,
  `price` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`meal_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodOrder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodOrder` ;

CREATE TABLE IF NOT EXISTS `foodOrder` (
  `foodOrder_id` TINYINT(1) NOT NULL,
  `order_date` DATETIME NOT NULL,
  `meal` TINYINT(1) NOT NULL,
  `DeliveryService` TINYINT(1) NOT NULL,
  PRIMARY KEY (`foodOrder_id`),
  INDEX `fk_foodOrder_meal_idx` (`meal` ASC) VISIBLE,
  INDEX `fk_foodOrder_deliveryService_idx` (`DeliveryService` ASC) VISIBLE,
  CONSTRAINT `fk_foodOrder_meal`
    FOREIGN KEY (`meal`)
    REFERENCES `meal` (`meal_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_foodOrder_deliveryService`
    FOREIGN KEY (`DeliveryService`)
    REFERENCES `deliveryService` (`deliveryService_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `laundryOrder`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `laundryOrder` ;

CREATE TABLE IF NOT EXISTS `laundryOrder` (
  `laundryOrder_id` TINYINT(1) NOT NULL,
  `order_date` DATETIME NOT NULL,
  `clothe` TINYINT(1) NOT NULL,
  `deliveryService` TINYINT(1) NOT NULL,
  PRIMARY KEY (`laundryOrder_id`),
  INDEX `fk_laundryOrder_clothe_idx` (`clothe` ASC) VISIBLE,
  INDEX `fk_laundryOrder_deliveryService_idx` (`deliveryService` ASC) VISIBLE,
  CONSTRAINT `fk_laundryOrder_clothe`
    FOREIGN KEY (`clothe`)
    REFERENCES `clothe` (`clothe_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_laundryOrder_deliveryService`
    FOREIGN KEY (`deliveryService`)
    REFERENCES `deliveryService` (`deliveryService_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `invoice`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `invoice` ;

CREATE TABLE IF NOT EXISTS `invoice` (
  `invoice_id` TINYINT(1) NOT NULL,
  `status` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`invoice_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `billingInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `billingInfo` ;

CREATE TABLE IF NOT EXISTS `billingInfo` (
  `billingInfo_id` TINYINT(1) NOT NULL,
  `invoice` TINYINT(1) NOT NULL,
  `deliveryService` TINYINT(1) NOT NULL,
  `guest` TINYINT(1) NOT NULL,
  `amount` DECIMAL(6,2) NOT NULL,
  PRIMARY KEY (`billingInfo_id`),
  INDEX `fk_billingInfo_invoice_idx` (`invoice` ASC) VISIBLE,
  INDEX `fk_billingInfo_deliveryService_idx` (`deliveryService` ASC) VISIBLE,
  INDEX `fk_billingInfo_guest_idx` (`guest` ASC) VISIBLE,
  CONSTRAINT `fk_billingInfo_invoice`
    FOREIGN KEY (`invoice`)
    REFERENCES `invoice` (`invoice_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_billingInfo_deliveryService`
    FOREIGN KEY (`deliveryService`)
    REFERENCES `deliveryService` (`deliveryService_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_billingInfo_guest`
    FOREIGN KEY (`guest`)
    REFERENCES `guest` (`guest_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `paymentType`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `paymentType` ;

CREATE TABLE IF NOT EXISTS `paymentType` (
  `paymentType_id` TINYINT(1) NOT NULL,
  `address` VARCHAR(45) NOT NULL,
  `zip_code` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NOT NULL,
  `state` VARCHAR(45) NOT NULL,
  `city` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`paymentType_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `creditCard`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `creditCard` ;

CREATE TABLE IF NOT EXISTS `creditCard` (
  `payment_type` TINYINT(1) NOT NULL,
  `card_number` VARCHAR(45) NOT NULL,
  `bank` VARCHAR(45) NOT NULL,
  `exp_date` DATETIME NOT NULL,
  `cvv` CHAR(3) NOT NULL,
  PRIMARY KEY (`payment_type`, `card_number`),
  CONSTRAINT `fk_creditcard_paymenttype`
    FOREIGN KEY (`payment_type`)
    REFERENCES `paymentType` (`paymentType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `priceCategory`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `priceCategory` ;

CREATE TABLE IF NOT EXISTS `priceCategory` (
  `priceCategory_id` TINYINT(1) NOT NULL,
  `availableRoom` TINYINT(1) NOT NULL,
  `price` DECIMAL(6,2) NOT NULL,
  `hotel` TINYINT(1) NOT NULL,
  `date` DATETIME NOT NULL,
  PRIMARY KEY (`priceCategory_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `editReservation`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `editReservation` ;

CREATE TABLE IF NOT EXISTS `editReservation` (
  `editReservation_id` TINYINT(1) NOT NULL,
  `room` TINYINT(1) NOT NULL,
  `cancel` TINYINT(1) NOT NULL,
  `date` DATETIME NOT NULL,
  `price` DECIMAL(6,2) NOT NULL,
  `guest` TINYINT(1) NOT NULL,
  PRIMARY KEY (`editReservation_id`),
  INDEX `fk_editReservation_guest_idx` (`guest` ASC) VISIBLE,
  CONSTRAINT `fk_editReservation_priceCategory`
    FOREIGN KEY (`editReservation_id`)
    REFERENCES `priceCategory` (`priceCategory_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_editReservation_guest`
    FOREIGN KEY (`guest`)
    REFERENCES `guest` (`guest_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `chef`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `chef` ;

CREATE TABLE IF NOT EXISTS `chef` (
  `chef_id` TINYINT(1) NOT NULL,
  `employee` TINYINT(1) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  INDEX `fk_chef_employee_idx` (`employee` ASC) VISIBLE,
  PRIMARY KEY (`chef_id`),
  CONSTRAINT `fk_chef_employee`
    FOREIGN KEY (`employee`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `receptionClerk`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `receptionClerk` ;

CREATE TABLE IF NOT EXISTS `receptionClerk` (
  `receptionClerk_id` TINYINT(1) NOT NULL,
  `employee` TINYINT(1) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`receptionClerk_id`),
  INDEX `fk_receptionClerk_employee_idx` (`employee` ASC) VISIBLE,
  CONSTRAINT `fk_receptionClerk_employee`
    FOREIGN KEY (`employee`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `engineer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `engineer` ;

CREATE TABLE IF NOT EXISTS `engineer` (
  `engineer_id` TINYINT(1) NOT NULL,
  `employee` TINYINT(1) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`engineer_id`),
  INDEX `fk_engineer_employee_idx` (`employee` ASC) VISIBLE,
  CONSTRAINT `fk_engineer_employee`
    FOREIGN KEY (`employee`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `housekeeper`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `housekeeper` ;

CREATE TABLE IF NOT EXISTS `housekeeper` (
  `housekeeper_id` TINYINT(1) NOT NULL,
  `employee` TINYINT(1) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`housekeeper_id`),
  INDEX `fk_housekeeper_employee_idx` (`employee` ASC) VISIBLE,
  CONSTRAINT `fk_housekeeper_employee`
    FOREIGN KEY (`employee`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supervisor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supervisor` ;

CREATE TABLE IF NOT EXISTS `supervisor` (
  `supervisor_id` TINYINT(1) NOT NULL,
  `employee` TINYINT(1) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`supervisor_id`),
  INDEX `fk_supervisor_employee_idx` (`employee` ASC) VISIBLE,
  CONSTRAINT `fk_supervisor_employee`
    FOREIGN KEY (`employee`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `manager`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `manager` ;

CREATE TABLE IF NOT EXISTS `manager` (
  `manager_id` TINYINT(1) NOT NULL,
  `employee` TINYINT(1) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`manager_id`),
  INDEX `fk_manager_employee_idx` (`employee` ASC) VISIBLE,
  CONSTRAINT `fk_manager_employee`
    FOREIGN KEY (`employee`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `department`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `department` ;

CREATE TABLE IF NOT EXISTS `department` (
  `department_id` TINYINT(1) NOT NULL,
  `description` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`department_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `roomDivision`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `roomDivision` ;

CREATE TABLE IF NOT EXISTS `roomDivision` (
  `roomDivision_id` TINYINT(1) NOT NULL,
  `department` TINYINT(1) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `budget` INT NOT NULL,
  PRIMARY KEY (`roomDivision_id`),
  INDEX `fk_roomDivision_department_idx` (`department` ASC) VISIBLE,
  CONSTRAINT `fk_roomDivision_department`
    FOREIGN KEY (`department`)
    REFERENCES `department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `salesAndMarketing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `salesAndMarketing` ;

CREATE TABLE IF NOT EXISTS `salesAndMarketing` (
  `salesAndMarketing_id` TINYINT(1) NOT NULL,
  `department` TINYINT(1) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `budget` INT NOT NULL,
  PRIMARY KEY (`salesAndMarketing_id`),
  INDEX `fk_salesAndMarketing_department_idx` (`department` ASC) VISIBLE,
  CONSTRAINT `fk_salesAndMarketing_department`
    FOREIGN KEY (`department`)
    REFERENCES `department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodAndBeverage`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodAndBeverage` ;

CREATE TABLE IF NOT EXISTS `foodAndBeverage` (
  `foodAndBeverage_id` TINYINT(1) NOT NULL,
  `department` TINYINT(1) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `budget` INT NOT NULL,
  PRIMARY KEY (`foodAndBeverage_id`),
  INDEX `fk_foodAndBeverage_department_idx` (`department` ASC) VISIBLE,
  CONSTRAINT `fk_foodAndBeverage_department`
    FOREIGN KEY (`department`)
    REFERENCES `department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `humanResource`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `humanResource` ;

CREATE TABLE IF NOT EXISTS `humanResource` (
  `humanResource_id` TINYINT(1) NOT NULL,
  `department` TINYINT(1) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `budget` INT NOT NULL,
  PRIMARY KEY (`humanResource_id`),
  INDEX `fk_humanResource_department_idx` (`department` ASC) VISIBLE,
  CONSTRAINT `fk_humanResource_department`
    FOREIGN KEY (`department`)
    REFERENCES `department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `engineering`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `engineering` ;

CREATE TABLE IF NOT EXISTS `engineering` (
  `engineering_id` TINYINT(1) NOT NULL,
  `department` TINYINT(1) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `budget` INT NOT NULL,
  PRIMARY KEY (`engineering_id`),
  INDEX `fk_engineering_department_idx` (`department` ASC) VISIBLE,
  CONSTRAINT `fk_engineering_department`
    FOREIGN KEY (`department`)
    REFERENCES `department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `gym`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `gym` ;

CREATE TABLE IF NOT EXISTS `gym` (
  `gym_id` TINYINT(1) NOT NULL,
  `gymName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`gym_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `recreationCenter`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recreationCenter` ;

CREATE TABLE IF NOT EXISTS `recreationCenter` (
  `recreationCenter_id` TINYINT(1) NOT NULL,
  `recreationCenterName` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`recreationCenter_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `pool`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `pool` ;

CREATE TABLE IF NOT EXISTS `pool` (
  `pool_id` TINYINT(1) NOT NULL,
  `num_of_ppl` INT NOT NULL,
  `time_limit` INT NOT NULL,
  PRIMARY KEY (`pool_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tennisCourt`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tennisCourt` ;

CREATE TABLE IF NOT EXISTS `tennisCourt` (
  `tennisCourt_id` TINYINT(1) NOT NULL,
  `tennisCourtName` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`tennisCourt_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supportedFacility`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supportedFacility` ;

CREATE TABLE IF NOT EXISTS `supportedFacility` (
  `supportedFacility_id` TINYINT(1) NOT NULL,
  `hotelType` TINYINT(1) NOT NULL,
  `gym` TINYINT(1) NOT NULL,
  `spa` TINYINT(1) NOT NULL,
  `pool` TINYINT(1) NOT NULL,
  `tennisCourt` TINYINT(1) NOT NULL,
  PRIMARY KEY (`supportedFacility_id`),
  INDEX `fk_supportedFacility_hotelType_idx` (`hotelType` ASC) VISIBLE,
  INDEX `fk_supportedFacility_gym_idx` (`gym` ASC) VISIBLE,
  INDEX `fk_supportedFacility_spa_idx` (`spa` ASC) VISIBLE,
  INDEX `fk_supportedFacility_pool_idx` (`pool` ASC) VISIBLE,
  INDEX `fk_supportedFacility_tennisCourt_idx` (`tennisCourt` ASC) VISIBLE,
  CONSTRAINT `fk_supportedFacility_hotelType`
    FOREIGN KEY (`hotelType`)
    REFERENCES `hotelType` (`hotelType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_supportedFacility_gym`
    FOREIGN KEY (`gym`)
    REFERENCES `gym` (`gym_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_supportedFacility_recreationCenter`
    FOREIGN KEY (`spa`)
    REFERENCES `recreationCenter` (`recreationCenter_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_supportedFacility_pool`
    FOREIGN KEY (`pool`)
    REFERENCES `pool` (`pool_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_supportedFacility_tennisCourt`
    FOREIGN KEY (`tennisCourt`)
    REFERENCES `tennisCourt` (`tennisCourt_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `locale`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `locale` ;

CREATE TABLE IF NOT EXISTS `locale` (
  `locale_id` TINYINT(1) NOT NULL,
  `location_name` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`locale_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tourist`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tourist` ;

CREATE TABLE IF NOT EXISTS `tourist` (
  `tourist_id` TINYINT(1) NOT NULL,
  `touristCountry` VARCHAR(45) NOT NULL,
  `locale` TINYINT(1) NOT NULL,
  PRIMARY KEY (`tourist_id`),
  INDEX `fk_tourist_locale_idx` (`locale` ASC) VISIBLE,
  CONSTRAINT `fk_tourist_locale`
    FOREIGN KEY (`locale`)
    REFERENCES `locale` (`locale_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `restaurant`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `restaurant` ;

CREATE TABLE IF NOT EXISTS `restaurant` (
  `restaurant_id` TINYINT(1) NOT NULL,
  `restaurantName` VARCHAR(45) NOT NULL,
  `rating` TINYINT(1) NOT NULL,
  PRIMARY KEY (`restaurant_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bar`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bar` ;

CREATE TABLE IF NOT EXISTS `bar` (
  `bar_id` TINYINT(1) NOT NULL,
  `barName` VARCHAR(45) NOT NULL,
  `rating` TINYINT(1) NOT NULL,
  PRIMARY KEY (`bar_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `buffet`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `buffet` ;

CREATE TABLE IF NOT EXISTS `buffet` (
  `buffet_id` TINYINT(1) NOT NULL,
  `buffetName` VARCHAR(45) NOT NULL,
  `rating` TINYINT(1) NOT NULL,
  PRIMARY KEY (`buffet_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `foodVendor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `foodVendor` ;

CREATE TABLE IF NOT EXISTS `foodVendor` (
  `foodVendor_id` TINYINT(1) NOT NULL,
  `locale` TINYINT(1) NOT NULL,
  `bar` TINYINT(1) NOT NULL,
  `restaurant` TINYINT(1) NOT NULL,
  `lounge` TINYINT(1) NOT NULL,
  `buffet` TINYINT(1) NOT NULL,
  PRIMARY KEY (`foodVendor_id`),
  INDEX `fk_foodVendor_locale_idx` (`locale` ASC) VISIBLE,
  INDEX `fk_foodVendor_restaurant_idx` (`restaurant` ASC) VISIBLE,
  INDEX `fk_foodVendor_bar_idx` (`bar` ASC) VISIBLE,
  INDEX `fk_foodVendor_lounge_idx` (`lounge` ASC) VISIBLE,
  INDEX `fk_foodVendor_buffet_idx` (`buffet` ASC) VISIBLE,
  CONSTRAINT `fk_foodVendor_locale`
    FOREIGN KEY (`locale`)
    REFERENCES `locale` (`locale_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_foodVendor_restaurant`
    FOREIGN KEY (`restaurant`)
    REFERENCES `restaurant` (`restaurant_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_foodVendor_bar`
    FOREIGN KEY (`bar`)
    REFERENCES `bar` (`bar_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_foodVendor_lounge`
    FOREIGN KEY (`lounge`)
    REFERENCES `lounge` (`lounge_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_foodVendor_buffet`
    FOREIGN KEY (`buffet`)
    REFERENCES `buffet` (`buffet_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `movieTheater`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `movieTheater` ;

CREATE TABLE IF NOT EXISTS `movieTheater` (
  `movieTheater_id` TINYINT(1) NOT NULL,
  `movieTheatername` VARCHAR(45) NOT NULL,
  `num_movie` TINYINT(1) NOT NULL,
  PRIMARY KEY (`movieTheater_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `jewelryStore`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `jewelryStore` ;

CREATE TABLE IF NOT EXISTS `jewelryStore` (
  `jewelryStore_id` TINYINT(1) NOT NULL,
  `jewelryStoreName` VARCHAR(45) NOT NULL,
  `priceRange` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`jewelryStore_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `serviceAndRetailVendor`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `serviceAndRetailVendor` ;

CREATE TABLE IF NOT EXISTS `serviceAndRetailVendor` (
  `serviceAndRetailVendor_id` TINYINT(1) NOT NULL,
  `locale` TINYINT(1) NOT NULL,
  `movieTheater` TINYINT(1) NOT NULL,
  `hairSaloon` TINYINT(1) NOT NULL,
  `clothingStore` TINYINT(1) NOT NULL,
  `jewelryStore` TINYINT(1) NOT NULL,
  PRIMARY KEY (`serviceAndRetailVendor_id`),
  INDEX `fk_serviceAndRetailVendor_locale_idx` (`locale` ASC) VISIBLE,
  INDEX `fk_serviceAndRetailVendor_movieTheater_idx` (`movieTheater` ASC) VISIBLE,
  INDEX `fk_serviceAndRetailVendor_hairSaloon_idx` (`hairSaloon` ASC) VISIBLE,
  INDEX `fk_serviceAndRetailVendor_clothingStore_idx` (`clothingStore` ASC) VISIBLE,
  INDEX `fk_serviceAndRetailVendor_jewelryStore_idx` (`jewelryStore` ASC) VISIBLE,
  CONSTRAINT `fk_serviceAndRetailVendor_locale`
    FOREIGN KEY (`locale`)
    REFERENCES `locale` (`locale_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_serviceAndRetailVendor_movieTheater`
    FOREIGN KEY (`movieTheater`)
    REFERENCES `movieTheater` (`movieTheater_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_serviceAndRetailVendor_hairSaloon`
    FOREIGN KEY (`hairSaloon`)
    REFERENCES `hairSaloon` (`hairSaloon_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_serviceAndRetailVendor_clothingStore`
    FOREIGN KEY (`clothingStore`)
    REFERENCES `clothingStore` (`clothingStore_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_serviceAndRetailVendor_jewelryStore`
    FOREIGN KEY (`jewelryStore`)
    REFERENCES `jewelryStore` (`jewelryStore_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `bankAccount`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `bankAccount` ;

CREATE TABLE IF NOT EXISTS `bankAccount` (
  `payment_type` TINYINT(1) NOT NULL,
  `acc_number` VARCHAR(45) NOT NULL,
  `bank` VARCHAR(45) NOT NULL,
  `routing` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`payment_type`, `acc_number`),
  CONSTRAINT `fk_bankaccount_paymentType`
    FOREIGN KEY (`payment_type`)
    REFERENCES `paymentType` (`paymentType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `invoiceInfo`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `invoiceInfo` ;

CREATE TABLE IF NOT EXISTS `invoiceInfo` (
  `invoiceInfo_id` TINYINT(1) NOT NULL,
  `paymentType` TINYINT(1) NOT NULL,
  `invoice` TINYINT(1) NOT NULL,
  PRIMARY KEY (`invoiceInfo_id`),
  INDEX `fk_invoiceInfo_paymentType_idx` (`paymentType` ASC) VISIBLE,
  INDEX `fk_invoiceInfo_invoice_idx` (`invoice` ASC) VISIBLE,
  CONSTRAINT `fk_invoiceInfo_paymentType`
    FOREIGN KEY (`paymentType`)
    REFERENCES `paymentType` (`paymentType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_invoiceInfo_invoice`
    FOREIGN KEY (`invoice`)
    REFERENCES `invoice` (`invoice_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `supportedFeature`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `supportedFeature` ;

CREATE TABLE IF NOT EXISTS `supportedFeature` (
  `supportedFeature_id` TINYINT(1) NOT NULL,
  `account_type` TINYINT(1) NOT NULL,
  `feature` TINYINT(1) NOT NULL,
  `feedback` TINYINT(1) NOT NULL,
  PRIMARY KEY (`supportedFeature_id`),
  INDEX `fk_supportedFeature_accountType_idx` (`account_type` ASC) VISIBLE,
  INDEX `fk_supportedFeature_feature_idx` (`feature` ASC) VISIBLE,
  INDEX `fk_supportedFeature_feedback_idx` (`feedback` ASC) VISIBLE,
  CONSTRAINT `fk_supportedFeature_feature`
    FOREIGN KEY (`feature`)
    REFERENCES `feature` (`feature_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_supportedFeature_accountType`
    FOREIGN KEY (`account_type`)
    REFERENCES `accountType` (`account_type_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_supportedFeature_feedback`
    FOREIGN KEY (`feedback`)
    REFERENCES `feedback` (`feedback_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `registerListing`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `registerListing` ;

CREATE TABLE IF NOT EXISTS `registerListing` (
  `employee` TINYINT(1) NOT NULL,
  `owner` TINYINT(1) NOT NULL,
  INDEX `fk_registerListing_employee_idx` (`employee` ASC) VISIBLE,
  INDEX `fk_registerListingt_owner_idx` (`owner` ASC) VISIBLE,
  PRIMARY KEY (`employee`),
  CONSTRAINT `fk_registerListing_employee`
    FOREIGN KEY (`employee`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_registerListingt_owner`
    FOREIGN KEY (`owner`)
    REFERENCES `owner` (`owner_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hoursWorked`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hoursWorked` ;

CREATE TABLE IF NOT EXISTS `hoursWorked` (
  `employee` TINYINT(1) NOT NULL,
  `money` INT NOT NULL,
  PRIMARY KEY (`employee`),
  INDEX `fk_hourlyWorked_employee_idx` (`employee` ASC) VISIBLE,
  CONSTRAINT `fk_hourlyWorked_employee`
    FOREIGN KEY (`employee`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `establishment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `establishment` ;

CREATE TABLE IF NOT EXISTS `establishment` (
  `establishment_id` TINYINT(1) NOT NULL,
  `employee` TINYINT(1) NOT NULL,
  `hotelType` TINYINT(1) NOT NULL,
  `department` TINYINT(1) NOT NULL,
  PRIMARY KEY (`establishment_id`),
  INDEX `fk_establishment_employee_idx` (`employee` ASC) VISIBLE,
  INDEX `fk_establishment_department_idx` (`department` ASC) VISIBLE,
  INDEX `fk_establishment_hotelType_idx` (`hotelType` ASC) VISIBLE,
  CONSTRAINT `fk_establishment_employee`
    FOREIGN KEY (`employee`)
    REFERENCES `employee` (`employee_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_establishment_hotelType`
    FOREIGN KEY (`hotelType`)
    REFERENCES `hotelType` (`hotelType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_establishment_department`
    FOREIGN KEY (`department`)
    REFERENCES `department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `accounting`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `accounting` ;

CREATE TABLE IF NOT EXISTS `accounting` (
  `accounting_id` TINYINT(1) NOT NULL,
  `department` TINYINT(1) NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `budget` INT NOT NULL,
  PRIMARY KEY (`accounting_id`),
  INDEX `fk_accounting_department_idx` (`department` ASC) VISIBLE,
  CONSTRAINT `fk_accounting_department`
    FOREIGN KEY (`department`)
    REFERENCES `department` (`department_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `location`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `location` ;

CREATE TABLE IF NOT EXISTS `location` (
  `location_id` TINYINT(1) NOT NULL,
  `locationName` VARCHAR(50) NOT NULL,
  `locale` TINYINT(1) NOT NULL,
  `hotelType` TINYINT(1) NOT NULL,
  PRIMARY KEY (`location_id`),
  INDEX `fk_location_locale_idx` (`locale` ASC) VISIBLE,
  INDEX `fk_location_hotelType_idx` (`hotelType` ASC) VISIBLE,
  CONSTRAINT `fk_location_locale`
    FOREIGN KEY (`locale`)
    REFERENCES `locale` (`locale_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_location_hotelType`
    FOREIGN KEY (`hotelType`)
    REFERENCES `hotelType` (`hotelType_id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- SET SQL_MODE=@OLD_SQL_MODE;
-- SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
-- SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
