#!/bin/bash

set -e

deploy_to_elastic() {
  pip install awsebcli

  TAG=$PACKAGE_NAME-$GITHUB_REF_NAME

  IMAGE=$REGISTRY/$REPOSITORY:$TAG

  ESCAPED_API_IMAGE=$(echo "$IMAGE" | sed 's/[\/&]/\\&/g')

  sed -e "s/\${IMAGE}/$ESCAPED_API_IMAGE/g" Dockerrun.template.aws.json > Dockerrun.aws.json

  eb deploy --staged
}

deploy_to_elastic
