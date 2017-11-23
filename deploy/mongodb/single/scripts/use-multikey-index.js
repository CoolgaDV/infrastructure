// ---
// This script should be run in mongod shell using the following command:
// load("/scripts/use-multikey-index.js")
// ---

var collection = db.getSiblingDB("sample").sample;
collection.drop();

for (var index = 0; index < 10; index++) {
    collection.insert({
        indexedField: [index + 1, index - 1],
        valueField: "value_" + index
    });
}

print("=== Creating index :");
// To create multi-key index (index on array field) no additional settings are required
printjson(collection.createIndex({ indexedField : 1 }));

print("=== Collection indexes :");
printjson(collection.getIndexes());

print("=== Query exact values :");
printjson(collection.find({ indexedField : [4, 2] }).explain({
    verbosity : "allPlansExecution"
}));

print("=== Query contains values :");
printjson(collection.find({ indexedField : 2 }).explain({
    verbosity : "allPlansExecution"
}));