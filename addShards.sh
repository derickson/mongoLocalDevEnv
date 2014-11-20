#!/bin/sh

## I typically keep a bunch of mongodb versons in different folders with the install directory inside a folder called <mongo>
export WHICHMONGO=~/dev/mongo28/mongo/bin

$WHICHMONGO/mongo --port 61017 <<'EOF'
db.adminCommand( { "addshard" : "s0/localhost:27017" } ) ;
db.adminCommand( { "addshard" : "s1/localhost:27027" } ) ;
db.adminCommand( { "addshard" : "s2/localhost:27037" } ) ;
EOF

echo ""
echo "added shards?"