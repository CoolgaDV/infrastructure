#!/usr/bin/env bash

docker exec single-postgres rm -rf /scripts/

docker cp scripts single-postgres:/

docker exec -it single-postgres psql -U postgres