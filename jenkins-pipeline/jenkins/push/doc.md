#### For the $DOCKER_PASS u can find the one time password on the docker hub website
- Go to Personal access tokens and create a new one

#### Save the $VARIABLES on your terminal with export command
```
export $DOCKER_PASS=<personal_access_tokkens>
export $DOCKER_USER=rezafitriaman
export $BUILD_TAG=section-15
```

#### How to tag an image before push
```
docker tag $IMAGE:$BUILD_TAG "$DOCKER_USER/$IMAGE:$BUILD_TAG"
# or
docker tag maven-project-tutorial-jenkins:section-15.169 rezafitriaman/maven-project:section-15
```

#### Start the script
*In the ./push folder*
```
./push.sh
```

