# swarm

docker swarm mode

```
make deploy
make concourse
```

```
$ DOCKER_HOST=tcp://172.17.0.1:2375 docker stack ls
NAME                SERVICES
concourse           3
$ DOCKER_HOST=tcp://172.17.0.1:2375 docker service ls
ID                  NAME                         MODE                REPLICAS            IMAGE                         PORTS
xth8snxg3qdj        concourse_concourse-db       replicated          0/1                 postgres:9.6                  
pselcrq3yzqt        concourse_concourse-web      replicated          0/1                 ksaito1125/concourse:latest   *:80->8080/tcp
u0p1j48s64uj        concourse_concourse-worker   replicated          0/1                 ksaito1125/concourse:latest   
23:28:07 ksaito@dev (master *>)$ 
```
