##### Install Docker in Docker (DinD)
**To Install docker engine**
[doc](https://docs.docker.com/engine/install/debian/#install-using-the-repository)

**Gives access to host Docker**
You'are letting the Docker CLI inside the container communicate with Docker daemon running on the host.
```
volumes:
/var/run/docker.sock:/var/run/docker.sock
```

**Require root to access Docker socket from inside the container**
user: root

**What is `var/run/docker.sock`**
It is a Unix domain socket file that your Docker client (the CLI) uses to talk to the Docker daemon (dockerd).
Think of it like this:
- `/usr/bin/docker` = the CLI tool (just sends API commands)
- `/var/run/docker.sock` = the wire that connects CLI to the running Docker engine
- `dockerd` = the engine actually doing the work

---

**Pull docker maven image**
```
docker pull maven:3.9.9-ibm-semeru-21-noble
```

**Create Maven Container, Go into Container, Download the dependency and Package the App**
*U need to run this inside jenkins-pipeline folder*
```
docker run --rm -ti -v $PWD/java-app:/app -v $PWD/.m2/:/root/.m2/ -w /app maven:3.9.9-ibm-semeru-21-noble sh 
# then inside the container
mvn package
```
**Create Maven Container, Download the dependency and Package the App**
*U need to run this inside jenkins-pipeline folder*
```
docker run --rm -v $PWD/java-app:/app -v $PWD/.m2/:/root/.m2/ -w /app maven:3.9.9-ibm-semeru-21-noble mvn -B -DskipTests clean package 
```

**Create script to run docker**
This script will create the `.jar` file that u will use later on.
```
vim ./mvn.sh
chmod +x ./mvn.sh
```

**How to use it**
*Go to `jenkins-pipeline` folder*
This will run maven:3.9.9-ibm-semeru-21-noble image and remove it automatically if the container stopped.
It wil use `$PWD/java-app` and `$PWD/.m2` as bind-mount volume on your local folder.
`mvn clean package` will:
`clean`: Removes the `target/` directory before anything else
`package`:  Builds the .jar/.war file - it will run: `validate -> compile -> test -> package` 

*Command:*
```
./jenkins/build/mvn.sh mvn -B -DskipTests clean package
```

**Maven Package**
```
mvn package
```

**Maven download dependencies**
```
mvn clean install
```

##### Maven commands explanation
**Maven Lifecycle: The Basics**
Maven uses build lifecycle phase, in this order:
```
validate -> compile -> test -> package -> verify -> install -> deploy
```

Each phase runs the previous one:
- `install` Also run `package`, `compile`, `test`, etc.
- `package` Runs `compile` and `test`
- `clean` Removes the `target/` directory before anything else

##### Maven Build Lifecycle Diagram
```
validate -> compile -> test -> package -> verify -> install -> deploy
```
`compile` Source code compilation
`test` Runs unit tests (using compiled code)
`package` Builds the .jar/.war file
`varify` Checks integration tests or QA checks
`install` Copies the artifact to ~/.m2/repository
`deploy` Publishes to remote repository (e.g., Nexus)

Example:
```
mvn clean install
```

It means:
```
clean -> validate -> compile -> test -> package -> verify -> install
```

##### Example Maven combos
```
mvn clean compile # Clean and compile only
mvn test -Dtest=MyTest # Run a specific test class
mvn install -Pproduction # Build and install with a specific profile
mvn dependency:tree -Dverbose # see where dependencies come from
```

**Java version should match the Maven version**
To check which Java version was used when running Maven use:
```
docker run --rm maven:3.9.9-ibm-semeru-21-noble mvn -version | grep Java
```

##### Build image from Dockerfile
*Important u use Dot "." - to tell Docker: "use this folder as the set of files available for `COPY/ADD`" in the build*
```
docker build -f Dockerfile -t test .
```

**Check if we build the docker image correctly**
```
docker images | grep test
```

**To create an container from the 'test' image**
```
docker run --rm -ti test sh
```
*Or*
```
docker run test
```
*Or*
```
docker run -d test
```

**To see the logs if u use -d**
```
docker logs -f <hash_number>
```

##### Build the image from the jar that u created
*U need Activated this from `jenkins-pipeline` folder*
This will copy the `.jar` file from `target` folder inside `java-app`
Then activate `docker-compose-build.yml` so u build the image
U need to set `BUILD_TAG` variable sinds it will use in the `compose.yml` file

Command:
```
export BUILD_TAG=2
./jenkins/build/build.sh
```

##### Run mvn test from the container
U need to go to `jenkins-pipeline` folder first.
`mvn test` Runs unit tests (using compiled code)
Command:
```
docker run --rm -v $PWD/java-app:/app -v $PWD/.m2/:/root/.m2/ -w /app maven:3.9.9-ibm-semeru-21-noble mvn test
```

##### Docker Hub
**Login to Docker HUB**
```
docker login
```

**Push image to your Repository**
```
docker images
```

**Tag local docker image - so u can push to docker Hub**
```
docker tag <local_repo_name>:tag rezafitriaman/<repo_name>:tag
```

**Push docker image to docker Hub**
```
docker push <repo_name>:tag
```

**Pull docker image**
```
docker pull <repo_name>:tag
```
 