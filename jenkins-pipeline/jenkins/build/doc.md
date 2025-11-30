##### Why copy the JAR
- This takes JAR you build with Maven `my-app-1.0-SNAPSHOT.jar`
- Copies it into the image at `/app/app.jar`
- Now the image contains your runnable application code.
```
copy *.jar /app/app.jar
```

#### Why `CMD jar -jar /app/app.jar`
`CMD` defines the default command that runs when you start a container from this image
*Without it, if you just do:*
```
docker run myimage
```
The container will start and then immediately exit (because it has nothing to run).

*With*
```
CMD java -jar /app/app.jar
```
Docker runs your Java app as the container's main process.

*So when you run:*
```
docker run myimage
```
Its equivalent to:
```
docker run myimage java -jar /app/app.jar
```

---

##### Build an image directly from `Dockerfile`
In the folder where your `Dockerfile` live:
```
docker build -t myapp:1.0 .
```
- `-t myapp:1.0` gives the image a name `myapp` and version tag `1.0`
- `.` means "current folder is the build context".

*or*
```
docker build -f Dockerfile -t mytestapp:1.0 .
```
- `-f Dockerfile` it give the name of the Docker file u want to use.

*then*
U can use `docker images | grep mytestapp` to look if there is image with that name

#### Run a container from that image
```
docker run --name myapp-container myapp:1.0
```
- `--name myappcontainer` give your container a friendly name.
- `myapp:1.0` run from the image your just build

**Since your Dockerfile has CMD command:**
this is what runs when the container starts.
```
CMD java -jar /app/app.jar
```

**If u want to run it with a port-number**
This will Maps host `localhost:8080` to container `8080`
```
docker run -p 8080:8080 --name myapp-container myapp:1.0
```

#### One shot container to see witch version it has
```
docker run --rm amazoncorretto:21.0.7-alpine3.21 java --version | grep openjdk
```
*or*
```
docker run --rm maven:3.9.9-ibm-semeru-21-noble mvn -version | grep Java 
```

#### Build image from a dockerfile
```
docker build -f Dockerfile -t mytestapp:1.0 .
```
- docker build : docker build image command
- -f Dockerfile : from file Dockerfile
- -t mytestapp:1.0 : give it a tagName mytestapp:1.0
- . : from this context

#### Run one shot already build image
```
docker run --rm -ti -w /app mytestapp:1.0 sh
```

- docker run : docker run image command
- --rm : remove container if it stopped 
- -ti : run interactive mode
- sh : paired with bash command
- -w /app : start from working directory /app

#### Build image with docker compose command
```
docker compose -f docker-compose-build.yml build
```
- docker compose : compose command
- -f docker-compose-build.yml : from file
- build : build command 

#### Push to docker repository
*U need to create a tag that has the same name with your repository:*
```
# Tag it first
docker tag maven-project-tutorial-jenkins:section-15.169 rezafitriaman/maven-project:section-15

# Then push
docker push rezafitriaman/maven-project:section-15
```

