FROM jenkins/jenkins

# Use root to install more tools
USER root

# Install ansible
RUN apt -y update && apt -y install pipx && pipx install --include-deps ansible && pipx ensurepath

# Switch to default user
USER jenkins