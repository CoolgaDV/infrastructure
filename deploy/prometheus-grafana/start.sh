#!/usr/bin/env bash

. ../common/common.sh

info "Starting compose ..."
docker-compose -f prometheus-grafana-compose.yml up -d