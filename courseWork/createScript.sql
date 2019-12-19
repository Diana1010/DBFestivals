-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema fest
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fest
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fest` DEFAULT CHARACTER SET utf8 ;
-- -----------------------------------------------------
-- Schema fest
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema fest
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `fest` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `fest` ;

-- -----------------------------------------------------
-- Table `fest`.`RegInfo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`RegInfo` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(100) NOT NULL,
  `password` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `login_UNIQUE` (`login` ASC) INVISIBLE,
  INDEX `regInfo` (`login` ASC, `password` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`Contact_info`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`Contact_info` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `firstname` VARCHAR(100) NOT NULL,
  `surname` VARCHAR(100) NOT NULL,
  `age` INT NULL,
  `mail` VARCHAR(45) NULL,
  `phone` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `firstname_surname` (`firstname` ASC, `surname` ASC) VISIBLE,
  INDEX `contactInfo` (`firstname` ASC, `surname` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`user` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `RegInfo_ID` INT NOT NULL,
  `Contact_info_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_user_RegInfo1_idx` (`RegInfo_ID` ASC) VISIBLE,
  INDEX `fk_user_Contact_info1_idx` (`Contact_info_ID` ASC) VISIBLE,
  CONSTRAINT `fk_user_RegInfo1`
    FOREIGN KEY (`RegInfo_ID`)
    REFERENCES `fest`.`RegInfo` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_Contact_info1`
    FOREIGN KEY (`Contact_info_ID`)
    REFERENCES `fest`.`Contact_info` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`eventType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`eventType` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `typeEvent` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`country`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`country` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`city`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`city` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `country_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_city_country1_idx` (`country_id` ASC) VISIBLE,
  CONSTRAINT `fk_city_country1`
    FOREIGN KEY (`country_id`)
    REFERENCES `fest`.`country` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`building`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`building` (
  `id` INT NOT NULL,
  `street` VARCHAR(45) NOT NULL,
  `name` VARCHAR(45) NULL,
  `number` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`adress`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`adress` (
  `id` INT NOT NULL,
  `city_id` INT NOT NULL,
  `building_id` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_adress_city1_idx` (`city_id` ASC) VISIBLE,
  INDEX `fk_adress_building1_idx` (`building_id` ASC) VISIBLE,
  INDEX `addres` (`building_id` ASC, `city_id` ASC) VISIBLE,
  CONSTRAINT `fk_adress_city1`
    FOREIGN KEY (`city_id`)
    REFERENCES `fest`.`city` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_adress_building1`
    FOREIGN KEY (`building_id`)
    REFERENCES `fest`.`building` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`place`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`place` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `maxAmountOfParticipants` INT NOT NULL,
  `adress_id` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_place_adress1_idx` (`adress_id` ASC) VISIBLE,
  CONSTRAINT `fk_place_adress1`
    FOREIGN KEY (`adress_id`)
    REFERENCES `fest`.`adress` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`eventDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`eventDetails` (
  `id` INT NOT NULL,
  `date` DATE NOT NULL,
  `description` VARCHAR(145) NULL,
  `countOfMembers` INT NOT NULL,
  `availableCountOfMembers` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `eventDate` (`date` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`outlayType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`outlayType` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`outlay`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`outlay` (
  `id` INT NOT NULL,
  `amount` VARCHAR(45) NULL,
  `outlayType_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_outlay_outlayType1_idx` (`outlayType_id` ASC) VISIBLE,
  INDEX `outlayName` (`name` ASC) VISIBLE,
  CONSTRAINT `fk_outlay_outlayType1`
    FOREIGN KEY (`outlayType_id`)
    REFERENCES `fest`.`outlayType` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`profitType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`profitType` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`profit`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`profit` (
  `id` INT NOT NULL,
  `amountMoney` VARCHAR(45) NULL,
  `profitType_id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_profit_profitType1_idx` (`profitType_id` ASC) VISIBLE,
  INDEX `profitName` (`name` ASC) VISIBLE,
  CONSTRAINT `fk_profit_profitType1`
    FOREIGN KEY (`profitType_id`)
    REFERENCES `fest`.`profitType` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`Event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`Event` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `type_id` INT NOT NULL,
  `place_ID` INT NOT NULL,
  `eventDetails_id` INT NOT NULL,
  `name` VARCHAR(145) NOT NULL,
  `outlay_id` INT NOT NULL,
  `profit_id` INT NOT NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Event_type1_idx` (`type_id` ASC) VISIBLE,
  INDEX `fk_Event_place1_idx` (`place_ID` ASC) VISIBLE,
  INDEX `fk_Event_eventDetails1_idx` (`eventDetails_id` ASC) VISIBLE,
  INDEX `fk_Event_outlay1_idx` (`outlay_id` ASC) VISIBLE,
  INDEX `fk_Event_profit1_idx` (`profit_id` ASC) VISIBLE,
  CONSTRAINT `fk_Event_type1`
    FOREIGN KEY (`type_id`)
    REFERENCES `fest`.`eventType` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Event_place1`
    FOREIGN KEY (`place_ID`)
    REFERENCES `fest`.`place` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Event_eventDetails1`
    FOREIGN KEY (`eventDetails_id`)
    REFERENCES `fest`.`eventDetails` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_outlay1`
    FOREIGN KEY (`outlay_id`)
    REFERENCES `fest`.`outlay` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_profit1`
    FOREIGN KEY (`profit_id`)
    REFERENCES `fest`.`profit` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`Performer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`Performer` (
  `ID` INT NOT NULL AUTO_INCREMENT,
  `profession` VARCHAR(255) NULL,
  `Contact_info_ID` INT NOT NULL,
  `awards` VARCHAR(255) NULL,
  PRIMARY KEY (`ID`),
  INDEX `fk_Performer_Contact_info1_idx` (`Contact_info_ID` ASC) VISIBLE,
  INDEX `performerInd` (`profession` ASC, `Contact_info_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Performer_Contact_info1`
    FOREIGN KEY (`Contact_info_ID`)
    REFERENCES `fest`.`Contact_info` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`Performer_has_Event`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`Performer_has_Event` (
  `Performer_ID` INT NOT NULL,
  `Event_ID` INT NOT NULL,
  INDEX `fk_Performer_has_Event_Event1_idx` (`Event_ID` ASC) VISIBLE,
  INDEX `fk_Performer_has_Event_Performer1_idx` (`Performer_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Performer_has_Event_Performer1`
    FOREIGN KEY (`Performer_ID`)
    REFERENCES `fest`.`Performer` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Performer_has_Event_Event1`
    FOREIGN KEY (`Event_ID`)
    REFERENCES `fest`.`Event` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`role`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`role` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(145) NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`role_has_user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`role_has_user` (
  `role_id` INT NOT NULL,
  `user_ID` INT NOT NULL,
  INDEX `fk_role_has_user_user1_idx` (`user_ID` ASC) VISIBLE,
  INDEX `fk_role_has_user_role1_idx` (`role_id` ASC) VISIBLE,
  CONSTRAINT `fk_role_has_user_role1`
    FOREIGN KEY (`role_id`)
    REFERENCES `fest`.`role` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_role_has_user_user1`
    FOREIGN KEY (`user_ID`)
    REFERENCES `fest`.`user` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`paymentMethod`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`paymentMethod` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NULL,
  `commission` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`payment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`payment` (
  `id` INT NOT NULL,
  `date` DATETIME NOT NULL,
  `result` VARCHAR(145) NOT NULL,
  `amount` INT NOT NULL,
  `paymentMethod_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_payment_paymentMethod1_idx` (`paymentMethod_id` ASC) VISIBLE,
  INDEX `paymentInd` (`date` ASC, `result` ASC, `amount` ASC) VISIBLE,
  CONSTRAINT `fk_payment_paymentMethod1`
    FOREIGN KEY (`paymentMethod_id`)
    REFERENCES `fest`.`paymentMethod` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`request`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`request` (
  `user_ID` INT NOT NULL,
  `Event_ID` INT NOT NULL,
  `payment_id` INT NOT NULL,
  INDEX `fk_user_has_Event_Event1_idx` (`Event_ID` ASC) VISIBLE,
  INDEX `fk_user_has_Event_user1_idx` (`user_ID` ASC) VISIBLE,
  INDEX `fk_request_payment1_idx` (`payment_id` ASC) VISIBLE,
  CONSTRAINT `fk_user_has_Event_user1`
    FOREIGN KEY (`user_ID`)
    REFERENCES `fest`.`user` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_user_has_Event_Event1`
    FOREIGN KEY (`Event_ID`)
    REFERENCES `fest`.`Event` (`ID`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `fk_request_payment1`
    FOREIGN KEY (`payment_id`)
    REFERENCES `fest`.`payment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`performerSkills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`performerSkills` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(45) NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`Performer_has_performerSkills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`Performer_has_performerSkills` (
  `Performer_ID` INT NOT NULL,
  `performerSkills_id` INT NOT NULL,
  INDEX `fk_Performer_has_performerSkills_performerSkills1_idx` (`performerSkills_id` ASC) VISIBLE,
  INDEX `fk_Performer_has_performerSkills_Performer1_idx` (`Performer_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Performer_has_performerSkills_Performer1`
    FOREIGN KEY (`Performer_ID`)
    REFERENCES `fest`.`Performer` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Performer_has_performerSkills_performerSkills1`
    FOREIGN KEY (`performerSkills_id`)
    REFERENCES `fest`.`performerSkills` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`transportType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`transportType` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`transport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`transport` (
  `id` INT NOT NULL,
  `count` VARCHAR(45) NULL,
  `transportType_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_transport_transportType1_idx` (`transportType_id` ASC) VISIBLE,
  CONSTRAINT `fk_transport_transportType1`
    FOREIGN KEY (`transportType_id`)
    REFERENCES `fest`.`transportType` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`Event_has_transport`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`Event_has_transport` (
  `Event_ID` INT NULL,
  `transport_id` INT NULL,
  INDEX `fk_Event_has_transport_transport1_idx` (`transport_id` ASC) VISIBLE,
  INDEX `fk_Event_has_transport_Event1_idx` (`Event_ID` ASC) VISIBLE,
  CONSTRAINT `fk_Event_has_transport_Event1`
    FOREIGN KEY (`Event_ID`)
    REFERENCES `fest`.`Event` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_has_transport_transport1`
    FOREIGN KEY (`transport_id`)
    REFERENCES `fest`.`transport` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`company`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`company` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `nameCompany` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`organizer`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`organizer` (
  `id` INT NOT NULL,
  `profession` VARCHAR(145) NULL,
  `Contact_info_ID` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_organizer_Contact_info1_idx` (`Contact_info_ID` ASC) VISIBLE,
  CONSTRAINT `fk_organizer_Contact_info1`
    FOREIGN KEY (`Contact_info_ID`)
    REFERENCES `fest`.`Contact_info` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`Event_has_organization`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`Event_has_organization` (
  `Event_ID` INT NULL,
  `company_id` INT NULL,
  `organizer_id` INT NULL,
  INDEX `fk_Event_has_company_company1_idx` (`company_id` ASC) VISIBLE,
  INDEX `fk_Event_has_company_Event1_idx` (`Event_ID` ASC) VISIBLE,
  INDEX `fk_Event_has_organization_organizer1_idx` (`organizer_id` ASC) VISIBLE,
  CONSTRAINT `fk_Event_has_company_Event1`
    FOREIGN KEY (`Event_ID`)
    REFERENCES `fest`.`Event` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_has_company_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `fest`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_has_organization_organizer1`
    FOREIGN KEY (`organizer_id`)
    REFERENCES `fest`.`organizer` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`sponsorDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`sponsorDetails` (
  `id` INT NOT NULL,
  `moneyAmount` INT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`sponsor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`sponsor` (
  `id` INT NOT NULL,
  `profession` VARCHAR(45) NULL,
  `Contact_info_ID` INT NOT NULL,
  `sponsorDetails_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_sponsor_Contact_info1_idx` (`Contact_info_ID` ASC) VISIBLE,
  INDEX `fk_sponsor_sponsorDetails1_idx` (`sponsorDetails_id` ASC) VISIBLE,
  CONSTRAINT `fk_sponsor_Contact_info1`
    FOREIGN KEY (`Contact_info_ID`)
    REFERENCES `fest`.`Contact_info` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_sponsor_sponsorDetails1`
    FOREIGN KEY (`sponsorDetails_id`)
    REFERENCES `fest`.`sponsorDetails` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`Event_has_sponsor`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`Event_has_sponsor` (
  `Event_ID` INT NOT NULL,
  `company_id` INT NULL,
  `sponsor_id` INT NULL,
  `sponsorDetails_id` INT NULL,
  INDEX `fk_Event_has_company_company2_idx` (`company_id` ASC) VISIBLE,
  INDEX `fk_Event_has_company_Event2_idx` (`Event_ID` ASC) VISIBLE,
  INDEX `fk_Event_has_sponsor_sponsor1_idx` (`sponsor_id` ASC) VISIBLE,
  INDEX `fk_Event_has_sponsor_sponsorDetails1_idx` (`sponsorDetails_id` ASC) VISIBLE,
  CONSTRAINT `fk_Event_has_company_Event2`
    FOREIGN KEY (`Event_ID`)
    REFERENCES `fest`.`Event` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_has_company_company2`
    FOREIGN KEY (`company_id`)
    REFERENCES `fest`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_has_sponsor_sponsor1`
    FOREIGN KEY (`sponsor_id`)
    REFERENCES `fest`.`sponsor` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Event_has_sponsor_sponsorDetails1`
    FOREIGN KEY (`sponsorDetails_id`)
    REFERENCES `fest`.`sponsorDetails` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

USE `fest` ;

-- -----------------------------------------------------
-- Table `fest`.`name`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`name` (
  `idname` INT(11) NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idname`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `fest`.`ErrorLog`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`ErrorLog` (
  `LogId` INT NOT NULL,
  `ErrorState` VARCHAR(45) NOT NULL,
  `ErrorMessage` VARCHAR(45) NULL,
  `UserId` INT NOT NULL,
  `CreatedOn` DATE NULL,
  PRIMARY KEY (`LogId`),
  UNIQUE INDEX `LogId_UNIQUE` (`LogId` ASC) VISIBLE,
  INDEX `log` (`ErrorState` ASC, `ErrorMessage` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`requirement`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`requirement` (
  `id` INT NOT NULL,
  `quantity` INT NULL,
  `cost_planned` DOUBLE NULL,
  `cost_actual` DOUBLE NULL,
  `Event_ID` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_requirement_Event_idx` (`Event_ID` ASC) VISIBLE,
  CONSTRAINT `fk_requirement_Event`
    FOREIGN KEY (`Event_ID`)
    REFERENCES `fest`.`Event` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`equipment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`equipment` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `available` VARCHAR(45) NOT NULL,
  `requirement_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_equipment_requirement1_idx` (`requirement_id` ASC) VISIBLE,
  INDEX `equipment` (`name` ASC) VISIBLE,
  CONSTRAINT `fk_equipment_requirement1`
    FOREIGN KEY (`requirement_id`)
    REFERENCES `fest`.`requirement` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`equipmentType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`equipmentType` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `equipment_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_equipmentType_equipment1_idx` (`equipment_id` ASC) VISIBLE,
  CONSTRAINT `fk_equipmentType_equipment1`
    FOREIGN KEY (`equipment_id`)
    REFERENCES `fest`.`equipment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`employeeDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`employeeDetails` (
  `id` INT NOT NULL,
  `nationality` VARCHAR(45) NOT NULL,
  `visa` VARCHAR(45) NOT NULL,
  `drivingLicense` VARCHAR(45) NULL,
  `resume` VARCHAR(45) NOT NULL,
  `Contact_info_ID` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_employeeDetails_Contact_info1_idx` (`Contact_info_ID` ASC) VISIBLE,
  CONSTRAINT `fk_employeeDetails_Contact_info1`
    FOREIGN KEY (`Contact_info_ID`)
    REFERENCES `fest`.`Contact_info` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`employee` (
  `ID` INT NOT NULL,
  `profession` VARCHAR(45) NOT NULL,
  `employeeDetails_id` INT NOT NULL,
  `Contact_info_ID` INT NOT NULL,
  PRIMARY KEY (`ID`),
  UNIQUE INDEX `ID_UNIQUE` (`ID` ASC) VISIBLE,
  INDEX `fk_employee_employeeDetails1_idx` (`employeeDetails_id` ASC) VISIBLE,
  INDEX `fk_employee_Contact_info1_idx` (`Contact_info_ID` ASC) VISIBLE,
  CONSTRAINT `fk_employee_employeeDetails1`
    FOREIGN KEY (`employeeDetails_id`)
    REFERENCES `fest`.`employeeDetails` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_Contact_info1`
    FOREIGN KEY (`Contact_info_ID`)
    REFERENCES `fest`.`Contact_info` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`typeOfWork`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`typeOfWork` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`employeesWork`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`employeesWork` (
  `id` INT NOT NULL,
  `spendHours` INT NULL,
  `salary` INT NOT NULL,
  `workingHours` INT NOT NULL,
  `typeOfWork_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_employeesWork_typeOfWork1_idx` (`typeOfWork_id` ASC) VISIBLE,
  INDEX `work` (`salary` ASC, `typeOfWork_id` ASC) VISIBLE,
  CONSTRAINT `fk_employeesWork_typeOfWork1`
    FOREIGN KEY (`typeOfWork_id`)
    REFERENCES `fest`.`typeOfWork` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`employee_has_employeesWork`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`employee_has_employeesWork` (
  `employee_ID` INT NOT NULL,
  `employeesWork_id` INT NOT NULL,
  INDEX `fk_employee_has_employeesWork_employeesWork1_idx` (`employeesWork_id` ASC) VISIBLE,
  INDEX `fk_employee_has_employeesWork_employee1_idx` (`employee_ID` ASC) VISIBLE,
  CONSTRAINT `fk_employee_has_employeesWork_employee1`
    FOREIGN KEY (`employee_ID`)
    REFERENCES `fest`.`employee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_employee_has_employeesWork_employeesWork1`
    FOREIGN KEY (`employeesWork_id`)
    REFERENCES `fest`.`employeesWork` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`skills`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`skills` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `description` VARCHAR(255) NULL,
  `level` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `skillNames` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`skills_has_employeeDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`skills_has_employeeDetails` (
  `skills_id` INT NOT NULL,
  `employeeDetails_id` INT NOT NULL,
  INDEX `fk_skills_has_employeeDetails_employeeDetails1_idx` (`employeeDetails_id` ASC) VISIBLE,
  INDEX `fk_skills_has_employeeDetails_skills1_idx` (`skills_id` ASC) VISIBLE,
  CONSTRAINT `fk_skills_has_employeeDetails_skills1`
    FOREIGN KEY (`skills_id`)
    REFERENCES `fest`.`skills` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_skills_has_employeeDetails_employeeDetails1`
    FOREIGN KEY (`employeeDetails_id`)
    REFERENCES `fest`.`employeeDetails` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`room`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`room` (
  `id` INT NOT NULL,
  `number` INT NOT NULL,
  `capacity` INT NULL,
  `building_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_room_building1_idx` (`building_id` ASC) VISIBLE,
  CONSTRAINT `fk_room_building1`
    FOREIGN KEY (`building_id`)
    REFERENCES `fest`.`building` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`company_has_employee`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`company_has_employee` (
  `companyOrganizer_id` INT NULL,
  `employee_ID` INT NULL,
  INDEX `fk_companyOrganizer_has_employee_employee1_idx` (`employee_ID` ASC) VISIBLE,
  INDEX `fk_companyOrganizer_has_employee_companyOrganizer1_idx` (`companyOrganizer_id` ASC) VISIBLE,
  CONSTRAINT `fk_companyOrganizer_has_employee_companyOrganizer1`
    FOREIGN KEY (`companyOrganizer_id`)
    REFERENCES `fest`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_companyOrganizer_has_employee_employee1`
    FOREIGN KEY (`employee_ID`)
    REFERENCES `fest`.`employee` (`ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`companyType`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`companyType` (
  `id` INT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  PRIMARY KEY (`id`),
  INDEX `companyType` (`name` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `fest`.`companyDetails`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `fest`.`companyDetails` (
  `id` INT NOT NULL,
  `description` VARCHAR(45) NULL,
  `companyType_id` INT NOT NULL,
  `company_id` INT NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `id_UNIQUE` (`id` ASC) VISIBLE,
  INDEX `fk_companyDetails_companyType1_idx` (`companyType_id` ASC) VISIBLE,
  INDEX `fk_companyDetails_company1_idx` (`company_id` ASC) VISIBLE,
  CONSTRAINT `fk_companyDetails_companyType1`
    FOREIGN KEY (`companyType_id`)
    REFERENCES `fest`.`companyType` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_companyDetails_company1`
    FOREIGN KEY (`company_id`)
    REFERENCES `fest`.`company` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;


INSERT INTO `fest`.`role` (`id`, `name`, `description`) VALUES ('1', 'admin', 'Администратор');
INSERT INTO `fest`.`role` (`id`, `name`, `description`) VALUES ('2', 'user', 'Зарегистрированный');
INSERT INTO `fest`.`role` (`id`, `name`, `description`) VALUES ('3', 'nonReg', 'Незарегистрированный');
INSERT INTO `fest`.`user` (`ID`, `RegInfo_ID`, `Contact_info_ID`) VALUES ('1', '1', '1');
INSERT INTO `fest`.`user` (`ID`, `RegInfo_ID`, `Contact_info_ID`) VALUES ('2', '2', '2');
INSERT INTO `fest`.`user` (`ID`, `RegInfo_ID`, `Contact_info_ID`) VALUES ('3', '3', '3');

INSERT INTO `fest`.`reginfo` (`ID`, `login`, `password`) VALUES ('1', 'petr45', 'gf45');
INSERT INTO `fest`.`reginfo` (`ID`, `login`, `password`) VALUES ('2', 'kol78', 'fvfgd45');
INSERT INTO `fest`.`reginfo` (`ID`, `login`, `password`) VALUES ('3', 'r78', 'dx98');

ALTER TABLE role_has_user
MODIFY user_ID int NOT NULL;

alter table role_has_user
  add unique index roleUser (user_id );

INSERT INTO `fest`.`country` (`id`, `name`) VALUES ('1', 'France');
INSERT INTO `fest`.`country` (`id`, `name`) VALUES ('2', 'Italy');

INSERT INTO `fest`.`city` (`id`, `name`, `country_id`) VALUES ('1', 'Milan', '2');
INSERT INTO `fest`.`city` (`id`, `name`, `country_id`) VALUES ('2', 'Paris', '1');

INSERT INTO `fest`.`building` (`id`, `street`, `name`, `number`) VALUES ('1', 'Sovtskay', 'ТЦ МОЛ', '98');
INSERT INTO `fest`.`building` (`id`, `street`, `name`, `number`) VALUES ('2', 'Петруся Бровки', 'ТЦ GREEN', '1');
INSERT INTO `fest`.`room` (`id`, `number`, `capacity`, `building_id`) VALUES ('1', '12', '200', '2');
INSERT INTO `fest`.`room` (`id`, `number`, `capacity`, `building_id`) VALUES ('2', '25', '1000', '1');


DELIMITER //

CREATE PROCEDURE ShowPeople(rowsCount SMALLINT)
BEGIN
	select r.login, r.password, c.age, c.firstname, c.mail, c.phone, c.surname from user AS u
    inner join reginfo AS r On  r.id = u.RegInfo_ID
	inner join contact_info AS c On  c.id = u.Contact_Info_ID 
    limit rowsCount;
END //

DELIMITER ;

INSERT INTO `fest`.`eventtype` (`id`, `name`) VALUES ('1', 'Музыкальный');
INSERT INTO `fest`.`eventtype` (`id`, `name`) VALUES ('2', 'Исторический');

INSERT INTO `fest`.`outlaytype` (`id`, `name`) VALUES ('1', 'оборудование');
INSERT INTO `fest`.`outlaytype` (`id`, `name`) VALUES ('2', 'зарплата работников');
INSERT INTO `fest`.`outlay` (`id`, `amount`, `outlayType_id`, `name`) VALUES ('1', '200', '1', 'оборудование');
INSERT INTO `fest`.`outlay` (`id`, `amount`, `outlayType_id`, `name`) VALUES ('2', '1000', '2', 'зарплата');
INSERT INTO `fest`.`profittype` (`id`, `name`) VALUES ('1', 'билеты');
INSERT INTO `fest`.`profittype` (`id`, `name`) VALUES ('2', 'сувениры');
INSERT INTO `fest`.`profit` (`id`, `amountMoney`, `profitType_id`, `name`) VALUES ('1', '2000', '1', 'билеты');
INSERT INTO `fest`.`profit` (`id`, `amountMoney`, `profitType_id`, `name`) VALUES ('2', '100', '2', 'сувениры');
INSERT INTO `fest`.`transporttype` (`id`, `name`) VALUES ('1', 'машина');
INSERT INTO `fest`.`transporttype` (`id`, `name`) VALUES ('2', 'автобус');
INSERT INTO `fest`.`transport` (`id`, `count`, `transportType_id`) VALUES ('1', '20', '1');
INSERT INTO `fest`.`transport` (`id`, `count`, `transportType_id`) VALUES ('2', '3', '2');
INSERT INTO `fest`.`adress` (`id`, `city_id`, `building_id`) VALUES ('1', '1', '1');
INSERT INTO `fest`.`adress` (`id`, `city_id`, `building_id`) VALUES ('2', '2', '2');
INSERT INTO `fest`.`place` (`ID`, `maxAmountOfParticipants`, `adress_id`) VALUES ('1', '20000', '1');
INSERT INTO `fest`.`place` (`ID`, `maxAmountOfParticipants`, `adress_id`) VALUES ('2', '500', '2');
INSERT INTO `fest`.`event` (`ID`, `type_id`, `place_ID`, `eventDetails_id`, `name`, `outlay_id`, `profit_id`) VALUES ('1', '1', '1', '1', 'музыкал)', '1', '1');
INSERT INTO `fest`.`event` (`ID`, `type_id`, `place_ID`, `eventDetails_id`, `name`, `outlay_id`, `profit_id`) VALUES ('2', '2', '2', '2', 'Калиновский', '2', '2');

DELIMITER //

CREATE PROCEDURE ShowEvent(rowsCount SMALLINT)
BEGIN
	select u.* from event AS u
    inner join eventtype AS t On  t.id = u.type_id
	inner join place AS p On  p.id = u.place_ID
    inner join eventDetails AS d ON d.ID = u.eventDetails_id
    inner join outlay AS o ON o.ID = u.outlay_id
    inner join profit AS pr ON pr.ID = u.profit_id
    limit rowsCount;
END //

DELIMITER ;


DELIMITER //

CREATE PROCEDURE ShowPlaces(rowsCount SMALLINT)
BEGIN
	select u.* from place AS u
    inner join adress AS t On  t.id = u.adress_id
	inner join city AS p On  p.id = t.city_id
    inner join building AS d ON d.ID = t.building_id
    inner join country AS o ON o.ID = p.country_id
  
    limit rowsCount;
END //

DELIMITER ;