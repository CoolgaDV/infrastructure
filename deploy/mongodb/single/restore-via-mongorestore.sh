#!/usr/bin/env bash

docker exec single-mongo mongorestore -h localhost:27017 --drop /mongo-dump/