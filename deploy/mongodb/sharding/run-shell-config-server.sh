#!/usr/bin/env bash

docker-compose -f sharding-compose.yml exec config-server rm -rf /scripts/

docker cp ../scripts "$(docker-compose -f sharding-compose.yml ps -q config-server)":/

docker-compose -f sharding-compose.yml exec config-server mongo localhost:27019