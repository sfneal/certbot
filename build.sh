#!/usr/bin/env bash

# Base directory containing source code
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Optional TAG argument (if set, only the specified image will be built)
TAG=${1:-null}

# Check if the TAG variable is set
if [ -z "$TAG" ]

  # Only build one image
  then
    docker build -t stephenneal/certbot-nginx:"${TAG}" "${DIR}"/"${TAG}"/

  # Build all images
  else
    docker build -t stephenneal/certbot-nginx:v1 "${DIR}"/v1/
    docker build -t stephenneal/certbot-nginx:v2 "${DIR}"/v2/
    docker build -t stephenneal/certbot-nginx:v3 "${DIR}"/v3/
    docker build -t stephenneal/certbot-nginx:v4 "${DIR}"/v4/
    docker build -t stephenneal/certbot-nginx:v5 "${DIR}"/v5/
    docker build -t stephenneal/certbot-nginx:v6 "${DIR}"/v6/
    docker build -t stephenneal/certbot-nginx:v7 "${DIR}"/v7/
    docker build -t stephenneal/certbot-nginx:v8 "${DIR}"/v8/
fi