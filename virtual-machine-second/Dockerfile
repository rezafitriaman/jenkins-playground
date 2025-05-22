FROM fedora:latest

USER root

RUN yum -y update && yum -y install openssh-server && yum -y install vim-enhanced && yum -y install python

RUN useradd reza && \
    echo "Admin" | passwd reza --stdin && \
    mkdir /home/reza/.ssh && \
    chmod 700 /home/reza/.ssh

COPY virtualMachineSecondKey.pub /home/reza/.ssh/authorized_keys

RUN chown reza:reza -R /home/reza/.ssh && \
    chmod 644 /home/reza/.ssh/authorized_keys

RUN ssh-keygen -A

USER reza

CMD /usr/sbin/sshd -D
