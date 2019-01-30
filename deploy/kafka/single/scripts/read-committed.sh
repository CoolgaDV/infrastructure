#!/usr/bin/env bash

docker exec -it single-kafka-node /bin/bash \
       /kafka_2.11-2.1.0/bin/kafka-console-consumer.sh \
       --bootstrap-server localhost:9092 \
       --topic test.transactional.topic \
       --isolation-level=read_committed