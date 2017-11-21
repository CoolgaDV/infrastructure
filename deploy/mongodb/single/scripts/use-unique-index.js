// ---
// This script should be run in mongod shell using the following command:
// load("/scripts/use-unique-index.js")
// ---

var collection = db.getSiblingDB("sample").sample;
collection.drop();

for (var index = 0; index < 1000; index++) {
    collection.insert({
        indexedField: index,
        valueField: "value_" + index
    });
}

print("=== Creating index :");
printjson(collection.createIndex({ indexedField: 1 }, { unique: true }));

print("=== Collection indexes :");
printjson(collection.getIndexes());

print("=== Simple query :");
printjson(collection.find({ indexedField: 500 }).explain({
    verbosity : "allPlansExecution"
}));

print("=== Try to insert document with duplicated index field :");
printjson(collection.insert({
    indexedField: 500,
    valueField: "some_value"
}));