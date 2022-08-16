#!/bin/sh
mongod --configsvr --dbpath ../mongodata/cfg0 --port 27018 --replSet rs0 --fork --logpath ../mongodata/cfg0.log
mongod --configsvr --dbpath ../mongodata/cfg1 --port 27019 --replSet rs0 --fork --logpath ../mongodata/cfg1.log
mongod --configsvr --dbpath ../mongodata/cfg2 --port 27020 --replSet rs0 --fork --logpath ../mongodata/cfg2.log
mongod --shardsvr --dbpath ../mongodata/a0 --port 27021 --replSet a --fork --logpath ../mongodata/a0.log
mongod --shardsvr --dbpath ../mongodata/a1 --port 27022 --replSet a --fork --logpath ../mongodata/a1.log
mongod --shardsvr --dbpath ../mongodata/a2 --port 27023 --replSet a --fork --logpath ../mongodata/a2.log
mongod --shardsvr --dbpath ../mongodata/b0 --port 27024 --replSet b --fork --logpath ../mongodata/b0.log
mongod --shardsvr --dbpath ../mongodata/b1 --port 27025 --replSet b --fork --logpath ../mongodata/b1.log
mongod --shardsvr --dbpath ../mongodata/b2 --port 27026 --replSet b --fork --logpath ../mongodata/b2.log
mongos --configdb "rs0/localhost:27018,localhost:27019,localhost:27020" --port 26000 --fork --logpath ../mongodata/thr1
mongos --configdb "rs0/localhost:27018,localhost:27019,localhost:27020" --port 26001 --fork --logpath ../mongodata/thr2
