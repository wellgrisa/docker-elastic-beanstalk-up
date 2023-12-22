#!/bin/bash

set -e

deploy_to_elastic() {
  pip install awsebcli

  API_IMAGE=$REGISTRY/$REPOSITORY:api-$GITHUB_REF_NAME
  UI_IMAGE=$REGISTRY/$REPOSITORY:ui-$GITHUB_REF_NAME

  ESCAPED_API_IMAGE=$(echo "$API_IMAGE" | sed 's/[\/&]/\\&/g')
  ESCAPED_UI_IMAGE=$(echo "$UI_IMAGE" | sed 's/[\/&]/\\&/g')

  sed -e "s/\${API_IMAGE}/$ESCAPED_API_IMAGE/g" -e "s/\${UI_IMAGE}/$ESCAPED_UI_IMAGE/g" docker-compose.template.yml > docker-compose.yml

  cat docker-compose.yml

  zip deploy.zip docker-compose.yml default.conf -r

  eb deploy
}

deploy_to_elastic
