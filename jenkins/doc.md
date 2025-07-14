#### This dockerfile configures a custom Jenkins container with proper permissions for an SSH key.

`FROM jenkins/jenkins`
- What it does: Start with the official Jenkins Docker image as our base.
- Why: This gives us a pre-configured Jenkins installation to build upon.

`USER root`
- What it does: Switches to the rot user inside the container
- Why: Wee need root privileges to:
  - Change file ownership
  - Modify permissions
  - Install packages (though we're not doing that here)

`COPY remote-key /tmp/remote-key` TODO look up how to create `remote-key`?
- What it does: Copies your local `remote-key` file into the container at `/tmp/remote-key`
- Details:
  - The file is initially owned by root (default behavior)
  - Permissions are inherited from the original file (usually to permissive for SSH keys)

`RUN chown jenkins:jenkins /tmp/remote-key` TODO when do I create jenkins as a user?
- What it does: Changes ownership of the key file to the Jenkins user
- Why this matters:
  - Jenkins runs as the `jenkins` user (UID 1000)
  - The process needs to be able to read this key file
  - Without this, Jenkins couldn't access the key even with correct permissions

`RUN chmod 600 /tmp/remote-key`
- What it does: Sets strict file permissions (read/write for owner only)
- Why 600?:
  - Owner (jenkins): red + write (rw-)
  - Group: no access (---)
  - Others: no access (---)
- More pen permissions would cause SSH to reject the key

`User jenkins`
- What it does: Switches back to jenkins user
- Why: 
  - Security best practice: containers shouldn't run as root
  - Jenkins is designed to run as the `jenkins` user
  - Reduces attack surface if container is compromised