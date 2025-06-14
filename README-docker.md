#### Docker how to:

**To build the image**
`docker compose build`

**To create container**
`docker compose up -d`

**Go to jenkins container**
`docker exec -it jenkins bash`

**Go from jenkins container to virtual container with SSH**
`ssh remote_user@remote_host`

**To connect between container use DNS name**
- [user]@jenkins
- [user]@remote_host

**SSH files**
- remote-key
- remote-key.pub

**Copy remote-key to jenkins container**
`docker cp ./remote-key jenkins:/tmp/remote-key`

**Fix ownership inside the container**
```
docker exec -u root jenkins chown jenkins:jenkins /tmp/remote-key
docker exec -u root jenkins chmod 600 /tmp/remote-key
```

**SSH from jenkins container to virtual container with remote-key, so u dont need use a password**
`ssh -i /tmp/remote-key remote_user@remote_host`

**To copy script-hello.sh to jenkins container /tmp/ folder**
`docker cp ./script-hello.sh jenkins:/tmp/script-hello.sh`

**To create ssh key (pub and private) on a folder where u on**
`ssh-keygen -f remote-key`

**To remove a working container:**
`docker rm -fv remote_host_jenkins`

**U can log in to container as root to fix permissions**
`docker exec -u 0 -it jenkins-container bash`

**U can inspect docker container and image with:**
docker inspect <contanerName> | <imageName>

**How to check Existing Containers:**
docker ps -a | grep my-postgres

**Stop and remove if a container exist:**
docker stop my-postgres 2>/dev/null && docker rm my-postgres 2>/dev/null

---

**Simple maven project**
[Link](https://github.com/jenkins-docs/simple-java-maven-app/tree/master)
