#!/usr/bin/env bash

curl -L https://github.com/yahoo/kafka-manager/archive/1.3.3.22.tar.gz \
     --output kafka-manager-1.3.3.22.tar.gz

tar -xzf kafka-manager-1.3.3.22.tar.gz && rm kafka-manager-1.3.3.22.tar.gz

cd kafka-manager-1.3.3.22

./sbt clean dist

unzip target/universal/kafka-manager-1.3.3.22.zip
cp -r kafka-manager-1.3.3.22 ../kafka-manager

cd ..

rm -rf kafka-manager-1.3.3.22