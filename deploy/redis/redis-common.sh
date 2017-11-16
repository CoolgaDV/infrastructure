#!/usr/bin/env bash

function wait_for_redis_start() {
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