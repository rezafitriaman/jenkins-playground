FROM jenkins/jenkins

# Use root to install more tools
USER root

# Install ansible
RUN apt -y update && apt -y install pipx && pipx install --include-deps ansible && pipx ensurepath

# Install Docker engine
RUN apt -y update && apt -y install ca-certificates curl
RUN install -m 0755 -d /etc/apt/keyrings
RUN curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
RUN chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
RUN echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  tee /etc/apt/sources.list.d/docker.list > /dev/null
RUN apt -y update

RUN apt -y install docker-ce-cli docker-compose-plugin

# Switch to default user
USER jenkins
