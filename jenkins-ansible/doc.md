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