#!/usr/bin/env bash

docker-compose -f sharding-compose.yml exec shard-a rm -rf /scripts/

docker cp scripts "$(docker-compose -f sharding-compose.yml ps -q shard-a)":/

docker-compose -f sharding-compose.yml exec shard-a mongo localhost:27018