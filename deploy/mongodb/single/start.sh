#!/usr/bin/env bash

. ../../common/common.sh
. ../mongodb-common.sh

info "Starting docker ..."
docker run -d --rm -it \
           --name single-mongo \
           -p 127.0.0.1:5353:27017 \
           mongo:3.4.10-jessie

info "Waiting for db ..."
wait_for_db_start 5353