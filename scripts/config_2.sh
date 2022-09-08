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

mongos --configdb "rs0/localhost:27100,localhost:27101,localhost:27102" --port 26000 --fork --logpath ../mongodata/th1.log
mongos --configdb "rs0/localhost:27100,localhost:27101,localhost:27102" --port 26001 --fork --logpath ../mongodata/th2.log
