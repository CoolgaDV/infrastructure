// ---
// This script should be run in mongos shell using the following command:
// load("/scripts/get-chunks-stats.js")
// ---

var chunks = db.getSiblingDB("config").chunks.find({
    "ns" : "dbWithShardedCollection.shardedCollection"
});

chunks.forEach(function(chunk) {
    var max = chunk.max.shardedField;
    var min = chunk.min.shardedField;
    var documentsCount = db.getSiblingDB("dbWithShardedCollection").shardedCollection.count({
        shardedField : { "$lt" : max, "$gt" : min }
    });
    printjson({
        id : chunk._id,
        min : min,
        max : max,
        shard : chunk.shard,
        documentsCount : documentsCount
    });
});