#!/usr/bin/env bash

. ../../common/common.sh
. ../redis-common.sh

info "Starting compose ..."
docker-compose -f replica-compose.yml up -d --build

info "Waiting for redis ..."
wait_for_docker_compose_redis_start replica-compose.yml master
wait_for_docker_compose_redis_start replica-compose.yml slave


