// ---
// This script should be run in mongod shell using the following command:
// load("/scripts/use-compound-index-order.js")
// ---

var collection = db.getSiblingDB("sample").sample;
collection.drop();

for (var firstIndex = 0; firstIndex < 100; firstIndex++) {
    for (var secondIndex = 0; secondIndex < 10; secondIndex++) {
        collection.insert({
            firstIndexedField: firstIndex,
            secondIndexedField: secondIndex
        });
    }
}

print("=== Creating index :");
printjson(collection.createIndex({ firstIndexedField : 1, secondIndexedField : 1 }));

print("=== Collection indexes :");
printjson(collection.getIndexes());

print("=== Fast query (exact value query for first field) :");
// Pay attention to "executionStats.totalKeysExamined" value (close or equal to 5)
printjson(collection
    .find({
        firstIndexedField : 50,
        secondIndexedField : { $gte : 5 }
    })
    .explain({
        verbosity : "allPlansExecution"
    })
);

print("=== Slow query (range condition for first field) :");
// Pay attention to "executionStats.totalKeysExamined" value (about 150)
printjson(collection
    .find({
        firstIndexedField : { $lte : 50.0 },
        secondIndexedField : 5
    })
    .explain({
        verbosity : "allPlansExecution"
    })
);