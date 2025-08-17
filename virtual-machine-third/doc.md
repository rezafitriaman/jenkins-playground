##### Generate ssh-key pair
**Generate in an custom folder**
[info](https://superuser.com/questions/1004254/how-can-i-change-the-directory-that-ssh-keygen-outputs-to)
```
ssh-keygen -t rsa -b 4096 -C "email@adres.com" -f $HOME/.ssh/id_rsa
```

##### Linux Permission 
**Symbol**
chmod [u/g/o/a][+/-][r/w/x] file
- u: owner
- g: group
- o: other
- +: add
- -: remove
- r: read
- w: write
- x: execute

**Each permission has an value**
- r=4
- w=2
- x=1

**Example:**
```
chmod 700 /home/deepChinchilla/.ssh
```
*Meaning:*
```
rwx------ .ssh
```

**Example:**
```
chmod 600 ~/.ssh/authorized_keys
```
*Meaning:*
```
rw------- authorized_keys
```

##### SSH Generate Host Key - Optional
[info](https://stackoverflow.com/questions/48983917/what-exactly-does-ssh-keygen-a-do)
[info](https://www.geeksforgeeks.org/linux-unix/how-to-generate-ssh-key-with-ssh-keygen-in-linux/)
[info](https://www.freecodecamp.org/news/ssh-keygen-how-to-generate-an-ssh-public-key-for-rsa-login/)
**It saved in the `/etc/ssh` folder**
```
ssh-keygen -A
```

*Possible error:*
```
Attaching to remote_host_third_jenkins remote_host_third_jenkins | 
Missing privilege separation directory: /run/sshd remote_host_third_jenkins exited with code 255
```

*Fix:*
```
RUN mkdir -p /run/sshd 
```

##### Launch the SSH server as a background task
[info](https://www.warp.dev/terminus/ssh-docker-container)
```
CMD ["/usr/sbin/sshd", "-D"]
```

##### Install Docker Engine 
[info](https://docs.docker.com/engine/install/ubuntu/)
*We use docker.sock from the host machine, so we add it to the `volume`*
```
volumes: 
    - /var/run/docker.sock:/var/run/docker.sock
```

*So we dont need to install Docker Daemon*
We will skip this packages
```
docker-ce containerd.io
```

##### Add user on Ubuntu 
[info](https://www.digitalocean.com/community/tutorials/how-to-add-and-delete-users-on-ubuntu-20-04)
[info](https://askubuntu.com/questions/668129/password-does-not-work-with-useradd-p)
*This is only for Ubuntu*
```
useradd -m <USER> && echo "<USER>:<PASSWORD>" | chpasswd
```

*Go Into the container:remote_host_third_jenkins*
```
docker exec -it remote_host_third_jenkins bash
```

*Then Switch user to deepChinchilla*
```
su deepChinchilla
```

##### SSH into container
**From local machine**
*U need to expose the port to 2222*
```
ssh -i .ssh/id_rsa deepChinchilla@localhost -p 2222
```

**From another container**
*U need to use default port or the native container port*
```
ssh deepChinchilla@remote_host_third -p 22
```
