#!/usr/bin/env bash

. ../common/common.sh

info "Building image ..."
docker build -t graphite-grafana:1.0 --no-cache ./image

info "Starting container ..."
docker run -d --rm -it \
           --name graphite-grafana \
           -p 127.0.0.1:3000:3000 \
           graphite-grafana:1.0


