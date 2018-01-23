all:

## Swarm cluster deploy ##
N=1
MANAGER=docker-compose exec manager
NODE=docker-compose exec --index=$(N) node

deploy:
	-$(MAKE) rm
	$(MAKE) up
	$(MAKE) swarm-start
	$(MAKE) swarm-join

up:
	docker-compose up -d

swarm-start:
	docker cp files/swarm-start.sh swarm_manager_1:/mnt
	$(MANAGER) chmod +x /mnt/swarm-start.sh
	$(MANAGER) /mnt/swarm-start.sh
	$(MANAGER) cat /mnt/swarm-join.sh
	docker cp swarm_manager_1:/mnt/swarm-join.sh .

swarm-join:
	-$(NODE) docker swarm leave
	docker cp swarm-join.sh swarm_node_$(N):/mnt
	$(NODE) chmod +x /mnt/swarm-join.sh
	$(NODE) /mnt/swarm-join.sh

rm:
	-docker-compose stop
	-docker-compose rm -f

## Swarm operation
SERVER=$(shell ip route | head -1 | cut -d' ' -f 3)
SWARM=DOCKER_HOST=tcp://$(SERVER):2375 docker

ps:
	docker-compose ps
	@echo manager ps
	docker exec swarm_manager_1 docker ps
	@echo node ps
	docker exec swarm_node_1 docker ps

node-ls:
	@$(SWARM) node ls

stack-ls:
	@$(SWARM) stack ls

service-ls:
	@$(SWARM) service ls

concourse:
	@$(SWARM) stack deploy concourse -c sample/docker-compose.yml
