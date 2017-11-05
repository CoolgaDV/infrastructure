#!/usr/bin/env bash

docker exec single-mongo rm -rf /scripts/

docker cp ../scripts single-mongo:/

docker exec -it single-mongo mongo localhost:27017/sample