## examples to be copy and pasted into a mongo shell connected to the mongos
## examples show various sharding setups


================
./mongo/bin/mongo --port 61017 
=============
db.adminCommand( { "addshard" : "s0/localhost:27017" } ) ;
db.adminCommand( { "addshard" : "s1/localhost:27027" } ) ;
db.adminCommand( { "addshard" : "s2/localhost:27037" } ) ;
db.adminCommand( { "enablesharding" : "test" } ) ;
db.adminCommand( { "shardcollection" : "test.test", "key" : { "_id" : "hashed"},  "numInitialChunks":32 }  ) ;
for(var i = 0; i<=100000; i+=1){
	db.test.insert({_id:i, num: Math.random()});
}


db.adminCommand( { "enablesharding" : "atfpy2" } ) ;
db.adminCommand( { "shardcollection" : "atfpy2.atf", "key" : { "_id" : "hashed"},  "numInitialChunks":32 }  ) ;


#!/bin/sh

./mongo/bin/mongo --port 61017 <<'EOF'
db.adminCommand( { "addshard" : "s0/localhost:27017" } ) ;
db.adminCommand( { "addshard" : "s1/localhost:27027" } ) ;
db.adminCommand( { "addshard" : "s2/localhost:27037" } ) ;
db.adminCommand( { "enablesharding" : "test" } ) ;
db.adminCommand( { "shardcollection" : "test.test", "key" : { "_id" : 1 } } ) ;


for (var i= 0; i< 100000; i += 1000){
	sh.splitAt( "test.test", { "_id": i } );
	sl
}

for(var i = 0; i<=100000; i+=1){
	db.test.insert({_id:i, num: Math.random()});
}



db.adminCommand( { "enablesharding" : "digg" } ) ;
db.adminCommand( { "shardcollection" : "digg.stories", "key" : { "_id" : 1  } } ) ;



db.adminCommand( { "shardcollection" : "test.test", "key" : { "_id" : "hashed" } } ) ;

db.adminCommand( { "enablesharding" : "twitter" } ) ;
db.adminCommand( { "shardcollection" : "twitter.tweets", "key" : { "user.screen_name" : "hashed" } } ) ;
EOF
- Windows users should use --oplogSize 100 (initializes to 100MB) since Windows users always have problems with the 5% free disk space allocation

~/dev/mongo26/mongo/bin/mongoimport --port 61017 -d twitter -c tweets twitter.json











db.adminCommand( { "addshard" : "microme:27007" } ) ;
db.adminCommand( { "addshard" : "microme:27017" } ) ;
db.adminCommand( { "addshard" : "microme:27027" } ) ;
db.adminCommand( { "addshard" : "microme:27037" } ) ;
db.adminCommand( { "addshard" : "microme:27047" } ) ;
db.adminCommand( { "addshard" : "microme:27057" } ) ;
db.adminCommand( { "addshard" : "microme:27067" } ) ;
db.adminCommand( { "addshard" : "microme:27077" } ) ;
db.adminCommand( { "enablesharding" : "test" } ) ;
db.adminCommand( { "shardcollection" : "test.test", "key" : { "_id" : "hashed" }, "numInitialChunks":32 } ) ;




./mongo/bin/mongos --port 61017 --fork --noAutoSplit --logpath "mongos-1.log" --configdb localhost:57017,localhost:57018,localhost:57019
	
./mongo/bin/mongo --port 61017
db.adminCommand( { "addshard" : "s0/localhost:27017" } ) ;
db.adminCommand( { "addshard" : "s1/localhost:27027" } ) ;
db.adminCommand( { "addshard" : "s2/localhost:27037" } ) ;
sh.setBalancerState(false);
db.adminCommand( { "enablesharding" : "test" } ) ;
db.adminCommand( { "shardcollection" : "test.test", "key" : { "_id" : 1 } } ) ;
for(var i = 0; i<=1000; i+=100){ sh.splitAt( "test.test", { "_id": i } ); }
for(var i = 1; i< 1100; i++) { db.test.insert( { _id: i, data: "data"} ); }
db.adminCommand( { moveChunk : "test.test", find : {_id : 50}, to : "s0" } );
db.adminCommand( { moveChunk : "test.test", find : {_id : 150}, to : "s1" } );
db.adminCommand( { moveChunk : "test.test", find : {_id : 250}, to : "s2" } );
db.adminCommand( { moveChunk : "test.test", find : {_id : 350}, to : "s0" } );
db.adminCommand( { moveChunk : "test.test", find : {_id : 450}, to : "s1" } );
db.adminCommand( { moveChunk : "test.test", find : {_id : 550}, to : "s2" } );
db.adminCommand( { moveChunk : "test.test", find : {_id : 650}, to : "s0" } );
db.adminCommand( { moveChunk : "test.test", find : {_id : 750}, to : "s1" } );
db.adminCommand( { moveChunk : "test.test", find : {_id : 850}, to : "s2" } );
db.adminCommand( { moveChunk : "test.test", find : {_id : 950}, to : "s0" } );
db.adminCommand( { moveChunk : "test.test", find : {_id : 1050}, to : "s1" } );








