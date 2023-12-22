#!/bin/bash

set -e

deploy_to_elastic() {
  pip install awsebcli

  sed -e "s/\${API_IMAGE}/$API_IMAGE/g" docker-compose.template.yml > docker-compose.yml
  sed -e "s/\${UI_IMAGE}/$UI_IMAGE/g" docker-compose.template.yml > docker-compose.yml

  zip deploy.zip docker-compose.yml default.conf -r

  eb deploy
}

deploy_to_elastic
