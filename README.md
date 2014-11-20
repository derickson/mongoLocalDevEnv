* Don't forget to configure the WHICHMONGO at the top of each script
* for a standalone mongod run ./runStandalone.sh
* for a simulated 3X3 cluser run ./startShard.sh  then after all the machines have started run ./addShards.sh 
* careful ./wipe.sh tears down, stopping ALL mognod processes on your machine with a killall and deleting all data and logs !!!!
