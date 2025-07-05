# WARNING: This value is valid only in the following conditions
#          1. If provided manually (either via `GITLAB_ROOT_PASSWORD` environment variable or via `gitlab_rails['initial_root_password']` setting in `gitlab.rb`, it was provided before database was seeded for the first time (usually, the first reconfigure run).
#          2. Password hasn't been changed manually, either via UI or via command line.
#
#          If the password shown here doesn't work, you must reset the admin password following https://docs.gitlab.com/ee/security/reset_user_password.html#reset-your-root-password.

Password root: epu6exvT1tB4EEbQbV22nUtGvhRzRf/VopBBYfoUOYQ=

##### How to generate Api token Jenkins
(doc)[https://www.baeldung.com/ops/jenkins-api-token]

##### To trigger a job using curl or extern methode, u need to use API Token
- Login with the user u want to use
- Create an API Token under the security tab
- Copy the job link button

** Example user on gitlab **
user: deepChinchilla
ww: deep12345678

** Example user on Jenkins **
user: fitriaman
ww: fitriaman

** Example how to use API Token to start a job**
curl \
-u fitriaman:11fdd7059beeb43492e25b33711b412d20 \
-X POST http://localhost:8080/job/maven-job/build?delay=0sec

** Or From gitlab container **
curl \
-u fitriaman:11fdd7059beeb43492e25b33711b412d20 \
-X POST http://jenkins:8080/job/maven-job/build?delay=0sec

** jenkins/java Relative path:**
u find @hashed path in the Admin section and project under Relative path.
```
@hashed/4b/22/4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a.git
```

Full path will be:
/var/opt/gitlab/git-data/repositories/@hashed/4b/22/4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a.git

** doc **
(more info)[https://docs.gitlab.com/administration/server_hooks/]

** To add post-receive command after git push and it start jenkins automatically **
In gitLab container :

```
Docker exec -it gitlab bash

mkdir -p /temp/custom_hooks
vim /tmp/custom_hooks/post-receive
```

Then add the script in to post-receive file:
```
#!/bin/bash


curl \
-u fitriaman:11fdd7059beeb43492e25b33711b412d20 \
-X POST http://jenkins:8080/job/maven-job/build?delay=0sec


echo "post-receive: pushed to main" >> /tmp/post-receive.log

```
then u need make the file executable, and make it tarball:
```
chmod +x /tmp/custom_hooks/post-receive

cd /tmp
tar -cf custom_hooks.tar custom_hooks
```

3. Get the Repo Info
You need three things:

What	How to Get It
--storage	    Usually default (check /etc/gitlab/gitlab.rb)
--repository	The path relative to Gitaly’s storage (e.g. @hashed/4b/22/...git)
--config	    Usually: /var/opt/gitlab/gitaly/config.toml

then run:
```
cat /tmp/custom_hooks.tar | sudo -u git \
  /opt/gitlab/embedded/bin/gitaly hooks set \
  --storage default \
  --repository @hashed/4b/22/4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a.git \
  --config /var/opt/gitlab/gitaly/config.toml
```

Or With Gitaly

```
cat /tmp/custom_hooks.tar | \
/opt/gitlab/embedded/bin/gitaly hooks set \
--storage default \
--repository @hashed/4b/22/4b227777d4dd1fc61c6f884f48641d02b4d121d3fd328cb08b5531fcacdabf8a.git \
--config /var/opt/gitlab/gitaly/config.toml
```
