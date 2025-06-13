##### Installing Ansible on Jenkins image

**We use this jenkins image:**
[Jenkins Image Documentation](https://github.com/jenkinsci/docker/blob/master/README.md)

**U need to install pipX first**
[PipX Documentation](https://pipx.pypa.io/stable/)

**U need to install pipX en then ansible:**
[Ansible Documentation](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html)

##### Ansible

**To enable Ansible on the targeted server u need to install Python:**
```
sudo -y yum update && sudo -y install python
```

**U need to create a hosts file in var/jenkins_home/**
```
mkdir ansible
```

**Need to copy the private ssh-file, hosts-file in to Ansible folder**
```
cp ./ssh-file ./jenkins_home/ansible/
cp ./hosts ./jenkins_home/ansible/
```

**In the hosts-file u need to disable the reuse of the ssh-connection**
```
ansible_ssh_args = -o ControlPersist=no
```
[Found on](https://stackoverflow.com/questions/78875678/jenkins-docker-container-ansible-fails-to-connect-via-ssh-when-run-via-jenkins)

**U need to tell Ansible where to find the python binary file in the targeted server**
```
ansible_python_interpreter=/usr/bin/python3
```

##### Ansible Command:
**To Test or ping the targeted machine from the host file:**
```
ansible -i hosts -m ping test1
ansible -i hosts -m ping test2
```
or both at once:
```
ansible -i hosts -m ping test
```

**Start ansible-playbook:**
```
ansible-playbook -i hosts play.yml
```

**Start ansible-playbook with a variable**
```
ansible-playbook -i hosts people.yml -e "PEOPLE_AGE=25"
```


---

**If u get this error:**
```
FATAL: Cannot run program "ansible-playbook": error=2, No such file or directory
java.io.IOException: error=2, No such file or directory
```
This happend because Jenkins cannot find `ansible-playbook` executable in *PATH environment* when executing the job.

U need to tell Jenkins where the Ansible executables are located, by configuring it in Global Tool Configuration.

- Step1:
Log into Jenkins container or host and run:
```
which ansible-playbook
```
[doc](https://www.geeksforgeeks.org/which-command-in-linux-with-examples/)

- Step2:
Go to Global Tool Configuration in Jenkins then go to Ansible installations section.

- Step3:
Add the name and the Path to ansible executables directory.
```
Name: AnsibleLocal
Path: /var/jenkins_home/.local/bin
```

##### Optional:
U can also add the path to ~/.bashrc or ~/.profile
```
export PATH=$PATH:/var/jenkins_home/.local/bin
```
then restart the jenkins container
```
docker restart <jenkins-container-name>
```

---

##### Linux Command:
**Sed:**
[How to use sed](https://www.geeksforgeeks.org/sed-command-in-linux-unix-with-examples/)

---

##### To trigger a job using curl or extern methode, u need to use API Token
- Login with the user u want to use
- Create an API Token under the security tab
- Copy the job link button

** Example how to use API Token to start a job**
curl \
-u ega:110bec899e4015ca60b34855f28ee46836 \
-X POST http://localhost:8080/job/Environment-variable-global/build?delay=0sec

**Example how to use API Token to start a job with parameter**
curl http://localhost:8080/job/ansible-users-db/buildWithParameters \
--user ega:110bec899e4015ca60b34855f28ee46836 \
--data AGE=24

OR

curl \
-u ega:110bec899e4015ca60b34855f28ee46836 \
-X POST http://localhost:8080/job/ansible-users-db/buildWithParameters?AGE=23&delay=0sec