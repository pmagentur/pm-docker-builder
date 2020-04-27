FROM docker:stable

LABEL "com.github.actions.icon"="bell"
LABEL "com.github.actions.color"="blue"
LABEL "com.github.actions.name"="PM Docker Builder"
LABEL "com.github.actions.description"="Build and push docker images easly"

RUN apk update \
  && apk upgrade \
  && apk add --no-cache git bash

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]
