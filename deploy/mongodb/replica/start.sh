#!/usr/bin/env bash

function wait_for_db_start() {
    port=$1
    for i in `seq 1 10`; do
        mongo --quiet --host localhost --port ${port} --eval db &>/dev/null
        if [ $? -eq 0 ]
        then
            return 0
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
docker-compose -f replica-compose.yml up -d

info "Waiting for dbs ..."
wait_for_db_start 9091
wait_for_db_start 9092
wait_for_db_start 9093

info "Initializing primary ..."
mongo --quiet --host localhost --port 9091 --eval "rs.initiate()"

info "Adding secondary ..."
mongo --quiet --host localhost --port 9091 --eval "rs.add(\"secondary:27017\")"

info "Adding arbiter ..."
mongo --quiet --host localhost --port 9091 --eval "rs.addArb(\"arbiter:27017\")"