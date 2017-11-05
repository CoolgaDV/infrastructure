#!/usr/bin/env bash

docker-compose -f sharding-compose.yml exec shard-b rm -rf /scripts/

docker cp ../scripts "$(docker-compose -f sharding-compose.yml ps -q shard-b)":/

docker-compose -f sharding-compose.yml exec shard-b mongo localhost:27018