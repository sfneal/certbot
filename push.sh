#!/usr/bin/env bash

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

sh "${DIR}"/build.sh

docker push stephenneal/certbot-nginx:v1
docker push stephenneal/certbot-nginx:v2
docker push stephenneal/certbot-nginx:v3
docker push stephenneal/certbot-nginx:v4
docker push stephenneal/certbot-nginx:v5
docker push stephenneal/certbot-nginx:v6
docker push stephenneal/certbot-nginx:v7