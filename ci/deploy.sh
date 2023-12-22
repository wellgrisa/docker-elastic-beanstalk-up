#!/bin/bash

set -e

deploy_to_elastic() {
  pip install awsebcli

  sed -e "s/\${API_IMAGE}/BANANA/g" docker-compose.template.yml > docker-compose.yml
  sed -e "s/\${UI_IMAGE}/BANANA/g" docker-compose.template.yml > docker-compose.yml

  echo $API_IMAGE

  cat docker-compose.yml

  zip deploy.zip docker-compose.yml default.conf -r

  # eb deploy
}

deploy_to_elastic
