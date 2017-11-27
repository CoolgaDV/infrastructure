#!/usr/bin/env bash

. ../common/common.sh

info "Building image ..."
docker build -t graphite-grafana:1.0 ./image

info "Starting container ..."
docker run -d --rm -it \
           --name graphite-grafana \
           -p 127.0.0.1:3000:3000 \
           -p 127.0.0.1:2003:2003 \
           graphite-grafana:1.0


