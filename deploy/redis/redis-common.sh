#!/usr/bin/env bash

function wait_for_redis_start() {
    port=$1
    for i in `seq 1 10`; do
        redis-cli -h localhost -p ${port} ping &>/dev/null
        if [ $? -eq 0 ]
        then
            return 0
        fi
        sleep 1s
    done
    info "Unable to connect to redis on port ${port}"
    exit 1
}