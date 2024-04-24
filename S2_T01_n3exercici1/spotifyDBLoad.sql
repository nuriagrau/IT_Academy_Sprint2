USE `spotify`;

-- --------------------------------------------------------------------
-- INSERT INTO `users` (`email`, `password`, `name`, `birthDate`, `gender`, `country`, `postCode`,`type`) VALUES(`email`, `password`, `name`, `birthDate`, `gender`, `country`, `postCode`,`type`);
-- --------------------------------------------------------------------


INSERT INTO `users` (`email`, `password`, `name`, `birthDate`, `gender`, `country`, `postCode`,`type`) VALUES("hglasebrook0@vkontakte.ru", "jQ0+_erU(y/JId#", "Harrietta Glasebrook", "1993-12-25", "female", "Philippines", "6714" ,"free");

INSERT INTO `users` (`email`, `password`, `name`, `birthDate`, `gender`, `country`, `postCode`,`type`) VALUES("cgershom1@over-blog.com", "kB0|nPvY)w6K", "Carly Gershom", "1985-7-14", "female", "Albania", "12376" ,"premium");

INSERT INTO `users` (`email`, `password`, `name`, `birthDate`, `gender`, `country`, `postCode`,`type`) VALUES("gshilliday2@discovery.com", "aX0+$/3u#(cmN", "Garvin Shilliday", "1971-10-10", "male", "China", "4214" ,"premium");

INSERT INTO `users` (`email`, `password`, `name`, `birthDate`, `gender`, `country`, `postCode`,`type`) VALUES("ispacy3@google.com.au", "jD8!2Fr/Zd{+tJ", "Ingaborg Spacy", "1987-07-07", "female", "Nicaragua", "4564911" ,"premium");

INSERT INTO `users` (`email`, `password`, `name`, `birthDate`, `gender`, `country`, `postCode`,`type`) VALUES("bfassbindler4@rambler.ru", "kY4_<*P=s6", "Bailey Fassbindler", "1988-02-29", "male", "Portugal", "4940-352" ,"premium");


-- --------------------------------------------------------------------
-- INSERT INTO `subscriptions` (`idUser`,`startDate`,`payment`) VALUES("idUser","startDate","payment");
-- --------------------------------------------------------------------

INSERT INTO `subscriptions` (`idUser`,`startDate`,`payment`) VALUES(2, "2023-07-14","creditCard");
INSERT INTO `subscriptions` (`idUser`,`startDate`,`payment`) VALUES(3, "2023-10-10","payPal");
INSERT INTO `subscriptions` (`idUser`,`startDate`,`payment`) VALUES(4, "2023-07-07","creditCard");
INSERT INTO `subscriptions` (`idUser`,`startDate`,`payment`) VALUES(5, "2024-02-29","creditCard");

-- --------------------------------------------------------------------
-- INSERT INTO `creditCards` (`cardNumber`,`expiryDateYear`,`expiryDateMonth`, `securityCode`) VALUES(`cardNumber`,`expiryDateYear`,`expiryDateMonth`, `securityCode`);
-- --------------------------------------------------------------------

INSERT INTO `creditCards` (`idUser`, `cardNumber`,`expiryDateYear`,`expiryDateMonth`, `securityCode`) VALUES(2, 5144352075174913,2023,08, 422);
INSERT INTO `creditCards` (`idUser`, `cardNumber`,`expiryDateYear`,`expiryDateMonth`, `securityCode`) VALUES(4, 3546697730937875,2024,08, 713);
INSERT INTO `creditCards` (`idUser`, `cardNumber`,`expiryDateYear`,`expiryDateMonth`, `securityCode`) VALUES(5, 3552813150126268,2024,07, 664);


-- --------------------------------------------------------------------
-- INSERT INTO `payPal` (`idUser`,`payPalUserName`) VALUES("idUser","payPalUserName");
-- --------------------------------------------------------------------

INSERT INTO `payPal` (`idUser`,`payPalUserName`) VALUES(3,"GarvinShilliday");


-- --------------------------------------------------------------------
-- INSERT INTO `payments` (`idSubscription`,`date`, `total`, `paymentMethod`) VALUES("idSubscription","date", "total", "paymentMethod");
-- --------------------------------------------------------------------

INSERT INTO `payments` (`idSubscription`,`date`, `total`, `paymentMethod`) VALUES(1,"2023-07-14", 10.99, "creditCard");
INSERT INTO `payments` (`idSubscription`,`date`, `total`, `paymentMethod`) VALUES(2,"2023-10-10", 5.99, "payPal");
INSERT INTO `payments` (`idSubscription`,`date`, `total`, `paymentMethod`) VALUES(1,"2024-07-14", 10.99, "creditCard");
INSERT INTO `payments` (`idSubscription`,`date`, `total`, `paymentMethod`) VALUES(3,"2023-07-07", 10.99, "creditCard");
INSERT INTO `payments` (`idSubscription`,`date`, `total`, `paymentMethod`) VALUES(4,"2024-02-29", 10.99, "creditCard");


-- --------------------------------------------------------------------
-- INSERT INTO `genres` (`name`) VALUES("name");
-- --------------------------------------------------------------------

INSERT INTO `genres` (`name`) VALUES("bedroom pop");
INSERT INTO `genres` (`name`) VALUES("anime film music");
INSERT INTO `genres` (`name`) VALUES("art pop");


-- --------------------------------------------------------------------
-- INSERT INTO `artists` (`name`, `idGenre`, `image`) VALUES("name", idGenre, "image");
-- --------------------------------------------------------------------

INSERT INTO `artists` (`name`, `idGenre`, `image`) VALUES("Jordana", 1, "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/Jordana_David_Lee.jpg/600px-Jordana_David_Lee.jpg");
INSERT INTO `artists` (`name`, `idGenre`, `image`) VALUES("Joe Hisaishi", 2, "https://upload.wikimedia.org/wikipedia/commons/6/65/Joe_Hisaishi_2011.jpg");
INSERT INTO `artists` (`name`, `idGenre`, `image`) VALUES("Susanne Sundfør", 3, "https://upload.wikimedia.org/wikipedia/commons/c/c5/Susanne_Sundfør.JPG");


-- --------------------------------------------------------------------
-- INSERT INTO `albums` (`idArtist`, `title`, `publicationDate`, `coverImage`) VALUES("idArtist", "title", "publicationDate", "coverImage");
-- --------------------------------------------------------------------

INSERT INTO `albums` (`idArtist`, `title`, `publicationDate`, `coverImage`) VALUES(1, "Summer's Over", "2021-10-16", "https://f4.bcbits.com/img/a3983466830_16.jpg");
INSERT INTO `albums` (`idArtist`, `title`, `publicationDate`, `coverImage`) VALUES(2, "My Neighbor Totoro", "1999-12-01", "https://www.soundtrack.net/img/album/27936.jpg");
INSERT INTO `albums` (`idArtist`, `title`, `publicationDate`, `coverImage`) VALUES(2, "Kikujiro", "1998-01-01", "https://upload.wikimedia.org/wikipedia/en/d/de/Kikujiro-1999-poster.jpg");
INSERT INTO `albums` (`idArtist`, `title`, `publicationDate`, `coverImage`) VALUES(3, "Music for People in Trouble", "2017-09-08", "https://upload.wikimedia.org/wikipedia/en/0/0e/Music_for_People_in_Trouble.jpeg");


-- --------------------------------------------------------------------
-- INSERT INTO `songs` (`title`, `duration`, `reproductions`, `idAlbum`, `idArtist`) VALUES("title", "duration", "reproductions", "idAlbum", "idArtist") ;
-- --------------------------------------------------------------------

INSERT INTO `songs` (`title`, `duration`, `reproductions`, `idAlbum`, `idArtist`) VALUES("Summer's Over", "00:02:53", 26227846, 1, 1);

INSERT INTO `songs` (`title`, `duration`, `reproductions`, `idAlbum`, `idArtist`) VALUES("The Party's Not Over", "00:03:58", 2889096, 1, 1);

INSERT INTO `songs` (`title`, `duration`, `reproductions`, `idAlbum`, `idArtist`) VALUES("Mad Summer", "00:02:55", 645609, 2, 3);

INSERT INTO `songs` (`title`, `duration`, `reproductions`, `idAlbum`, `idArtist`) VALUES("The Dust Bunnies", "00:02:19", 74686, 2, 2);

INSERT INTO `songs` (`title`, `duration`, `reproductions`, `idAlbum`, `idArtist`) VALUES("The Village In May", "00:01:38", 4018465, 2, 2);

INSERT INTO `songs` (`title`, `duration`, `reproductions`, `idAlbum`, `idArtist`) VALUES("Mantra", "00:03:31", 2488298, 4, 3);


-- --------------------------------------------------------------------
-- INSERT INTO `playlists` (`title`, `idCreatedBy`, `creationDate`, `state`, `shared`) VALUES("title", "idCreatedBy", "creationDate", "state", "shared");
-- --------------------------------------------------------------------

INSERT INTO `playlists` (`title`, `idCreatedBy`, `creationDate`, `state`, `shared`) VALUES("My Playlist#221", 4,  "2022-01-09", "active", true);

-- --------------------------------------------------------------------
-- INSERT INTO `playlistItems` (`idPlaylist`, `idSong`, `idAddedBy`, `additionDate`) VALUES("itemId", "idPlaylist", "idSong", "idAddedBy", "additionDate");
-- --------------------------------------------------------------------

INSERT INTO `playlistItems` (`idPlaylist`, `idSong`, `idAddedBy`, `additionDate`) VALUES(1, 1, 4, "2022-01-09");
INSERT INTO `playlistItems` (`idPlaylist`, `idSong`, `idAddedBy`, `additionDate`) VALUES(1, 2, 4, "2022-01-09");
INSERT INTO `playlistItems` (`idPlaylist`, `idSong`, `idAddedBy`, `additionDate`) VALUES(1, 3, 4, "2022-04-09");
INSERT INTO `playlistItems` (`idPlaylist`, `idSong`, `idAddedBy`, `additionDate`) VALUES(1, 4, 4, "2022-04-09");
INSERT INTO `playlistItems` (`idPlaylist`, `idSong`, `idAddedBy`, `additionDate`) VALUES(1, 5, 4, "2022-04-09");
INSERT INTO `playlistItems` (`idPlaylist`, `idSong`, `idAddedBy`, `additionDate`) VALUES(1, 6, 2, "2023-10-04");



-- --------------------------------------------------------------------
-- INSERT INTO `userFollowingArtists` (`idUser`, `idArtist`) VALUES("idUser", "idArtist");
-- --------------------------------------------------------------------

INSERT INTO `userFollowingArtists` (`idUser`, `idArtist`) VALUES(1, 1);
INSERT INTO `userFollowingArtists` (`idUser`, `idArtist`) VALUES(2, 2);
INSERT INTO `userFollowingArtists` (`idUser`, `idArtist`) VALUES(1, 2);
INSERT INTO `userFollowingArtists` (`idUser`, `idArtist`) VALUES(3, 3);
INSERT INTO `userFollowingArtists` (`idUser`, `idArtist`) VALUES(1, 3);


-- --------------------------------------------------------------------
-- INSERT INTO `userFavoriteSongs` (`idUser`, `idSong`) VALUES("idUser", "idSong");
-- --------------------------------------------------------------------

INSERT INTO `userFavoriteSongs` (`idUser`, `idSong`) VALUES(4, 1);
INSERT INTO `userFavoriteSongs` (`idUser`, `idSong`) VALUES(4, 2);
INSERT INTO `userFavoriteSongs` (`idUser`, `idSong`) VALUES(4, 3);
INSERT INTO `userFavoriteSongs` (`idUser`, `idSong`) VALUES(4, 6);
INSERT INTO `userFavoriteSongs` (`idUser`, `idSong`) VALUES(1, 3);
INSERT INTO `userFavoriteSongs` (`idUser`, `idSong`) VALUES(3, 6);
INSERT INTO `userFavoriteSongs` (`idUser`, `idSong`) VALUES(2, 1);
INSERT INTO `userFavoriteSongs` (`idUser`, `idSong`) VALUES(5, 2);

-- --------------------------------------------------------------------
-- INSERT INTO `userFavoriteAlbums` (`idUser`, `idAlbum`) VALUES("idUser", "idAlbum");
-- --------------------------------------------------------------------

INSERT INTO `userFavoriteAlbums` (`idUser`, `idAlbum`) VALUES(4, 1);
INSERT INTO `userFavoriteAlbums` (`idUser`, `idAlbum`) VALUES(4, 3);
INSERT INTO `userFavoriteAlbums` (`idUser`, `idAlbum`) VALUES(1, 3);