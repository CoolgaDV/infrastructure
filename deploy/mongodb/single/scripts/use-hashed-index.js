// ---
// This script should be run in mongo shell using the following command:
// load("/scripts/use-hashed-index.js")
// ---

var collection = db.getSiblingDB("sample").sample;
collection.drop();

for (var index = 0; index < 1000; index++) {
    collection.insert({
        stringField: "value_" + index,
        integerField: index,
        floatingField: index / 10,
        arrayField: [ index - 1, index, index + 1 ]
    });
}

// Hashed indexes does not support array fields
print("=== Try to create hashed index on array field :");
printjson(collection.createIndex({ arrayField : "hashed" }));

// Hashed index entries cannot be part of compound index
print("=== Try to create compound index with hashed entry :");
printjson(collection.createIndex({ stringField : "hashed", integerField : 1 }));

print("=== Creating indexes for single fields :");
printjson(collection.createIndex({ stringField : "hashed" }));
printjson(collection.createIndex({ integerField : "hashed" }));
printjson(collection.createIndex({ floatingField : "hashed" }));

print("=== Collection indexes :");
printjson(collection.getIndexes());

// Finding by single value use hashed index.
// Pay attention to "IXSCAN" stage type
print("=== Finding by single value :");
printjson(collection.find({ stringField : "value_100" }).explain({
    verbosity : "allPlansExecution"
}));

// Finding by range doesn't use hashed index.
// Pay attention to "COLLSCAN" stage type
print("=== Finding by range query :");
printjson(collection.find({ integerField : { $gt : 450, $lt : 550 } }).explain({
    verbosity : "allPlansExecution"
}));

// In hashed indexes on decimal fields only integer part is used.
// Pay attention to the following lines:
//   "totalDocsExamined" : 10
//   "nReturned" : 1
// So we fetch 10 documents by index and then scan them to find only one by value
print("=== Finding by floating point value :");
printjson(collection.find({ floatingField : 10.5 }).explain({
    verbosity : "allPlansExecution"
}));