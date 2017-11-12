#!/usr/bin/env bash

docker exec single-mongo mongodump -h localhost:27017 -o /mongo-dump/