#!/usr/bin/env bash

docker build -t stephenneal/certbot-nginx:v1 ./v1/
docker build -t stephenneal/certbot-nginx:v2 ./v2/
docker build -t stephenneal/certbot-nginx:v3 ./v3/