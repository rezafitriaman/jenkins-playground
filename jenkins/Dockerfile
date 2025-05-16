FROM jenkins/jenkins

USER root

COPY remote-key /tmp/remote-key

RUN chown jenkins:jenkins /tmp/remote-key

RUN chmod 600 /tmp/remote-key

USER jenkins

# To loggin use admin - Admin