db.createCollection('chanels', {validator: {$jsonSchema: {bsonType: 'object',title: 'chanels',required: ['name','description','creationDate','idCreatedBy'],properties:{name:{bsonType: 'string'},description:{bsonType: 'string'},creationDate:{bsonType: 'date'},idCreatedBy:{bsonType: 'objectId'}}}}});