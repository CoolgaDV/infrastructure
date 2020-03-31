#!/usr/bin/env bash

. ../common/common.sh

info "Starting container ..."
docker run -d --rm -it \
           --name vault \
           -p 127.0.0.1:8200:8200 \
           vault:1.3.4
