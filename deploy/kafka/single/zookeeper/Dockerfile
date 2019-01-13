FROM openjdk:8u191-jdk-alpine

RUN apk add curl bash

RUN curl http://mirror.linux-ia64.org/apache/kafka/2.1.0/kafka_2.11-2.1.0.tgz \
         --output kafka_2.11-2.1.0.tgz

RUN tar -xzf kafka_2.11-2.1.0.tgz && rm kafka_2.11-2.1.0.tgz

WORKDIR /kafka_2.11-2.1.0

COPY zookeeper.properties config/

CMD [ \
    "./bin/zookeeper-server-start.sh", \
    "config/zookeeper.properties" \
]