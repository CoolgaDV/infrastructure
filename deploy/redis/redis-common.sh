#!/usr/bin/env bash

function wait_for_docker_plain_redis_start() {
    container=$1
    for i in `seq 1 10`; do
        docker exec -it ${container} redis-cli ping &>/dev/null
        if [ $? -eq 0 ]
        then
            return 0
        fi
        sleep 1s
    done
    info "Unable to connect to redis on ${container}"
    exit 1
}

function wait_for_docker_compose_redis_start() {
    compose_file=$1
    container=$2
    for i in `seq 1 10`; do
        docker-compose -f ${compose_file} exec ${container}\
            redis-cli ping &>/dev/null
        if [ $? -eq 0 ]
        then
            return 0
        fi
        sleep 1s
    done
    info "Unable to connect to redis on ${container}"
    exit 1
}