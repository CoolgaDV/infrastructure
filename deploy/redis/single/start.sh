#!/usr/bin/env bash

. ../../common/common.sh
. ../redis-common.sh

info "Starting docker ..."
docker run -d --rm -it \
           --name single-redis \
           -p 127.0.0.1:5454:6379 \
           redis:4.0.2-alpine

info "Waiting for redis ..."
wait_for_redis_start 5454