##### How to use this jenkins folder
- First u need to build the application - by building a jar file from the container
```
./jenkins/build/mvn.sh mvn -B -DskipTests clean package
```

*Then u build the image:*
```
./jenkins/build/build.sh
```

*Then u push that image to DockerHub repo*
```
./jenkins/push/push.sh
```

*Then u copy your setting to the virtual machine*
```
./jenkins/deploy/deploy.sh
```

*Final check if the file comes to the virtual machine - login with ssh*
```
ssh -i /tmp/jenkins-course-section-15/.ssh/id_rsa deepChinchilla@localhost -p 2222
```