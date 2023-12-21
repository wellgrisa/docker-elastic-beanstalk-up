#!/bin/bash

set -e

deploy_to_elastic() {
  pip install awsebcli


  eb deploy
}

deploy_to_elastic
