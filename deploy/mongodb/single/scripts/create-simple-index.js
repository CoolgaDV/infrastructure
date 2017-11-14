// ---
// This script should be run in mongod shell using the following command:
// load("/scripts/create-simple-index.js")
// ---

var collection = db.getSiblingDB("sample").sample;

for (var index = 0; index < 1000; index++) {
    collection.insert({
        indexedField: index,
        valueField: "value_" + index
    });
}

collection.createIndex({ indexedField : 1 });

print("=== Query by value :");
// Pay attention to "COLLSCAN" stage type
printjson(collection.find({ valueField : "value_500" }).explain({
    verbosity : "allPlansExecution"
}));

print("=== Query by index :");
// Pay attention to "IXSCAN" stage type
printjson(collection.find({ indexedField : 500 }).explain({
    verbosity : "allPlansExecution"
}));

var id = collection.findOne({ indexedField : 500 })._id;

print("=== Query by identifier :");
// Pay attention to "IDHACK" stage type (performance optimisation for search by _id field)
printjson(collection.find({ _id : id }).explain({
    verbosity : "allPlansExecution"
}));