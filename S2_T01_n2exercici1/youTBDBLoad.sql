USE `youTb`;

-- -------------------------------------------------
-- INSERT INTO `countries` (`name`) VALUES ("name");
-- --------------------------------------------------

INSERT INTO `countries` (`name`) VALUES ("China");
INSERT INTO `countries` (`name`) VALUES ("Russia");
INSERT INTO `countries` (`name`) VALUES ("Croatia");

-- -------------------------------------------------
-- INSERT INTO `users` (`email`,`password`,`name`,`birthDate`,`gender`,`idCountry`, `postCode`) VALUES ("email", "password", "name", "birthDate", "gender", "idCountry", "postCode");
-- -------------------------------------------------
-- ("female", "male", "notRelevant")

INSERT INTO `users` (`email`,`password`,`name`,`birthDate`,`gender`,`idCountry`, `postCode`) VALUES ("seasterling0@sciencedaily.com", "jP2#D)K9v@?YQ`", "Susana Easterling", "1983-08-07", "female", 1, "54457");

INSERT INTO `users` (`email`,`password`,`name`,`birthDate`,`gender`,`idCountry`, `postCode`) VALUES ("afortey1@fda.gov", "kO6<$R7Mu>28<", "Ailee Fortey", "1980-12-08", "notRelevant", 2, "196851");

INSERT INTO `users` (`email`,`password`,`name`,`birthDate`,`gender`,`idCountry`, `postCode`) VALUES ("cberr2@mysql.com", "qB4,k9+9T|k", "Clark Berr", "1993/10/25", "male", 3, "32221");

INSERT INTO `users` (`email`,`password`,`name`,`birthDate`,`gender`,`idCountry`, `postCode`) VALUES ("cheare3@ycombinator.com", "zA3{=zb_#", "Carmina Heare", "1990-04-07", "female", 3, "32221");


-- -----------------------------------------------------------------
-- INSERT INTO `publications` (`type`, `idPublisher`) VALUES(`type`, `idPublisher`);
-- ------------------------------------------------------------------

INSERT INTO `publications` (`type`, `idPublisher`) VALUES("video", 2);
INSERT INTO `publications` (`type`, `idPublisher`) VALUES("video", 3);
INSERT INTO `publications` (`type`, `idPublisher`) VALUES("comment", 1);
INSERT INTO `publications` (`type`, `idPublisher`) VALUES("comment", 2);
INSERT INTO `publications` (`type`, `idPublisher`) VALUES("comment", 1);


-- -----------------------------------------------------------------
-- INSERT INTO `videos` (`idPublication`, `title`, `description`, `size`, `fileName`, `duration`, `thumbnail`, `state`) VALUES("idPublication", "title", "description", "size", "fileName", "duration", "thumbnail", "state");
-- ------------------------------------------------------------------

INSERT INTO `videos` (`idPublication`, `title`, `description`, `size`, `fileName`, `duration`, `thumbnail`, `state`) VALUES(1, "Manhattan Project, The", "Manhattan Project, The Manhattan Project, The Manhattan Project, The", "250MB", "ManhattanProject.mkv", "1:23:10", "563896manhattan-project", "public");

INSERT INTO `videos` (`idPublication`, `title`, `description`, `size`, `fileName`, `duration`, `thumbnail`, `state`) VALUES(2, "Hunter, The", "Hunter, The Hunter, The Hunter, The Hunter, The", "2GB", "HunterThe.mkv", "00:45:23", "09768745Hunter", "private");

-- ---------------------------
-- INSERT INTO `tags`(`name`) VALUES(`name`);
-- ---------------------------

INSERT INTO `tags`(`name`) VALUES("nuclear");
INSERT INTO `tags`(`name`) VALUES("biotech");
INSERT INTO `tags`(`name`) VALUES("TasmanianTiger");
INSERT INTO `tags`(`name`) VALUES("WWII");

-- ---------------------------
-- INSERT INTO `taggedVideos`(`idVideo`, `idTag`) VALUES(`idVideo`, `idTag`);
-- ---------------------------

INSERT INTO `taggedVideos`(`idVideo`, `idTag`) VALUES(1, 1);
INSERT INTO `taggedVideos`(`idVideo`, `idTag`) VALUES(2, 2);
INSERT INTO `taggedVideos`(`idVideo`, `idTag`) VALUES(2, 3);
INSERT INTO `taggedVideos`(`idVideo`, `idTag`) VALUES(1, 4);

-- ---------------------------
-- INSERT INTO `comments`(`idPublication`, `idCommentedPublication`, `text`) VALUES("idPublication", "idCommentedPublication", "text");
-- ---------------------------

INSERT INTO `comments`(`idPublication`, `idCommentedPublication`, `text`) VALUES(3, 2, "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua");
INSERT INTO `comments`(`idPublication`, `idCommentedPublication`, `text`) VALUES(4, 3, "Ut enim ad minim veniam, quis knostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.");
INSERT INTO `comments`(`idPublication`, `idCommentedPublication`, `text`) VALUES(5, 1, "Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. ");


-- ---------------------------
-- INSERT INTO `chanels`(`idCreatedBy`, `name`, `description`) VALUES("idCreatedBy", "name", "description");
-- ---------------------------

INSERT INTO `chanels`(`idCreatedBy`, `name`, `description`) VALUES(3, "The Hunter Chanel", "The Hunter Chanel The Hunter Chanel The Hunter ChanelThe Hunter Chanel");

-- ---------------------------
-- INSERT INTO `playlists`(`idCreatedBy`, `name`, `status`) VALUES("idCreatedBy", "name", "status");
-- ---------------------------

INSERT INTO `playlists`(`idCreatedBy`, `name`, `status`) VALUES(2, "playlist#1", "private");


-- ---------------------------
-- INSERT INTO `playlistItems`(`idPlaylist`, `idPublication`) VALUES(`idPlaylist`, `idPublication`);
-- ---------------------------

INSERT INTO `playlistItems`(`idPlaylist`, `idPublication`) VALUES(1, 1);
INSERT INTO `playlistItems`(`idPlaylist`, `idPublication`) VALUES(1, 2);

-- ---------------------------
-- INSERT INTO `subscriptions`(`idUser`, `idChanel`) VALUES(`idUser`, `idChanel`);
-- ---------------------------

INSERT INTO `subscriptions`(`idUser`, `idChanel`) VALUES(4, 1);
INSERT INTO `subscriptions`(`idUser`, `idChanel`) VALUES(1, 1);


-- ---------------------------
-- INSERT INTO `reactions`(`idUser`, `idPublicationReactedTo`, `reaction`) VALUES(`idUser`, `idPublicationReactedTo`, `reaction`);
-- ---------------------------

INSERT INTO `reactions`(`idUser`, `idPublicationReactedTo`, `reaction`) VALUES(1, 2, "like");
INSERT INTO `reactions`(`idUser`, `idPublicationReactedTo`, `reaction`) VALUES(2, 1, "like");
INSERT INTO `reactions`(`idUser`, `idPublicationReactedTo`, `reaction`) VALUES(3, 3, "dislike");
INSERT INTO `reactions`(`idUser`, `idPublicationReactedTo`, `reaction`) VALUES(1, 3, "like");
INSERT INTO `reactions`(`idUser`, `idPublicationReactedTo`, `reaction`) VALUES(4, 1, "like");
INSERT INTO `reactions`(`idUser`, `idPublicationReactedTo`, `reaction`) VALUES(4, 3, "dislike");



-- UPDATE orders SET totalPrice = (SELECT SUM(orderLines.quantity * products.price) FROM orderLines
-- INNER JOIN products ON orderLines.idProduct=products.productId 
-- WHERE idOrder=orders.orderId GROUP BY idOrder);

-- Fill countFields with the count of loaded data
-- videos likesCount
UPDATE videos SET likes = (SELECT SUM(reactions.reaction) FROM reactions
INNER JOIN publications ON reactions.idPublicationReactedTo=publications.publicationId
WHERE reaction LIKE "like" AND videos.idPublication=publications.publicationId GROUP BY idPublication);

-- videos dislikesCount
UPDATE videos SET likes = (SELECT SUM(reactions.reaction) FROM reactions
INNER JOIN publications ON reactions.idPublicationReactedTo=publications.publicationId
WHERE reaction LIKE "dislike" AND videos.idPublication=publications.publicationId GROUP BY idPublication);
