#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

sh "${DIR}"/build.sh

docker push stephenneal/certbot:v1
docker push stephenneal/certbot:v2
docker push stephenneal/certbot:v3
docker push stephenneal/certbot:v4
docker push stephenneal/certbot:v5
docker push stephenneal/certbot:v6
docker push stephenneal/certbot:v7
docker push stephenneal/certbot:v8
docker push stephenneal/certbot:v9