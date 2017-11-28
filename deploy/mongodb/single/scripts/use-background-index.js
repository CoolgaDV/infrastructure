// ---
// This script should be run in mongo shell using the following command:
// load("/scripts/use-background-index.js")
// ---

var collection = db.getSiblingDB("sample").sample;
collection.drop();

for (var index = 0; index < 1000000; index++) {
    collection.insert({
        indexedField: index,
        valueField: "value_" + index
    });
}

// After the data will be inserted, run index creation
// and monitor progress in another mongo console
// collection.createIndex({ indexedField : 1 }, { background : true });

// Run the following command to monitor index creation progress:
// db.currentOp();
// and pay attention on following line which demonstrates
// that background index creation is in process. See example below:
// "msg" : "Index Build (background) Index Build (background): 294201/1000000 29%"
