// ---
// This script should be run in mongo shell using the following command:
// load("/scripts/use-2d-index.js")
// ---

var collection = db.getSiblingDB("sample").sample;
collection.drop();

for (var index = 0; index < 10; index++) {
    collection.insert({
        indexedField: [index, index],
        valueField: "value_" + index
    });
}

print("=== Creating index :");
printjson(collection.createIndex({ indexedField : "2d" }));

print("=== Collection indexes :");
printjson(collection.getIndexes());

print("=== Running geo query :");
printjson(collection.find({
    indexedField : { $geoWithin : { $box : [ [2, 2], [4, 4] ] } }
}).explain());