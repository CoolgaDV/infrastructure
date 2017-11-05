#!/usr/bin/env bash

. ../../common/common.sh
. ../mongodb-common.sh

info "Starting compose ..."
docker-compose -f sharding-compose.yml up -d

info "Waiting for dbs ..."
wait_for_db_start 9191
wait_for_db_start 9192
wait_for_db_start 9193

info "Initializing config replica set ..."
mongo --quiet --host localhost --port 9193 --eval "rs.initiate()"

info "Waiting for router ..."
wait_for_db_start 9194

info "Connecting shards ..."
mongo --quiet --host localhost --port 9194 --eval "sh.addShard(\"shard-a:27018\")"
mongo --quiet --host localhost --port 9194 --eval "sh.addShard(\"shard-b:27018\")"