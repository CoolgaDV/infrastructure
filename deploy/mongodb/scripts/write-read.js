
print("Insert simple document:");
printjson(db.sample.insert({
    first: "some",
    second: 42
}));

print("Expect to see document that was inserted earlier:");
db.sample.find().forEach(printjson);