#!/bin/sh -l

if [ -z $USERNAME ]; then
  echo 'Required username parameter'
  exit 1
fi

if [ -z $PASSWORD ]; then
  echo 'Required password parameter'
  exit 1
fi

if [ -z $REGISTRY ]; then
  echo 'Privat registery is not set, default value is hub.docker.com'
fi

if [ -z $REPOSITORY ]; then
  echo 'Setting default repository to':$(echo ${GITHUB_REF}| cut -d'/' -f 2);
  REPOSITORY=$(echo ${GITHUB_REF}| cut -d'/' -f 2);
fi

if [[ -z $TAG ]]; then
  echo 'Setting tag latest'
  TAG='latest'
fi

IMAGE=$REPOSITORY:$TAG
if [ -n "$REGISTRY" ]; then
  IMAGE=$REGISTRY/$IMAGE
fi

if [[ -z $DOCKERFILE_PATH ]]; then
  echo 'Setting Defaukt path of Docker File to .'
  FILE_PATH='.'
fi



docker build -t $IMAGE $DOCKERFILE_PATH
docker login --username "$USERNAME" --password "$PASSWORD" $REGISTRY
docker push $IMAGE

if [[ "$CREATE_BACKUP" == 'True' ]]; then
  TAG=$GITHUB_RUN_NUMBER
  BAK_IMAGE=$REPOSITORY:$TAG
  if [ -n "$REGISTRY" ]; then
    IMAGE=$REGISTRY/$IMAGE
  fi
  echo 'Backup image name is:'$IMAGE
fi

docker push $BAK_IMAGE