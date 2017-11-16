#!/usr/bin/env bash

. ../../common/common.sh
. ../mongodb-common.sh

info "Starting compose ..."
docker-compose -f replica-compose.yml up -d

info "Waiting for dbs ..."
wait_for_docker_compose_db_start replica-compose.yml primary 27017
wait_for_docker_compose_db_start replica-compose.yml secondary 27017
wait_for_docker_compose_db_start replica-compose.yml arbiter 27017

info "Initializing primary ..."
mongo --quiet --host localhost --port 9091 --eval "rs.initiate()"

info "Adding secondary ..."
mongo --quiet --host localhost --port 9091 --eval "rs.add(\"secondary:27017\")"

info "Adding arbiter ..."
mongo --quiet --host localhost --port 9091 --eval "rs.addArb(\"arbiter:27017\")"