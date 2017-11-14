// ---
// This script should be run in mongod shell using the following command:
// load("/scripts/use-compound-index-sort.js")
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

print("=== Fast sort :");
// Pay attention to absence of "SORT" stage
printjson(collection
    .find({
        firstIndexedField : { $gte : 50 },
        secondIndexedField : { $gte : 5 }
    })
    .sort({
        firstIndexedField : 1,
        secondIndexedField : 1
    })
    .explain({
        verbosity : "allPlansExecution"
    })
);

print("=== Slow sort :");
// Pay attention to presence of "SORT" stage
printjson(collection
    .find({
        firstIndexedField : { $gte : 50 },
        secondIndexedField : { $gte : 5 }
    })
    .sort({
        firstIndexedField : 1,
        secondIndexedField : -1
    })
    .explain({
        verbosity : "allPlansExecution"
    })
);