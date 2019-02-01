#!/usr/bin/env bash

docker exec -it single-kafka-node /bin/bash \
       /kafka_2.11-2.1.0/bin/kafka-console-producer.sh \
       --broker-list localhost:9092 \
       --topic test.topic