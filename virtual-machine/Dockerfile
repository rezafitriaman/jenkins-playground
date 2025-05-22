FROM fedora:latest

USER root

RUN yum -y update && yum -y install openssh-server && yum -y install postgresql && yum -y install vim-enhanced && yum -y install python

RUN useradd remote_user && \
    echo "Admin" | passwd remote_user --stdin && \
    mkdir /home/remote_user/.ssh && \
    chmod 700 /home/remote_user/.ssh

COPY remote-key.pub /home/remote_user/.ssh/authorized_keys

RUN chown remote_user:remote_user -R /home/remote_user/.ssh/ && \
    chmod 600 /home/remote_user/.ssh/authorized_keys

RUN ssh-keygen -A

USER remote_user

CMD /usr/sbin/sshd -D