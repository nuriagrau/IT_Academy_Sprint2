/* global use, db */
// MongoDB Playground
// To disable this template go to Settings | MongoDB | Use Default Template For Playground.
// Make sure you are connected to enable completions and to be able to run a playground.
// Use Ctrl+Space inside a snippet or a string literal to trigger completions.
// The result of the last command run in a playground is shown on the results panel.
// By default the first 20 documents will be returned with a cursor.
// Use 'console.log()' to print to the debug output.
// For more documentation on playgrounds please refer to
// https://www.mongodb.com/docs/mongodb-vscode/playgrounds/

// Select the database to use.
use('restaurants');


// 1. Escriu una consulta per mostrar tots els documents en la col·lecció Restaurants.
db.restaurant.find({}).toArray();


// 2. Escriu una consulta per mostrar el restaurant_id, name, borough i cuisine per tots els documents en la col·lecció Restaurants.

db.restaurant.find({}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1}).toArray();

// 3. Escriu una consulta per mostrar el restaurant_id, name, borough i cuisine, però exclou el camp _id per tots els documents en la col·lecció Restaurants.

db.restaurant.find({}, {_id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1}).toArray();

// 4. Escriu una consulta per mostrar restaurant_id, name, borough i zip code, però exclou el camp _id per tots els documents en la col·lecció Restaurants.

db.restaurant.find({}, {_id: 0, restaurant_id: 1, name: 1, borough: 1, "address.zipcode": 1}).toArray();

// 5. Escriu una consulta per mostrar tots els restaurants que estan en el Bronx.

db.restaurant.find({borough: "Bronx"}).toArray();

// 6. Escriu una consulta per mostrar els primers 5 restaurants que estan en el Bronx.

db.restaurant.find({borough: "Bronx"}).limit(5);

// 7. Escriu una consulta per mostrar el pròxim 5 restaurants després de saltar els primers 5 del Bronx.

db.restaurant.find({borough: "Bronx"}).skip(5).limit(5);

// 8. Escriu una consulta per trobar els restaurants que tenen un score de més de 90.
// scores individuals, scores suma o scores mitjana?

db.restaurant.find({"grades.score": {$gt: 90}});


// 9. Escriu una consulta per trobar els restaurants que tenen un score de més de 80 però menys que 100.

//NO FUNCIONA BE SURT 131

db.restaurant.find( {"grades.score": {$gte: 80, $lte: 100} } );

db.restaurant.find( { $and: [ {"grades.score": {$gte: 80}}, {"grades.score": {$lte: 100} }]} );

// SI FILTRA NO GREATER THAN
db.restaurant.find({grades: {$elemMatch: {score: {$gt: 80, $lt:100}}}});

// 10. Escriu una consulta per trobar els restaurants que es localitzen en valor de latitud menys de -95.754168.

db.restaurant.find( {"address.coord.0": {$lt: -95.754168} } );

// 11. Escriu una consulta de MongoDB per a trobar els restaurants que no preparen cap cuisine de 'American' i la seva qualificació és superior a 70 i longitud inferior a -65.754168.

db.restaurant.find( {$and: [ {cuisine:{$ne: "American "}}, {"grades.score": {$gt: 70}}, {"address.coord.1": {$lt: -65.754168}}]}) ;

// 12. Escriu una consulta per trobar els restaurants que no preparen cap cuisine de 'American' i van aconseguir un marcador més de 70 i localitzat en la longitud menys que -65.754168. Nota: Fes aquesta consulta sense utilitzar $and operador.

db.restaurant.find( { cuisine: { $nin: ["American", "American "]}, "grades.score": {$gt: 70},"address.coord.1": {$lt: -65.754168 }});


// 13. Escriu una consulta per trobar els restaurants que no preparen cap cuisine de 'American' i van obtenir un punt de grau 'A' no pertany a Brooklyn. S'ha de mostrar el document segons la cuisine en ordre descendent.


db.restaurant.find( { cuisine: { $nin: ["American", "American "]}, "grades.grade": {$eq: "A"},"borough": {$nin: ["Brooklyn"] }}).toArray();

// 14. Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que contenen 'Wil' com les tres primeres lletres en el seu nom.

db.restaurant.find({ "name": /\AWil/} , {_id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });


// 15. Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que contenen 'ces' com les últimes tres lletres en el seu nom.

db.restaurant.find({ "name": /ces\b/} , {_id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });

// 16. Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que contenen 'Reg' com tres lletres en algun lloc en el seu nom.

db.restaurant.find({ "name": /Reg/} , {_id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 });


// 17. Escriu una consulta per trobar els restaurants que pertanyen al Bronx i van preparar qualsevol plat americà o xinès.

db.restaurant.find({ borough: "Bronx", cuisine: {$in:["American", "American ", "Chinese"]}}).toArray();

// 18. Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que pertanyen a Staten Island o Queens o Bronx o Brooklyn.

db.restaurant.find({borough: { $in: ["Staten Island", "Queens", "Bronx", "Brooklyn"]}} , {_id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 }).toArray();


// 19. Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que no pertanyen a Staten Island o Queens o Bronx o Brooklyn.

db.restaurant.find({borough: { $nin: ["Staten Island", "Queens", "Bronx", "Brooklyn"]}} , {_id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1 }).toArray();

// 20. Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que aconsegueixin un marcador que no és més de 10.

db.restaurant.find({grades: {$elemMatch: {score: {$lte: 10}}}}, {restaurant_id: 1, name: 1, borough: 1, cuisine: 1}).toArray();

// 21. Escriu una consulta per trobar el restaurant_id, name, borough i cuisine per a aquells restaurants que preparen peix excepte 'American' i 'Chinees' o el name del restaurant comença amb lletres 'Wil'.

db.restaurant.find({$or:[ {$and: [ {cuisine: {$in: ["Seafood"]}}, {cuisine: {$nin: ["American", "American ", "Chinese"]}}]}, {name: /\AWil/}]}, {_id: 0, restaurant_id: 1, name: 1, borough: 1, cuisine: 1}).toArray();

// 22. Escriu una consulta per trobar el restaurant_id, name, i grades per a aquells restaurants que aconsegueixin un grau "A" i un score 11 en dades d'estudi ISODate "2014-08-11T00:00:00Z".

db.restaurant.find({grades:{ $elemMatch: {grade: "A", score: 11, date: ISODate("2014-08-11T00:00:00Z")}}}, {_id: 0, restaurant_id: 1, name: 1, grades: 1}).toArray();

// 23. Escriu una consulta per trobar el restaurant_id, name i grades per a aquells restaurants on el 2n element de varietat de graus conté un grau de "A" i marcador 9 sobre un ISODate "2014-08-11T00:00:00Z".

db.restaurant.find({"grades.1.score" : 9, "grades.1.grade" : "A", "grades.1.date": ISODate('2014-08-11T00:00:00Z')}, {_id: 0, restaurant_id: 1, name: 1, grades: 1 });


// 24. Escriu una consulta per trobar el restaurant_id, name, adreça i ubicació geogràfica per a aquells restaurants on el segon element del array coord conté un valor que és més de 42 i fins a 52.

db.restaurant.find({'address.coord.1' : {$gt: 42, $lte: 52}}, {_id: 0, restaurant_id: 1, name: 1, address: 1});


// 25. Escriu una consulta per organitzar el nom dels restaurants en ordre ascendent juntament amb totes les columnes.

db.restaurant.aggregate({ $sort : { name : 1 }}).toArray();


// 26. Escriu una consulta per organitzar el nom dels restaurants en ordre descendent juntament amb totes les columnes.

db.restaurant.aggregate({ $sort : { name : -1 }}).toArray();


// 27. Escriu una consulta per organitzar el nom de la cuisine en ordre ascendent i pel mateix barri de cuisine. Ordre descendent.

db.restaurant.aggregate({ $sort : { cuisine : 1, borough: -1 }}, {$project: {_id: 0, name: 1, cuisine: 1, borough: 1}}).toArray();

// 28. Escriu una consulta per saber totes les direccions que no contenen el carrer.

db.restaurant.find( {"address.street": null} );

// 29. Escriu una consulta que seleccionarà tots els documents en la col·lecció de restaurants on el valor del camp coord és Double.

db.restaurant.find( {"address.coord": {$type: "double"}} );

// 30. Escriu una consulta que seleccionarà el restaurant_id, name i grade per a aquells restaurants que retornin 0 com a resta després de dividir el marcador per 7.

db.restaurant.aggregate(
    [
      { $unwind: "$grades"} ,
      { $project:
         { 
            restaurant_id: 1,
            name: 1,
            "grades": 1,
            modulus: {$mod: [ "$grades.score", 7 ] } ,
            _id: 0
         }
      },
      { $match: {modulus: 0}}
    ]
 ).toArray();

// 31. Escriu una consulta per trobar el name de restaurant, borough, longitud i altitud i cuisine per a aquells restaurants que contenen 'mon' com tres lletres en algun lloc del seu nom.

db.restaurant.find({ "name": /mon/} , {_id: 0, restaurant_id: 1, name: 1, borough: 1, "address.coord": 1, cuisine: 1 }).toArray();

// 32. Escriu una consulta per trobar el name de restaurant, borough, longitud i latitud i cuisine per a aquells restaurants que contenen 'Mad' com primeres tres lletres del seu nom.

db.restaurant.find({ "name": /\AMad/} , {_id: 0, restaurant_id: 1, name: 1, borough: 1, "address.coord": 1, cuisine: 1 }).toArray();

// Print a message to the output window.
//console.log(`${salesOnApril4th} sales occurred in 2014.`);

// Here we run an aggregation and open a cursor to the results.
// Use '.toArray()' to exhaust the cursor to return the whole result set.
// You can use '.hasNext()/.next()' to iterate through the cursor page by page.
/*db.getCollection('sales').aggregate([
  // Find all of the sales that occurred in 2014.
  { $match: { date: { $gte: new Date('2014-01-01'), $lt: new Date('2015-01-01') } } },
  // Group the total sales for each product.
  { $group: { _id: '$item', totalSaleAmount: { $sum: { $multiply: [ '$price', '$quantity' ] } } } }
]);*/
