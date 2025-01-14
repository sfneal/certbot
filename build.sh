#!/usr/bin/env bash

# Base directory containing source code
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# Optional TAG argument (if set, only the specified image will be built)
TAG=${1:-null}

# Optional PLATFORM argument (if none provided, both will be built)
PLATFORM=${2:-"linux/amd64,linux/arm64"}

# Check if the TAG variable is set
if [ "$TAG" != null ]

  # Only build one image
  then
    docker buildx build \
      	--load \
      	-t stephenneal/certbot:"${TAG}" \
      	--platform "${PLATFORM}" \
      	"${DIR}"/"${TAG}"/

  # Build all images
  else
    docker build -t stephenneal/certbot:v7 "${DIR}"/v7/
    docker build -t stephenneal/certbot:v8 "${DIR}"/v8/
    docker build -t stephenneal/certbot:v9 "${DIR}"/v9/
    docker build -t stephenneal/certbot:v10 "${DIR}"/v10/
    docker build -t stephenneal/certbot:v11 "${DIR}"/v11/
    docker build -t stephenneal/certbot:v12 "${DIR}"/v12/
    docker build -t stephenneal/certbot:v13 "${DIR}"/v13/
    docker build -t stephenneal/certbot:v14 "${DIR}"/v14/
    docker build -t stephenneal/certbot:v15 "${DIR}"/v15/
fi