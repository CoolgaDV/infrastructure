#!/usr/bin/env bash

function wait_for_db_start() {
    port=$1
    for i in `seq 1 10`; do
        mongo --quiet --host localhost --port ${port} --eval db &>/dev/null
        if [ $? -eq 0 ]
        then
            return 0
        fi
        sleep 1s
    done
    info "Unable to connect to DB on port ${port}"
    exit 1
}