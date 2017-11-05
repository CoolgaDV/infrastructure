#!/usr/bin/env bash

docker-compose -f replica-compose.yml exec arbiter rm -rf /scripts/

docker cp ../scripts "$(docker-compose -f replica-compose.yml ps -q arbiter)":/

docker-compose -f replica-compose.yml exec arbiter mongo localhost:27017