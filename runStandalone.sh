#!/bin/sh

mkdir -p data/standalone

## I typically keep a bunch of mongodb versons in different folders with the install directory inside a folder called <mongo>
export WHICHMONGO=~/dev/mongo28/mongo/bin

## Standard
$WHICHMONGO/mongod --logpath standalone.log --dbpath data/standalone --smallfiles --fork --port 27017 --oplogSize 64

## WiredTiger in 2.8
## $WHICHMONGOD --logpath standalone.log --dbpath data/standalone --smallfiles --fork --port 27017 --storageEngine wiredtiger --oplogSize 64