#!/usr/bin/env bash

docker-compose -f sharding-compose.yml exec shard-a mongotop -h localhost:27018 5