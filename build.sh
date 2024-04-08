#!/usr/bin/env bash

# Base directory containing source code
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Optional TAG argument (if set, only the specified image will be built)
TAG=${1:-null}

# Check if the TAG variable is set
if [ "$TAG" != null ]

  # Only build one image
  then
    docker build -t stephenneal/certbot:"${TAG}" "${DIR}"/"${TAG}"/

  # Build all images
  else
    docker build -t stephenneal/certbot:v1 "${DIR}"/v1/
    docker build -t stephenneal/certbot:v2 "${DIR}"/v2/
    docker build -t stephenneal/certbot:v3 "${DIR}"/v3/
    docker build -t stephenneal/certbot:v4 "${DIR}"/v4/
    docker build -t stephenneal/certbot:v5 "${DIR}"/v5/
    docker build -t stephenneal/certbot:v6 "${DIR}"/v6/
    docker build -t stephenneal/certbot:v7 "${DIR}"/v7/
    docker build -t stephenneal/certbot:v8 "${DIR}"/v8/
    docker build -t stephenneal/certbot:v9 "${DIR}"/v9/
    docker build -t stephenneal/certbot:v10 "${DIR}"/v10/
    docker build -t stephenneal/certbot:v11 "${DIR}"/v11/
    docker build -t stephenneal/certbot:v12 "${DIR}"/v12/
    docker build -t stephenneal/certbot:v13 "${DIR}"/v13/
fi