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


db.restaurant.find({'grades.score': {$mod: [7, 0]}}, {restaurant_id: 1, name: 1, 'grades': 1}
 ).toArray();


//{ field: { $mod: [ divisor, remainder ] } }


 //db.getCollection('restaurant').find({"grades.score":{$mod:[7,0]}},{restaurant_id: 1, name: 1, grades : 1}).toArray();

 /*db.inventory.aggregate(
    [
      {
        $project:
           {
             name: 1,
             qty: 1,
             qtyEq250: { $eq: [ "$qty", 250 ] },
             _id: 0
           }
      }
    ]
 )*/

/*db.students.aggregate([
    { $unwind: "$subjects" },
    { $group: { _id: "$subjects", count: { $sum: 1 } } },
    { $sort: { count: -1 } },
    { $limit: 1 }
  ])*/

/*db.arrayExample.aggregate([
    ... {$match: {name: "Bongo"}},
    ... {$project: {
    ... firstItem: {$arrayElemAt: ["$fruits", 0]},
    ... lastItem: {$arrayElemAt: ["$fruits", -1]}}}])*/


//db.students.aggregate([{$group: {_id:"$sec", total_st: {$sum:1}, max_age:{$max:"$age"} } }])

   /* db.employees.find({
        $expr: {
          $gt: [
            "$bonus",
            { $multiply: ["$salary", 0.05] }
          ]
        }
      })*/


/*db.products.updateOne(
    { _id: 1 },
    { $mul:
       {
          price: Decimal128( "1.25" ),
          quantity: 2
        }
    }
 )*/




//db.clothing.aggregate( [ { $unwind: { path: "$sizes" } } ] )

//{ "dim_cm.1": { $gt: 25 } }



//db.nested.findOne({"level1.0":{"$in":["item00"]} })

/*db.restaurant.find({
    restaurant_id: {
      $elemMatch: { cuisine: "American ", "grades.score" : { $gt: 70 } , "address.coord.0": {$lt: -65.754168} }
    }
  });*/

  //db.restaurant.find({borough: { $ne: {"grades.score": {$gt: 10}}}}).toArray();

  //db.getCollection('restaurant').find({$or:[{$and:[{cuisine:"Seafood"},{cuisine: {$nin:['American','American ', 'Chinese']}}]},{name: /^Wil/}]},{ restaurant_id: 1, name: 1, borough: 1, cuisine:1});






 // "2012-04-16T00:00:00Z"
//db.scores.find({ results: { $elemMatch: { $gte: 80, $lt: 85 } } })

//User.aggregate([{ $match: {$expr: {$eq: [‘ID’, ‘123' ] } }]);

// , {"grades.score":{$eq: 11}}, {"grades.date": {$eq: "2014-08-11T00:00:00Z" }}]

//{"grades.date.$date": "2012-02-06T00:00:00Z" }]}

  //db.restaurant.find(
   //{ grades: { $elemMatch: {score: { $lt: 10 } } } }

//)
//publicationmonth: { $substrCP: [ "$publishedon", 0, 4 ] }

//db.users.findOne({"username" : {$regex : ".*son.*"}});


// db.restaurants.find({cuisine: {$nin: ["American", "American "]}, "grades.score": {$gt: 70}, "address.coord.1": {$lt: -65.754168}}, {grades: 0})


//{"grades.score": { $nin: [ {$lt: 70} ]} }, {"address.coord.1": { $ne: [ { $gt: -65.754168 }]}});
