#!/bin/bash

# -e  Exit immediately if a command exits with a non-zero status.
set -e

PACKAGE_NAME=$(echo "$GITHUB_REF_NAME" | sed 's/@.*//')

TAG=$GITHUB_REF_NAME

build_docker_image() {
  echo "Building docker image $REGISTRY/$REPOSITORY:$TAG"

  cd ../../

  docker build -t $REGISTRY/$REPOSITORY:$TAG -f packages/$PACKAGE_NAME.Dockerfile .
}

push_docker_image_to_ecr() {
  echo "Pushing Docker image - $REGISTRY/$REPOSITORY:$TAG"

  docker push $REGISTRY/$REPOSITORY:$TAG
}

build_docker_image
push_docker_image_to_ecr
