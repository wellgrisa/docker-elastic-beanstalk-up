#!/bin/bash

set -e

deploy_to_elastic() {
  pip install awsebcli

  TAG=$PACKAGE_NAME-$GITHUB_REF_NAME

  $IMAGE=$REGISTRY/$REPOSITORY:$TAG

  sed -e "s/\${IMAGE}/$IMAGE/g" Dockerrun.template.aws.json > Dockerrun.aws.json

  eb deploy --staged
}

deploy_to_elastic
