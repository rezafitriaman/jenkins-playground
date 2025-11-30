#!/bin/bash

TMP_COURSE_PATH="/tmp/jenkins-course-section-15"

echo '#this is a test for jenkins course section 15 - u can delete it after the course\n' > "$TMP_COURSE_PATH/.auth"
echo maven-project >> "$TMP_COURSE_PATH/.auth"
echo $BUILD_TAG >> "$TMP_COURSE_PATH/.auth"
echo $DOCKER_PASS >> "$TMP_COURSE_PATH/.auth"

scp -i "$TMP_COURSE_PATH/.ssh/id_rsa" -P 2222 "$TMP_COURSE_PATH/.auth" deepChinchilla@localhost:/tmp/.auth