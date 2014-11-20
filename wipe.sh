#!/bin/sh

killall mongod
killall mongos
rm -rf data
mkdir data
clear
echo "Full wipe"
