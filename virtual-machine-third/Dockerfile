FROM ubuntu:latest

USER root

RUN apt-get -y update && apt-get -y install openssh-server vim python3 ca-certificates curl gnupg lsb-release

RUN useradd -m deepChinchilla && \
    echo "deepChinchilla:admin" | chpasswd && \
    mkdir /home/deepChinchilla/.ssh && \
    chmod 700 /home/deepChinchilla/.ssh

COPY ./.ssh/id_rsa.pub /home/deepChinchilla/.ssh/authorized_keys
RUN chmod 600 /home/deepChinchilla/.ssh/authorized_keys && \
    chown -R deepChinchilla:deepChinchilla /home/deepChinchilla/.ssh

RUN mkdir -p /run/sshd && ssh-keygen -A

# Install Docker engine
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
RUN echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
      $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
      tee /etc/apt/sources.list.d/docker.list > /dev/null

RUN apt-get -y update && apt-get -y install docker-ce-cli docker-compose-plugin

EXPOSE 22

CMD ["/usr/sbin/sshd", "-D"]
