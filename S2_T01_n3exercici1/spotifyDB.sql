-- -------------------------
-- Drop and create database
-- -------------------------

DROP DATABASE IF EXISTS `spotify`;
CREATE DATABASE `spotify` DEFAULT CHARACTER SET utf8;
USE `spotify`;


-- ---------------------------
-- Create table `users`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `users` (
    `userId` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(80) NOT NULL,
    `password` VARCHAR(50) NOT NULL,
    `name` VARCHAR(80) NOT NULL,
    `birthDate` DATE NOT NULL,
    `gender` ENUM("male", "female", "notRelevant") NOT NULL,
    `country` VARCHAR(80) NOT NULL,
    `postCode` VARCHAR(80) NOT NULL,
    `type` ENUM("free", "premium") NOT NULL,
     PRIMARY KEY(`userId`))
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `subscriptions`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `subscriptions` (
    `subscriptionId` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
    `idUser` INT(11) UNSIGNED NOT NULL,
    `startDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `renovationDate` DATETIME GENERATED ALWAYS AS (DATE_ADD(startDate, INTERVAL 1 YEAR)),
    `payment` ENUM("creditCard", "payPal") NOT NULL,
    PRIMARY KEY(`subscriptionId`),
    FOREIGN KEY (`idUser`) 
        REFERENCES `spotify`.`users` (`userId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;

-- UPDATE `subscriptions` SET renovationDate = DATE_ADD(startDate, INTERVAL 1 YEAR);


-- ---------------------------
-- Create table `creditCards`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `creditCards` (
    `idUser` INT(11) UNSIGNED NOT NULL,
    `cardNumber` BIGINT(16),
    `expiryDateYear` INT(4) NOT NULL,
    `expiryDateMonth` INT(2) NOT NULL,
    `securityCode` INT(3) NOT NULL,
    PRIMARY KEY(`idUser`,`cardNumber`),
    FOREIGN KEY (`idUser`) 
        REFERENCES `spotify`.`users` (`userId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `payPal`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `payPal` (
    `idUser` INT(11) UNSIGNED NOT NULL,
    `payPalUserName` VARCHAR(50),
    PRIMARY KEY(`idUser`),
    FOREIGN KEY (`idUser`) 
        REFERENCES `spotify`.`users` (`userId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;

-- ---------------------------
-- Create table `payments`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `payments` (
    `paymentId` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
    `idSubscription` INT(11) UNSIGNED NOT NULL,
    `date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `total` FLOAT UNSIGNED NOT NULL,
    `paymentMethod` ENUM("creditCard", "payPal"), -- Register here method in case future changes of payment method
    PRIMARY KEY(`paymentId`),
    FOREIGN KEY (`idSubscription`) 
        REFERENCES `spotify`.`subscriptions` (`subscriptionId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `genres`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `genres` (
    `genreId` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
    `name` VARCHAR(50) NOT NULL, 
    PRIMARY KEY(`genreId`))
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `artists`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `artists` (
    `artistId` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
    `name` VARCHAR(50) NOT NULL,
    `idGenre` INT(11) UNSIGNED NOT NULL,
    `image` BLOB,
	PRIMARY KEY(`artistId`), 
    FOREIGN KEY (`IdGenre`) 
        REFERENCES `spotify`.`genres` (`genreId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `albums`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `albums` (
    `albumId` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
    `idArtist` INT(11) UNSIGNED NOT NULL, 
    `title` VARCHAR(50) NOT NULL,
    `publicationDate` DATE NOT NULL,
    `coverImage` BLOB,
    PRIMARY KEY (`albumId`),
    FOREIGN KEY (`idArtist`) 
        REFERENCES `spotify`.`artists` (`artistId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `songs`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `songs` (
    `songId` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
    `title` VARCHAR(50) NOT NULL,
    `duration` TIME NOT NULL,
    `reproductions` INT(11) UNSIGNED DEFAULT 0,
    `idAlbum` INT(11) UNSIGNED NOT NULL,
    `idArtist` INT(11) UNSIGNED NOT NULL,
    PRIMARY KEY(`songId`),
    FOREIGN KEY (`idAlbum`) 
        REFERENCES `spotify`.`albums` (`albumId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (`idArtist`) 
        REFERENCES `spotify`.`artists` (`artistId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `playlists`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `playlists` (
    `playlistId` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, 
    `title` VARCHAR(50) NOT NULL,
    `idCreatedBy`INT(11) UNSIGNED NOT NULL,
    `songsCount` INT(11) DEFAULT NULL,
    `creationDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `state` ENUM("active", "deleted") DEFAULT "active",
    `shared` BOOLEAN,
    `deletionTime` DATETIME DEFAULT NULL,
    PRIMARY KEY(`playlistId`),
    FOREIGN KEY (`idCreatedBy`) 
        REFERENCES `spotify`.`users` (`userId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `playlistSongs`
-- ---------------------------


CREATE TABLE IF NOT EXISTS `playlistItems` (
    `itemId` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT, -- with this way we allow duplicate songs in a playlist
    `idPlaylist` INT(11) UNSIGNED NOT NULL, 
    `idSong` INT(11) UNSIGNED NOT NULL,
    `idAddedBy` INT(11) UNSIGNED NOT NULL,
    `additionDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(`itemId`),
    FOREIGN KEY (`idPlaylist`) 
        REFERENCES `spotify`.`playlists` (`playlistId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (`idSong`) 
        REFERENCES `spotify`.`songs` (`songId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	FOREIGN KEY (`idAddedBy`) 
        REFERENCES `spotify`.`users` (`userId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `userFollowingArtists`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `userFollowingArtists` (
    `idUser` INT(11) UNSIGNED NOT NULL,
    `idArtist` INT(11) UNSIGNED NOT NULL,
    PRIMARY KEY( `idUser`, `idArtist`),
    FOREIGN KEY (`idUser`) 
        REFERENCES `spotify`.`users` (`userId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	FOREIGN KEY (`idArtist`)
        REFERENCES `spotify`.`artists` (`artistId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `userFavoriteSongs`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `userFavoriteSongs` (
    `idUser` INT(11) UNSIGNED NOT NULL,
    `idSong` INT(11) UNSIGNED NOT NULL,
    PRIMARY KEY( `idUser`, `idSong`),
    FOREIGN KEY (`idUser`) 
        REFERENCES `spotify`.`users` (`userId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	FOREIGN KEY (`idSong`)
        REFERENCES `spotify`.`songs` (`songId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;

-- ---------------------------
-- Create table `userFavoriteAlbums`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `userFavoriteAlbums` (
    `idUser` INT(11) UNSIGNED NOT NULL,
    `idAlbum` INT(11) UNSIGNED NOT NULL,
    PRIMARY KEY( `idUser`, `idAlbum`),
    FOREIGN KEY (`idUser`) 
        REFERENCES `spotify`.`users` (`userId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
	FOREIGN KEY (`idAlbum`)
        REFERENCES `spotify`.`albums` (`albumId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;