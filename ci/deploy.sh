#!/bin/bash

set -e

deploy_to_elastic() {
  pip install awsebcli

  LATEST_API_TAG=$(git describe --tags --match="api*" --abbrev=0)
  LATEST_UI_TAG=$(git describe --tags --match="ui*" --abbrev=0)

  API_IMAGE_TAG="${LATEST_API_TAG//@/-}"
  UI_IMAGE_TAG="${LATEST_UI_TAG//@/-}"

  API_IMAGE=$REGISTRY/$REPOSITORY:$API_IMAGE_TAG
  UI_IMAGE=$REGISTRY/$REPOSITORY:$UI_IMAGE_TAG

  ESCAPED_API_IMAGE=$(echo "$API_IMAGE" | sed 's/[\/&]/\\&/g')
  ESCAPED_UI_IMAGE=$(echo "$UI_IMAGE" | sed 's/[\/&]/\\&/g')

  sed -e "s/\${API_IMAGE}/$ESCAPED_API_IMAGE/g" -e "s/\${UI_IMAGE}/$ESCAPED_UI_IMAGE/g" docker-compose.template.yml > docker-compose.yml

  cat docker-compose.yml

  zip deploy.zip docker-compose.yml default.conf -r

  eb deploy
}

deploy_to_elastic
