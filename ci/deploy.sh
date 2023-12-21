#!/bin/bash

set -e

deploy_to_elastic() {
  pip install awsebcli

  zip deploy.zip docker-compose.yml .ebextensions default.conf -r

  eb deploy --staged
}

deploy_to_elastic
