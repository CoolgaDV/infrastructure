#!/usr/bin/env bash

. ../../common/common.sh
. ../mongodb-common.sh

info "Starting compose ..."
docker-compose -f single-compose.yml -f up -d

info "Waiting for db ..."
wait_for_db_start 5353