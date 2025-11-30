#!/bin/bash

echo "*************************"
echo "***** Pushing image *****"
echo "*************************"

IMAGE="maven-project-tutorial-jenkins"

echo "** Logging in to Docker Hub **"
echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

echo "** Tagging image **"
docker tag $IMAGE:$BUILD_TAG "$DOCKER_USER/$IMAGE:$BUILD_TAG"

echo "** Pushing image **"
docker push "$DOCKER_USER/$IMAGE:$BUILD_TAG"
