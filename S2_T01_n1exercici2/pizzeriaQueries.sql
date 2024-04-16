
-- Llista quants productes de categoria 'Begudes' s'han venut en una determinada localitat.
SELECT SUM(orders.drinksQuantity) FROM orders 
INNER JOIN shops ON orders.idShop=shops.shopId 
JOIN towns ON towns.townId=shops.iDtown WHERE towns.name LIKE "Sant Cugat del Valles";


-- Llista quantes comandes ha efectuat un determinat empleat/da.
SELECT COUNT(orderId) FROM orders
INNER JOIN employees ON orders.idOrderTaker=employees.employeId
WHERE employees.firstName LIKE "Jarred";