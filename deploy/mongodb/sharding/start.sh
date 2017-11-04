#!/usr/bin/env bash

function wait_for_db_start() {
    port=$1
    for i in `seq 1 10`; do
        mongo --quiet --host localhost --port ${port} --eval "db" &>/dev/null
        if [ $? -eq 0 ]
        then
            return
        fi
        sleep 1s
    done
    info "Unable to connect to DB on port ${port}"
    exit 1
}

function info() {
    echo ">>> ${1}"
}

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