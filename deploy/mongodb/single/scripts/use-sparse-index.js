// ---
// This script should be run in mongod shell using the following command:
// load("/scripts/use-sparse-index.js")
// ---

var collection = db.getSiblingDB("sample").sample;
collection.drop();

for (var index = 0; index < 10000; index++) {
    collection.insert(index % 2 === 0 ?
        { indexedField: index, valueField: "value_" + index } :
        { valueField: "value_" + index });
}

print("=== Creating plain index :");
collection.createIndex({ indexedField : 1 });

print("=== Collection indexes :");
printjson(collection.getIndexes());

print("=== Total index size :");
printjson(collection.totalIndexSize());

collection.dropIndex({ indexedField : 1 });

print("=== Creating sparse index :");
collection.createIndex({ indexedField : 1 }, { sparse : true });

print("=== Collection indexes :");
printjson(collection.getIndexes());

print("=== Total index size :");
// Pay attention to the fact that this value is less than for non-sparse index
printjson(collection.totalIndexSize());