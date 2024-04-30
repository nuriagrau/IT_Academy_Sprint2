db.createCollection('CulDampolla', {validator: {$jsonSchema: {bsonType: 'object',title: 'CulDampolla',required: ['name','adress','telephone','email','registerDate'],properties:{name:{bsonType: 'string'},adress:{bsonType: 'object',title: 'object',required: ['street','number','postCode','country'],properties:{street:{bsonType: 'string'},number:{bsonType: 'string'},floor:{bsonType: 'string'},door:{bsonType: 'string'},city/town:{bsonType: 'string'},postCode:{bsonType: 'string'},country:{bsonType: 'string'}}},telephone:{bsonType: 'string'},email:{bsonType: 'string'},registerDate:{bsonType: 'date'},shoppings:{bsonType: 'array',items:{title: 'object',required: ['idVendor','orderDate','product'],properties:{idVendor:{bsonType: 'int'},orderDate:{bsonType: 'date'},product:{bsonType: 'array',items:{title: 'object',properties:{glasses:{bsonType: 'object',title: 'object',required: ['graduation','glassColour','frameType'],properties:{graduation:{bsonType: 'object',title: 'object',required: ['left','right'],properties:{left:{bsonType: 'string'},right:{bsonType: 'string'}}},glassColour:{bsonType: 'object',title: 'object',required: ['left','right'],properties:{left:{bsonType: 'string'},right:{bsonType: 'string'}}},frameType:{bsonType: 'string'},price:{bsonType: 'decimal'}}},lenses:{bsonType: 'object',title: 'object'},other:{bsonType: 'string'}}}}}}}}}}});