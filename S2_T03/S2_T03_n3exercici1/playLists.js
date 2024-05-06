db.createCollection('playLists', {validator: {$jsonSchema: {bsonType: 'object',title: 'playLists',required: ['name','publishedBy','creationDate','state','videos'],properties:{name:{bsonType: 'string'},publishedBy:{bsonType: 'objectId'},creationDate:{bsonType: 'timestamp'},state:{enum: ["public", "private"]},videos:{bsonType: 'array',items:{title: 'object',required: ['title','size','fileName','duration','thumbnail','reproductions','state','chanel'],properties:{title:{bsonType: 'string'},description:{bsonType: 'string'},size:{bsonType: 'string'},fileName:{bsonType: 'string'},duration:{bsonType: 'string'},thumbnail:{bsonType: 'string'},reproductions:{bsonType: 'int'},likesCount:{bsonType: 'int'},dislikesCount:{bsonType: 'int'},state:{enum: ["public", "hidden", "private"]},chanel:{bsonType: 'object',title: 'object',required: ['name','user'],properties:{name:{bsonType: 'string'},description:{bsonType: 'string'},creationDate:{bsonType: 'string'},user:{bsonType: 'object',title: 'object',required: ['name','email','password','birthDate','gender','country','postCode','mySubscriptions'],properties:{name:{bsonType: 'string'},email:{bsonType: 'string'},password:{bsonType: 'string'},birthDate:{bsonType: 'date'},gender:{enum: ["female", "male", "notRelevant"]},country:{bsonType: 'string'},postCode:{bsonType: 'string'},mySubscriptions:{bsonType: 'objectId'}}}}},tags:{
  bsonType: 'array',items:{bsonType: 'string'}},subscribers:{
  bsonType: 'array',items:{bsonType: 'objectId'}}}}}}}}});