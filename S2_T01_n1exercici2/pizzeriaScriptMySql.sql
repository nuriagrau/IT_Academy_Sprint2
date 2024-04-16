DROP SCHEMA IF EXISTS `pizzeria`;

CREATE SCHEMA IF NOT EXISTS `pizzeria` DEFAULT CHARACTER SET utf8 ;

CREATE TABLE IF NOT EXISTS `pizzeria`.`counties` (
	`countyId` INT(11) NOT NULL,
    `name`VARCHAR(45) NULL DEFAULT NULL,
    PRIMARY KEY (`countyId`)
)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`towns` (
  `townId` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  `idCounty` INT(11) NOT NULL,
  PRIMARY KEY (`townId`),
  FOREIGN KEY (`idCounty`)
    REFERENCES `pizzeria`.`counties` (`countyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`customers` (
  `customerId` INT(11) NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(45) NOT NULL,
  `adress` VARCHAR(80) NOT NULL,
  `postCode` VARCHAR(5) NOT NULL,
  `idTown` INT(11) NOT NULL,
  `idCounty` INT(11) NOT NULL,
  `phone` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`customerId`),
  FOREIGN KEY (`idTown`)
    REFERENCES `pizzeria`.`towns` (`townId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY (`idCounty`)
    REFERENCES `pizzeria`.`counties` (`countyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`pizzaCategories` (
  `categoryId` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL DEFAULT NULL,
  PRIMARY KEY (`categoryId`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`products` (
  `productId` INT(11) NOT NULL AUTO_INCREMENT,
  `type` ENUM("pizza", "burger", "drink") NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `price` FLOAT(11) NOT NULL,
  `idCategory` INT(11) DEFAULT NULL,
  PRIMARY KEY (`productId`),
  FOREIGN KEY (`idCategory`)
    REFERENCES `pizzeria`.`pizzaCategories` (`categoryId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS `pizzeria`.`productDetails` (
  `idProduct` INT(11) NOT NULL,
  `description` LONGTEXT NULL DEFAULT NULL,
  `image` BLOB NULL DEFAULT NULL,
  PRIMARY KEY (`idProduct`),
  FOREIGN KEY (`idProduct`)
    REFERENCES `pizzeria`.`products` (`productId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS `pizzeria`.`shops` (
  `shopId` INT(11) NOT NULL AUTO_INCREMENT,
  `adress` VARCHAR(80) NOT NULL,
  `postCode` VARCHAR(5) NOT NULL,
  `Idtown` INT(11) NOT NULL,
  `IdCounty` INT(11) NOT NULL,
  PRIMARY KEY (`shopId`),
  FOREIGN KEY (`Idtown`)
    REFERENCES `pizzeria`.`towns` (`townId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY (`IdCounty`)
    REFERENCES `pizzeria`.`counties` (`countyId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`employees` (
  `employeId` INT(11) NOT NULL AUTO_INCREMENT,
  `firstName` VARCHAR(45) NOT NULL,
  `lastName` VARCHAR(80) NOT NULL,
  `NIF` VARCHAR(9) NOT NULL,
  `phone` VARCHAR(45) NOT NULL,
  `position` ENUM("kitchen", "delivery") NOT NULL,
  `IdShop` INT(11) NOT NULL,
  PRIMARY KEY (`employeId`),
  FOREIGN KEY (`idShop`)
    REFERENCES `pizzeria`.`shops` (`shopId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`orders` (
  `orderId` INT(11) NOT NULL AUTO_INCREMENT,
  `idShop` INT(11) NOT NULL,
  `idCustomer` INT(11) NULL DEFAULT NULL,
  `idOrderTaker` INT(11) NOT NULL,
  `orderDate` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `delivery` ENUM("home", "shop") NOT NULL,
  `pizzasQuantity` INT(11),
  `burgersQuantity` INT(11),
  `drinksQuantity` INT(11),
  `totalPrice` FLOAT(11),
  PRIMARY KEY (`orderId`),
  FOREIGN KEY (`idShop`)
    REFERENCES `pizzeria`.`shops` (`shopId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY (`idOrderTaker`)
    REFERENCES `pizzeria`.`employees` (`employeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY (`idCustomer`)
    REFERENCES `pizzeria`.`customers` (`customerId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

CREATE TABLE IF NOT EXISTS `pizzeria`.`orderLines` (
  `idOrder` INT(11) NOT NULL,
  `line` INT(11) NOT NULL AUTO_INCREMENT,
  `idProduct` INT(11) NOT NULL,
  `quantity` INT(11) NOT NULL,
  PRIMARY KEY (`line`, `idOrder`),
  FOREIGN KEY (`idOrder`)
    REFERENCES `pizzeria`.`orders` (`orderId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY (`idProduct`)
    REFERENCES `pizzeria`.`products` (`productId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


CREATE TABLE IF NOT EXISTS `pizzeria`.`homeDelivery` (
  `idOrder` INT(11) NOT NULL,
  `deliveryGuy` INT(11) NULL DEFAULT NULL,
  `status` ENUM("pending", "delivered", "cancelled") NULL DEFAULT NULL,
`deliveryTime` DATETIME GENERATED ALWAYS AS (`status`="delivered"),
  PRIMARY KEY (`idOrder`),
  FOREIGN KEY (`idOrder`)
    REFERENCES `pizzeria`.`orders` (`orderId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  FOREIGN KEY (`deliveryGuy`)
    REFERENCES `pizzeria`.`employees` (`employeId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;