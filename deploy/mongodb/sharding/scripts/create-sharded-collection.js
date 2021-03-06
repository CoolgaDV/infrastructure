// ---
// This script should be run in mongos shell using the following command:
// load("/scripts/create-sharded-collection.js")
// ---

// Shard collection
sh.enableSharding("dbWithShardedCollection");
sh.shardCollection("dbWithShardedCollection.shardedCollection", { "shardedField" : 1 });

// Fill collection with data. 2M records should be enough to get at least one chunk on both shards.
// Default max chunk size is 64 Mb.
var collection = db.getSiblingDB("dbWithShardedCollection").shardedCollection;
for (var index = 0; index < 2000000; index++) {
    var value = index % 2 === 0 ?
        "some_meaningless_string_value_with_even_number_" + index :
        "some_meaningless_string_value_with_odd_number_" + index;
    collection.insert({
        shardedField: value
    });
}