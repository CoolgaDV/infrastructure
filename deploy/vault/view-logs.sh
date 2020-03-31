#!/usr/bin/env bash

. ../common/common.sh

info "Getting logs ..."
docker logs --follow vault
