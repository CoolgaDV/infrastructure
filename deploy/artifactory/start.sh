#!/usr/bin/env bash

. ../common/common.sh

info "Starting container ..."
docker run -d --rm -it \
           --name artifactory \
           -p 127.0.0.1:8081:8081 \
           docker.bintray.io/jfrog/artifactory-oss:5.9.1
