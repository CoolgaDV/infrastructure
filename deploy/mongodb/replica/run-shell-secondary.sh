#!/usr/bin/env bash

docker-compose -f replica-compose.yml exec secondary rm -rf /scripts/

docker cp ../scripts "$(docker-compose -f replica-compose.yml ps -q secondary)":/

docker-compose -f replica-compose.yml exec secondary mongo localhost:27017/sample