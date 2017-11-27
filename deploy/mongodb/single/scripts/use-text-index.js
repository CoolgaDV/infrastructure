// ---
// This script should be run in mongo shell using the following command:
// load("/scripts/use-text-index.js")
// ---

var collection = db.getSiblingDB("sample").sample;
collection.drop();

collection.insert({ comment: "Lorem ipsum dolor sit amet, consectetur adipiscing elit" });
collection.insert({ comment: "The quick brown fox jumps over the lazy dog" });

print("=== Creating index :");
printjson(collection.createIndex({ comment : "text" }));

print("=== Collection indexes :");
printjson(collection.getIndexes());

print("=== Text query :");
printjson(collection.find({ $text: { $search: "BROWN" } }).explain({
    verbosity : "allPlansExecution"
}));