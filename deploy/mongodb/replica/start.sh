#!/usr/bin/env bash

. ../../common/common.sh
. ../mongodb-common.sh

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