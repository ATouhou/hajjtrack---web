SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

CREATE SCHEMA IF NOT EXISTS `maxxsolc_hajjtrack` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci ;
USE `maxxsolc_hajjtrack` ;

-- -----------------------------------------------------
-- Table `maxxsolc_hajjtrack`.`User`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maxxsolc_hajjtrack`.`User` (
  `userId` MEDIUMINT NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `first_name` VARCHAR(100) NOT NULL,
  `last_name` VARCHAR(100) NULL,
  `userImage` VARCHAR(45) NULL,
  `email` VARCHAR(60) NOT NULL,
  `contact_number` VARCHAR(45) NOT NULL,
  `role` VARCHAR(45) NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  PRIMARY KEY (`userId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maxxsolc_hajjtrack`.`Places`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maxxsolc_hajjtrack`.`Places` (
  `placeId` MEDIUMINT NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(500) NULL,
  `lat` DOUBLE NOT NULL,
  `long` DOUBLE NOT NULL,
  `isVisible` TINYINT(1) NOT NULL DEFAULT 0,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  PRIMARY KEY (`placeId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maxxsolc_hajjtrack`.`Friends`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maxxsolc_hajjtrack`.`Friends` (
  `userId` MEDIUMINT NOT NULL,
  `friendId` MEDIUMINT NULL)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maxxsolc_hajjtrack`.`tracks`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maxxsolc_hajjtrack`.`tracks` (
  `trackId` MEDIUMINT NOT NULL AUTO_INCREMENT,
  `userId` MEDIUMINT NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `startPosition` DOUBLE NOT NULL,
  `endPosition` DOUBLE NOT NULL,
  `latLongs` TEXT NULL COMMENT 'list of lat,long',
  PRIMARY KEY (`trackId`),
  INDEX `fk_tracks_User_idx` (`userId` ASC),
  CONSTRAINT `fk_tracks_User`
    FOREIGN KEY (`userId`)
    REFERENCES `maxxsolc_hajjtrack`.`User` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maxxsolc_hajjtrack`.`PlaceImages`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maxxsolc_hajjtrack`.`PlaceImages` (
  `placeImagesId` INT NOT NULL AUTO_INCREMENT,
  `placeId` MEDIUMINT NOT NULL,
  `title` VARCHAR(250) NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  PRIMARY KEY (`placeImagesId`),
  INDEX `fk_PlaceImages_Places1_idx` (`placeId` ASC),
  CONSTRAINT `fk_PlaceImages_Places1`
    FOREIGN KEY (`placeId`)
    REFERENCES `maxxsolc_hajjtrack`.`Places` (`placeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maxxsolc_hajjtrack`.`ReviewRatings`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maxxsolc_hajjtrack`.`ReviewRatings` (
  `reviewRatingsId` INT NOT NULL AUTO_INCREMENT,
  `userId` MEDIUMINT NOT NULL,
  `placeId` MEDIUMINT NOT NULL,
  `description` TEXT NOT NULL,
  `rating` TINYINT(1) NOT NULL,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  PRIMARY KEY (`reviewRatingsId`),
  INDEX `fk_PlaceReviewRatings_User1_idx` (`userId` ASC),
  INDEX `fk_PlaceReviewRatings_Places1_idx` (`placeId` ASC),
  CONSTRAINT `fk_PlaceReviewRatings_User1`
    FOREIGN KEY (`userId`)
    REFERENCES `maxxsolc_hajjtrack`.`User` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_PlaceReviewRatings_Places1`
    FOREIGN KEY (`placeId`)
    REFERENCES `maxxsolc_hajjtrack`.`Places` (`placeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `maxxsolc_hajjtrack`.`UserLocations`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `maxxsolc_hajjtrack`.`UserLocations` (
  `userLocationsId` INT NOT NULL AUTO_INCREMENT,
  `userId` MEDIUMINT NOT NULL,
  `lat` DOUBLE NOT NULL,
  `long` DOUBLE NOT NULL,
  `isResidency` TINYINT(1) NULL DEFAULT 0,
  `createdAt` DATETIME NOT NULL,
  `updatedAt` DATETIME NULL,
  PRIMARY KEY (`userLocationsId`),
  INDEX `fk_UserLocations_User1_idx` (`userId` ASC),
  CONSTRAINT `fk_UserLocations_User1`
    FOREIGN KEY (`userId`)
    REFERENCES `maxxsolc_hajjtrack`.`User` (`userId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
