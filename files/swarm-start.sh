#! /bin/sh

LOG=/var/log/swarm.log
OUT=/mnt/swarm-join.sh

docker swarm init --force-new-cluster > $LOG
echo "#! /bin/sh" > $OUT
grep "docker swarm join --token " $LOG >> $OUT
