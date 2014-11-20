#!/bin/sh

## I typically keep a bunch of mongodb versons in different folders with the install directory inside a folder called <mongo>
export WHICHMONGO=~/dev/mongo28/mongo/bin

## create data directories if they don't already exist
mkdir -p data/logs
mkdir -p data/s0/r0 data/s0/r1 data/s0/r2
mkdir -p data/s1/r0 data/s1/r1 data/s1/r2
mkdir -p data/s2/r0 data/s2/r1 data/s2/r2

## start up shard s0
$WHICHMONGO/mongod --replSet s0 --logpath "data/logs/s0r0.log" --dbpath "data/s0/r0" --port 27017 --oplogSize 32  --fork
$WHICHMONGO/mongod --replSet s0 --logpath "data/logs/s0r1.log" --dbpath "data/s0/r1" --port 27018 --oplogSize 32  --fork
$WHICHMONGO/mongod --replSet s0 --logpath "data/logs/s0r2.log" --dbpath "data/s0/r2" --port 27019 --oplogSize 32  --fork
$WHICHMONGO/mongo --port 27017 <<'EOF'
config = { "_id" : "s0", "members" : [
     { "_id" : 0, "host" : "localhost:27017" },
     { "_id" : 1, "host" : "localhost:27018" },
     { "_id" : 2, "host" : "localhost:27019" } ]
}
rs.initiate(config)
EOF

## start up shard s1
$WHICHMONGO/mongod --replSet s1 --logpath "data/logs/s1r0.log" --dbpath "data/s1/r0" --port 27027 --oplogSize 32  --fork
$WHICHMONGO/mongod --replSet s1 --logpath "data/logs/s1r1.log" --dbpath "data/s1/r1" --port 27028 --oplogSize 32  --fork
$WHICHMONGO/mongod --replSet s1 --logpath "data/logs/s1r2.log" --dbpath "data/s1/r2" --port 27029 --oplogSize 32  --fork
$WHICHMONGO/mongo --port 27027 <<'EOF'
config = { "_id" : "s1", "members" : [
     { "_id" : 0, "host" : "localhost:27027" },
     { "_id" : 1, "host" : "localhost:27028" },
     { "_id" : 2, "host" : "localhost:27029" } ]
}
rs.initiate(config)
EOF

## start up shard s2
$WHICHMONGO/mongod --replSet s2 --logpath "data/logs/s2r0.log" --dbpath "data/s2/r0" --port 27037 --oplogSize 32 --fork
$WHICHMONGO/mongod --replSet s2 --logpath "data/logs/s2r1.log" --dbpath "data/s2/r1" --port 27038 --oplogSize 32  --fork
$WHICHMONGO/mongod --replSet s2 --logpath "data/logs/s2r2.log" --dbpath "data/s2/r2" --port 27039 --oplogSize 32  --fork
$WHICHMONGO/mongo --port 27037 <<'EOF'
config = { "_id" : "s2", "members" : [
     { "_id" : 0, "host" : "localhost:27037" },
     { "_id" : 1, "host" : "localhost:27038" },
     { "_id" : 2, "host" : "localhost:27039" } ]
}
rs.initiate(config)
EOF

## start three config servers
mkdir -p ./data/cfg-a ./data/cfg-b ./data/cfg-c
$WHICHMONGO/mongod --logpath "data/logs/cfg-a.log" --dbpath ./data/cfg-a --port 57017 --fork --oplogSize 5 --configsvr
$WHICHMONGO/mongod --logpath "data/logs/cfg-b.log" --dbpath ./data/cfg-b --port 57018 --fork --oplogSize 5 --configsvr
$WHICHMONGO/mongod --logpath "data/logs/cfg-c.log" --dbpath ./data/cfg-c --port 57019 --fork --oplogSize 5 --configsvr

## start the mongos
$WHICHMONGO/mongos --port 61017 --fork  --logpath "data/logs/mongos-1.log" \
	--configdb localhost:57017,localhost:57018,localhost:57019

echo ""
echo "mongod and mongos started ... supposedly.  Connect to port 61017 to reach mongos"


