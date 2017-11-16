#!/usr/bin/env bash

function wait_for_docker_plain_db_start() {
    container=$1
    for i in `seq 1 10`; do
        docker exec -it ${container} mongo --quiet --eval db &>/dev/null
        if [ $? -eq 0 ]
        then
            return 0
        fi
        sleep 1s
    done
    info "Unable to connect to DB on ${container}"
    exit 1
}

function wait_for_docker_compose_db_start() {
    compose_file=$1
    container=$2
    port=$3
    for i in `seq 1 10`; do
        docker-compose -f ${compose_file} exec ${container}\
            mongo --quiet --port ${port} --eval db &>/dev/null
        if [ $? -eq 0 ]
        then
            return 0
        fi
        sleep 1s
    done
    info "Unable to connect to DB on ${container} on port ${port}"
    exit 1
}