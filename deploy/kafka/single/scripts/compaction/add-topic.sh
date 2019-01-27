#!/usr/bin/env bash

docker exec -it single-kafka-node /bin/bash \
       /kafka_2.11-2.1.0/bin/kafka-topics.sh \
       --create \
       --zookeeper zookeeper:2181 \
       --replication-factor 1 \
       --partitions 1 \
       --config cleanup.policy=compact \
       --config segment.ms=100 \
       --config delete.retention.ms=100 \
       --topic test.compaction