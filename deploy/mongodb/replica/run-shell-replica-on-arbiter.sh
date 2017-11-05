#!/usr/bin/env bash

docker-compose -f replica-compose.yml exec arbiter rm -rf /scripts/

docker cp ../scripts "$(docker-compose -f replica-compose.yml ps -q arbiter)":/

docker-compose -f replica-compose.yml exec arbiter mongo \
               mongodb://primary:27017,secondary:27017/sample?replicaSet=sample-replica