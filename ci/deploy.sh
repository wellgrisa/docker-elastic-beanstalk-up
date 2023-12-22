#!/bin/bash

set -e

deploy_to_elastic() {
  pip install awsebcli

  sed -e "s/\${API_IMAGE}/BANANA/g" -e "s/\${UI_IMAGE}/APPLE/g" docker-compose.template.yml > docker-compose.yml

  cat docker-compose.yml

  zip deploy.zip docker-compose.yml default.conf -r

  # eb deploy
}

deploy_to_elastic
