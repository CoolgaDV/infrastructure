// ---
// This script should be run in mongod shell using the following command:
// load("/scripts/use-partial-index.js")
// ---

var collection = db.getSiblingDB("sample").sample;
collection.drop();

for (var index = 0; index < 10; index++) {
    collection.insert({
        indexedField: index,
        valueField: "value_" + index
    });
}

print("=== Creating index :");
printjson(collection.createIndex(
    { indexedField : 1 },
    { partialFilterExpression: { indexedField: { $gt: 5 } } }
));

print("=== Collection indexes :");
printjson(collection.getIndexes());

print("=== Query by indexed value (in indexed range) :");
// Pay attention to "IXSCAN" stage type (index is used)
printjson(collection.find({ indexedField : 7 }).explain({
    verbosity : "allPlansExecution"
}));

print("=== Query by indexed value (out of indexed range) :");
// Pay attention to "COLLSCAN" stage type (index is not used)
printjson(collection.find({ indexedField : 2 }).explain({
    verbosity : "allPlansExecution"
}));