#!/usr/bin/env bash

sh ./build.sh

docker push stephenneal/certbot-nginx:v1
docker push stephenneal/certbot-nginx:v2
docker push stephenneal/certbot-nginx:v3