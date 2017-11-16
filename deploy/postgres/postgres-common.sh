#!/usr/bin/env bash

function wait_for_db_start() {
    container=$1
    for i in `seq 1 10`; do
        docker exec -it ${container} psql -U postgres -c "select 1" &>/dev/null
        if [ $? -eq 0 ]
        then
            return 0
        fi
        sleep 1s
    done
    info "Unable to connect to db on ${container}"
    exit 1
}