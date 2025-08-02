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

