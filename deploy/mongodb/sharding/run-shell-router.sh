#!/usr/bin/env bash

docker-compose -f sharding-compose.yml exec router rm -rf /scripts/

docker cp scripts "$(docker-compose -f sharding-compose.yml ps -q router)":/

docker-compose -f sharding-compose.yml exec router mongo localhost:27017