#!/bin/bash

set -e

deploy_to_elastic() {
  # pip install awsebcli
  echo ">>>>>>>>"

  sleep 2

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

  REPOSITORY_IMAGE_TAG_TO_CHECK="${GITHUB_REF_NAME%%@*}"

  echo $GITHUB_REF_NAME

  if [ "$REPOSITORY_IMAGE_TAG_TO_CHECK" = "api" ]; then
    REPOSITORY_IMAGE_TAG_TO_CHECK=$LATEST_UI_TAG
  else
    REPOSITORY_IMAGE_TAG_TO_CHECK=$LATEST_API_TAG 
  fi

  echo $REPOSITORY_IMAGE_TAG_TO_CHECK

  echo "<<><><><"

  while ! aws ecr describe-images \
    --repository-name $REPOSITORY \
    --image-ids imageTag="$REPOSITORY_IMAGE_TAG_TO_CHECK" >/dev/null 2>&1; do
    echo "ECR image does not exist. Retrying..."
    sleep 1 # Adjust the sleep duration as needed
  done

  echo "ECR image exists."

  # aws ecr describe-images --repository-name "$(echo "184503795422.dkr.ecr.us-east-1.amazonaws.com/docker-elastic-beanstalk-up" | cut -d/ -f2)" --image-ids imageTag="$API_IMAGE"

  # zip deploy.zip docker-compose.yml default.conf -r

  # while true; do
  #   eb status docker-elastic-beanstalk-up-dev | grep -i status | grep -q "Ready"
  #   if [ $? -eq 0 ]; then
  #     echo "Elastic Beanstalk is ready!"
  #     break
  #   else
  #     echo "Waiting for Elastic Beanstalk to be ready..."
  #     sleep 20 
  #   fi
  # done

  # eb deploy docker-elastic-beanstalk-up-dev
}

deploy_to_elastic
