# jenkins-playground
Try Jenkins out

[Docker jenkins image]https://hub.docker.com/r/jenkins/jenkins

#### 05-04-25
Finished Section 1
Finished Section 2
Finished Section 3

#### TODO
What is DNS?
How to change/create local DNS?

---
#### Note:

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
`ssh -i remote-key remote_user@remote_host`