#!/bin/bash

mongod --configsvr --dbpath ../mongodata/cfg0 --port 27100 --replSet rs0 --fork --logpath ../mongodata/cfg0.log
mongod --configsvr --dbpath ../mongodata/cfg1 --port 27101 --replSet rs0 --fork --logpath ../mongodata/cfg1.log
mongod --configsvr --dbpath ../mongodata/cfg2 --port 27102 --replSet rs0 --fork --logpath ../mongodata/cfg2.log

mongod --shardsvr --dbpath ../mongodata/a0 --port 27200 --replSet a --fork --logpath ../mongodata/a0.log
mongod --shardsvr --dbpath ../mongodata/a1 --port 27201 --replSet a --fork --logpath ../mongodata/a1.log
mongod --shardsvr --dbpath ../mongodata/a2 --port 27202 --replSet a --fork --logpath ../mongodata/a2.log

mongod --shardsvr --dbpath ../mongodata/b0 --port 27300 --replSet b --fork --logpath ../mongodata/b0.log
mongod --shardsvr --dbpath ../mongodata/b1 --port 27301 --replSet b --fork --logpath ../mongodata/b1.log
mongod --shardsvr --dbpath ../mongodata/b2 --port 27302 --replSet b --fork --logpath ../mongodata/b2.log

mongosh localhost:27100 <<EOF
rs.initiate({
  configsvr: true,
  _id: "rs0",
  members: [
    { _id: 0, host : 'localhost:27100' },
    { _id: 1, host : 'localhost:27101' },
    { _id: 2, host : 'localhost:27102' },
  ]
});
EOF

mongosh localhost:27200 <<EOF
rs.initiate({
  _id: "a",
  members: [
    { _id: 0, host : 'localhost:27200' },
    { _id: 1, host : 'localhost:27201' },
    { _id: 2, host : 'localhost:27202' },
  ]
});
EOF

mongosh localhost:27300 <<EOF
rs.initiate({
  _id: "b",
  members: [
    { _id: 0, host : 'localhost:27300' },
    { _id: 1, host : 'localhost:27301' },
    { _id: 2, host : 'localhost:27302' },
  ]
});
EOF

mongos --configdb "rs0/localhost:27100,localhost:27101,localhost:27102" --port 26000 --fork --logpath ../mongodata/th1.log
mongos --configdb "rs0/localhost:27100,localhost:27101,localhost:27102" --port 26001 --fork --logpath ../mongodata/th2.log

mongosh localhost:26000 <<EOF
sh.addShard("a/localhost:27200,localhost:27201,localhost:27202")
sh.addShard("b/localhost:27300,localhost:27301,localhost:27302")
sh.enableSharding("url_shortener_development")
sh.shardCollection("url_shortener_development.urls", { datacenter_id: 1  })
sh.splitAt("url_shortener_development.url", { datacenter_id: 8  })
EOF