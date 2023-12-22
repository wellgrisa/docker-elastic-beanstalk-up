#!/bin/bash

set -e

deploy_to_elastic() {
  pip install awsebcli

  zip deploy.zip docker-compose.yml default.conf -r

  eb deploy
}

deploy_to_elastic
