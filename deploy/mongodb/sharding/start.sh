#!/usr/bin/env bash

. ../../common/common.sh
. ../mongodb-common.sh

info "Starting compose ..."
docker-compose -f sharding-compose.yml up -d

info "Waiting for dbs ..."
wait_for_docker_compose_db_start sharding-compose.yml shard-a 27018
wait_for_docker_compose_db_start sharding-compose.yml shard-b 27018
wait_for_docker_compose_db_start sharding-compose.yml config-server 27019

info "Initializing config replica set ..."
mongo --quiet --host localhost --port 9193 --eval "rs.initiate()"

info "Waiting for router ..."
wait_for_docker_compose_db_start sharding-compose.yml router 27017

info "Connecting shards ..."
mongo --quiet --host localhost --port 9194 --eval "sh.addShard(\"shard-a:27018\")"
mongo --quiet --host localhost --port 9194 --eval "sh.addShard(\"shard-b:27018\")"