#!/usr/bin/env bash

docker-compose -f replica-compose.yml exec primary rm -rf /scripts/

docker cp ../scripts "$(docker-compose -f replica-compose.yml ps -q primary)":/

docker-compose -f replica-compose.yml exec primary mongo localhost:27017/sample