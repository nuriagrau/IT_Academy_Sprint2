-- -------------------------
-- Drop and create database
-- -------------------------

DROP DATABASE IF EXISTS `youTb`;
CREATE DATABASE `youTb` DEFAULT CHARACTER SET utf8;
USE `youTb`;


-- ---------------------------
-- Create table `countries`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `countries` (
    `countryId` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    PRIMARY KEY(`countryId`))
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `users`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `users` (
    `userId` INT(11) NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(50) NOT NULL UNIQUE,
    `password` VARCHAR(16) NOT NULL UNIQUE,
    `name` VARCHAR(50) NOT NULL,
    `birthDate` DATE,
    `gender` ENUM("female", "male", "notRelevant") NOT NULL,
    `idCountry` INT(11),
    `postCode` VARCHAR(15),
    PRIMARY KEY(`userId`),
    FOREIGN KEY (`idCountry`) 
        REFERENCES  `youTb`.`countries` (`countryId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `publications`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `publications` (
    `publicationId` INT(11) NOT NULL AUTO_INCREMENT,
    `type` ENUM("video", "comment") NOT NULL,
    `idPublisher` INT(11) NOT NULL,
    `publicationDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(`publicationId`),
    FOREIGN KEY (`idPublisher`) 
        REFERENCES  `youTb`.`users` (`userId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `videos`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `videos` (
    `videoId` INT(11) NOT NULL AUTO_INCREMENT, -- can be ommidet by using publicationId
    `idPublication` INT(11) NOT NULL,
    `title` VARCHAR(50) NOT NULL,
    `description` VARCHAR(250) NOT NULL,
    `size` VARCHAR(5) NOT NULL,
    `fileName` VARCHAR(50) NOT NULL,
    `duration` VARCHAR(8) NOT NULL,
    `thumbnail` VARCHAR(80) NOT NULL,
    `reproductions` INT(11) NOT NULL DEFAULT 0,
    `likes` INT(11) DEFAULT 0, -- can be in publications
    `dislikes` INT(11) DEFAULT 0, -- can be in publications
    `state` ENUM("public", "hidden", "private") NOT NULL, -- it could be added in publications as an added functionality
    PRIMARY KEY(`videoId`),
    FOREIGN KEY (`idPublication`) 
        REFERENCES  `youTb`.`publications` (`publicationId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `tags`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `tags` (
    `tagId` INT(11) NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50) NOT NULL,
    PRIMARY KEY(`tagId`))
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `taggedVideos`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `taggedVideos` (
    `idVideo` INT(11) NOT NULL,
    `idTag` INT(11) NOT NULL,
    PRIMARY KEY(`idVideo`, `idTag`),
    FOREIGN KEY (`idVideo`) 
        REFERENCES `youTb`.`videos` (`videoId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (`idTag`) 
        REFERENCES  `youTb`.`tags` (`tagId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `comments`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `comments` (
    `idPublication` INT(11) NOT NULL,
    `idCommentedPublication` INT(11) NOT NULL,
    `text` VARCHAR(500) NOT NULL,
    PRIMARY KEY(`idPublication`),
	FOREIGN KEY (`idPublication`) 
        REFERENCES  `youTb`.`publications` (`publicationId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (`idCommentedPublication`)
        REFERENCES  `youTb`.`publications` (`publicationId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `chanels`
-- ---------------------------
CREATE TABLE IF NOT EXISTS `chanels` (
    `chanelId` INT(11) NOT NULL AUTO_INCREMENT,
    `idCreatedBy`INT(11) NOT NULL, -- it could be treated as publication with the added functionalities but not required in the exercise
    `name` VARCHAR(50) NOT NULL,
    `description` VARCHAR(250) NOT NULL,
    `creationDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(`chanelId`),
	FOREIGN KEY (`idCreatedBy` ) 
        REFERENCES  `youTb`.`users` (`userId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `playlists`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `playlists` (
    `playlistId` INT(11) NOT NULL AUTO_INCREMENT,
    `idCreatedBy` INT(11) NOT NULL, -- it could be treated as publication with the added functionalities but not required in the exercise
    `name` VARCHAR(50) NOT NULL,
    `status` ENUM("public", "private") NOT NULL,
    `creationDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(`playlistId`),
	FOREIGN KEY (`idCreatedBy` ) 
        REFERENCES  `youTb`.`users` (`userId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `playlistItems`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `playlistItems` (
    `idPlaylist` INT(11) NOT NULL,
    `idPublication` INT(11) NOT NULL,
    PRIMARY KEY(`idPlaylist`,`idPublication`),
    FOREIGN KEY (`idPlaylist` ) 
        REFERENCES `youTb`.`playlists` (`playlistId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (`idPublication` ) 
        REFERENCES  `youTb`.`publications` (`publicationId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;


-- ---------------------------
-- Create table `subscriptions`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `subscriptions` (
    `idUser` INT(11) NOT NULL,
    `idChanel` INT(11) NOT NULL,
    PRIMARY KEY(`idUser`,`idChanel`),
    FOREIGN KEY (`idUser`) 
        REFERENCES `youTb`.`users` (`userId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (`idChanel`) 
        REFERENCES  `youTb`.`chanels` (`chanelId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;

-- ---------------------------
-- Create table `reactions`
-- ---------------------------

CREATE TABLE IF NOT EXISTS `reactions` (
    `idUser` INT(11) NOT NULL,
    `idPublicationReactedTo` INT(11) NOT NULL,
    `reaction` ENUM("like", "dislike"),
    `reactionDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY(`idUser`,`idPublicationReactedTo`),
    FOREIGN KEY (`idUser`) 
        REFERENCES `youTb`.`users` (`userId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION,
    FOREIGN KEY (`idPublicationReactedTo`) 
        REFERENCES  `youTb`.`publications` (`publicationId`)
        ON DELETE NO ACTION
        ON UPDATE NO ACTION)
ENGINE = InnoDB 
DEFAULT CHARACTER SET = utf8;
