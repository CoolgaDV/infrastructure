#!/usr/bin/env bash

. ../../common/common.sh

info "Starting compose ..."
docker-compose -f single-compose.yml up -d --build