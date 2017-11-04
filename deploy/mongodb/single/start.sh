#!/usr/bin/env bash

docker build -t mongodb-single:1.0 ./

docker run -d --rm -ti \
       --name mongodb-single \
       -p 127.0.0.1:5353:27017 \
       mongodb-single:1.0