#!/usr/bin/env bash

. ../../common/common.sh
. ../postgres-common.sh

info "Starting docker ..."
docker run -d --rm -it \
           --name single-postgres \
           -p 127.0.0.1:5656:5432 \
           postgres:10.1-alpine

info "Waiting for db ..."
wait_for_db_start single-postgres