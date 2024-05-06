USE `pizzeria`;

-- -----------------------------------------------------------------
-- INSERT INTO `counties` (`countyId`, `name`) VALUES(`countyId`, `name`)
-- -----------------------------------------------------------------

INSERT INTO `counties` (`countyId`, `name`) VALUES(08, "Barcelona");
INSERT INTO `counties` (`countyId`, `name`) VALUES(48, "Bizkaia");
INSERT INTO `counties` (`countyId`, `name`) VALUES(12, "Castelló");
INSERT INTO `counties` (`countyId`, `name`) VALUES(20, "Gipuzkoa");
INSERT INTO `counties` (`countyId`, `name`) VALUES(22, "Huesca");
INSERT INTO `counties` (`countyId`, `name`) VALUES(28, "Madrid");
INSERT INTO `counties` (`countyId`, `name`) VALUES(41, "Sevilla");
INSERT INTO `counties` (`countyId`, `name`) VALUES(46, "València");
INSERT INTO `counties` (`countyId`, `name`) VALUES(01, "Álava");

-- -----------------------------------------------------------------
-- INSERT INTO `towns` (`name`,`idCounty`) VALUES(`name`,`idCounty`)
-- -----------------------------------------------------------------
INSERT INTO `towns` (`name`,`idCounty`) VALUES("Valencia", 46);
INSERT INTO `towns` (`name`,`idCounty`) VALUES("Sant Cugat Del Valles", 08);
INSERT INTO `towns` (`name`,`idCounty`) VALUES("Madrid", 28);
INSERT INTO `towns` (`name`,`idCounty`) VALUES("Huesca", 22);
INSERT INTO `towns` (`name`,`idCounty`) VALUES("Madrid", 28);
INSERT INTO `towns` (`name`,`idCounty`) VALUES("Donostia-San Sebastian", 20);
INSERT INTO `towns` (`name`,`idCounty`) VALUES("Donostia-San Sebastian", 20);
INSERT INTO `towns` (`name`,`idCounty`) VALUES("Castello De La Plana", 12);
INSERT INTO `towns` (`name`,`idCounty`) VALUES("Sevilla", 41);
INSERT INTO `towns` (`name`,`idCounty`) VALUES("Vitoria-Gasteiz", 01);

-- -----------------------------------------------------------------
-- INSERT INTO `customers` (`firstName`,`lastName`,`adress`,`postCode`,`idTown`,`idCounty`,`phone`) VALUES(`firstName`,`lastName`,`adress`,`postCode`,`idTown`,`idCounty`,`phone`)
-- -----------------------------------------------------------------

INSERT INTO `customers` (`firstName`,`lastName`,`adress`,`postCode`,`idTown`,`phone`) VALUES("Letizia`","Creelman","082 Cardinal Way`","46025",1,"763-548-4195");
INSERT INTO `customers` (`firstName`,`lastName`,`adress`,`postCode`,`idTown`,`phone`) VALUES("Eirena","Lindstedt","6221 Cambridge Way","08190",2,"909-127-4066");


-- ---------------------------------------------------------------------------------------------------------------------------------------
-- INSERT INTO `shops` (`adress`,`postCode`,`idTown`,`idCounty`) VALUES(`adress`,`postCode`,`idTown`,`idCounty`) VALUES;
-- ---------------------------------------------------------------------------------------------------------------------------------------

INSERT INTO `shops` (`adress`,`postCode`,`idTown`) VALUES("11 Laurel Circle","46005",1);
INSERT INTO `shops` (`adress`,`postCode`,`idTown`) VALUES("7 Forest Dale Road","08190",2);


-- -----------------------------------------------------------------
-- INSERT INTO `employees` (`firstName`,`lastName`,`NIF`,`phone`, `position`,`idShop`) VALUES(`firstName`,`lastName`,`NIF`,`phone`, `position`,`shop`)
-- -----------------------------------------------------------------
INSERT INTO `employees` (`firstName`,`lastName`,`NIF`,`phone`, `position`,`idShop`) VALUES("Jarred", "Finding", "00000000T", "149-827-5742", "delivery", 1);
INSERT INTO `employees` (`firstName`,`lastName`,`NIF`,`phone`, `position`,`idShop`) VALUES("Jeannette", "Dillow", "99999999A", "575-766-2950", "kitchen", 2);


-- ---------------------------------------------------------
-- INSERT INTO `pizzaCategories (`name`) VALUES(`name`)
-- ---------------------------------------------------------

INSERT INTO `pizzaCategories` (`name`) VALUES("classiques");
INSERT INTO `pizzaCategories` (`name`) VALUES("vegetarianes");
INSERT INTO `pizzaCategories` (`name`) VALUES("especials");

-- -------------------------------------------------------------------------------
-- INSERT INTO `products` (`type`, `name`,`price`, `idCategory`) VALUES(`type`, `name`,`price`, `idCategory`)
-- -------------------------------------------------------------------------------
-- "pizza", "burger", "drink"

INSERT INTO `products` (`type`, `name`,`price`, `idCategory`) VALUES("pizza", "margueritta", 9.90, 1);
INSERT INTO `products` (`type`, `name`,`price`) VALUES("burger", "cheeseBurguer", 3.50);
INSERT INTO `products` (`type`, `name`,`price`) VALUES("burger", "chickenBurguer", 4.00);
INSERT INTO `products` (`type`, `name`,`price`) VALUES("drink", "coke", 2.00);

-- -------------------------------------------------------------------------------------------------------
-- INSERT INTO `orders` (`idShop`, `idCustomer`, `idOrderTaker`,`delivery`) VALUES(`idShop`, `idCustomer`, `idOrderTaker`,`delivery`);
-- -------------------------------------------------------------------------------------------------------

INSERT INTO `orders` (`idShop`, `idCustomer`, `idOrderTaker`,`delivery`) VALUES (2, 1, 1, "home");
INSERT INTO `orders` (`idShop`, `idCustomer`, `idOrderTaker`,`delivery`) VALUES (2, 2, 1, "shop");

-- -------------------------------------------------------------------------------------------------------
-- INSERT INTO `orderLines` (`idOrder`,`idProduct`, `quantity`) VALUES (`idOrder`,`idProduct`, `quantity`);
-- -------------------------------------------------------------------------------------------------------

INSERT INTO `orderLines` (`idOrder`,`idProduct`, `quantity`) VALUES (2, 1, 1);
INSERT INTO `orderLines` (`idOrder`,`idProduct`, `quantity`) VALUES (2, 3, 1);
INSERT INTO `orderLines` (`idOrder`,`idProduct`, `quantity`) VALUES (1, 3, 1);
INSERT INTO `orderLines` (`idOrder`,`idProduct`, `quantity`) VALUES (1, 2, 1);
INSERT INTO `orderLines` (`idOrder`,`idProduct`, `quantity`) VALUES (1, 4, 2);



-- calculation of price order

-- UPDATE comandes SET preu_total = (SELECT SUM(linies_comanda.quantitat * productes.preu) FROM -- linies_comanda
-- INNER JOIN productes ON linies_comanda.producte=productes.producte_id 
-- WHERE comanda=comandes.comanda_id GROUP BY comanda);


UPDATE orders SET totalPrice = (SELECT SUM(orderLines.quantity * products.price) FROM orderLines
INNER JOIN products ON orderLines.idProduct=products.productId 
WHERE idOrder=orders.orderId GROUP BY idOrder);


-- After creating commanda_linies make query of quantity of each type of products
-- UPDATE comandes SET quantitat_pizzes = (SELECT SUM(linies_comanda.quantitat) FROM linies_comanda
-- INNER JOIN productes ON linies_comanda.producte=productes.producte_id
-- WHERE comanda=comandes.comanda_id AND productes.tipus LIKE "pizza" GROUP BY comanda);

UPDATE orders SET pizzasQuantity = (SELECT SUM(orderLines.quantity) FROM orderLines
INNER JOIN products ON orderLines.idProduct=products.productId
WHERE idOrder=orders.orderId AND products.type LIKE "pizza" GROUP BY idOrder);


-- UPDATE comandes SET quantitat_hambugueses = (SELECT SUM(quantitat) FROM linies_comanda
-- INNER JOIN productes ON linies_comanda.producte=productes.producte_id
-- WHERE comanda=comandes.comanda_id AND productes.tipus LIKE"hamburguesa" GROUP BY comanda);

UPDATE orders SET burgersQuantity = (SELECT SUM(orderLines.quantity) FROM orderLines
INNER JOIN products ON orderLines.idProduct=products.productId
WHERE idOrder=orders.orderId AND products.type LIKE"burger" GROUP BY idOrder);

-- UPDATE comandes SET quantitat_begudes = 
-- (SELECT SUM(quantitat) FROM linies_comanda
-- INNER JOIN productes ON linies_comanda.producte=productes.producte_id
-- WHERE comanda=comandes.comanda_id AND productes.tipus LIKE "beguda" GROUP BY comanda);

UPDATE orders SET drinksQuantity = (SELECT SUM(orderLines.quantity) FROM orderLines
INNER JOIN products ON orderLines.idProduct=products.productId
WHERE idOrder=orders.orderId AND products.type LIKE "drink" GROUP BY idOrder);