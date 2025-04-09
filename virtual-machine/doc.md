`FROM fedora:latest`
- Purpose: Specifies the base image (Fedora Linux, latest version).
- Effect: The container will start with a clean Fedora OS environment.
- Doc: [Fedora](https://hub.docker.com/_/fedora)

---

`RUN yum -y install openssh-server`
- Purpose: Installs the OpenSSH server package.
- Details:
  - `yum`: Fedora's package manager (like `apt` for Ubuntu).
  - `-y`: Automatically answers "yes" to prompts (non-interactive mode).
  - `openssh-server`: The package that provides SSH server functionality (sshd).
- Why?: Allows SSH connections into the container.
- Doc: [Setting up an ssh server example](https://www.brandonrohrer.com/ssh_at_home)

---

`RUN useradd remote_user && \`
This block create a user (`remote_user`) and sets up SSH access for them:

`useradd remote_user`
- Create a new user named `remote_user`.

`echo "Admin" | passwd remote_user --stdin`
- Sets the password for `remte_user` to `"Admin"`.
  - `--stdin`: Reads the password from standard input (piped via `echo`).
  - Warning: Hardcoding passwords in plaintext is insecure (use SSH keys in production)

`mkdir /home/remote_user/.ssh`
- Creates the `.ssh` directory (where SSH keys are stored).
  - Default path for authorized keys: `/home/remote_user/.ssh/authorized_keys`.

`chmod 700 /home/remote_user/.ssh`
- Restricts permissions on the `.ssh` directory:
  - `700` = Only `remote_user` can read/write/execute (security best practice).
  - [Basic Linux Directory Permissions](https://docs.rackspace.com/docs/basic-linux-directory-permissions-and-how-to-check-them).

`COPY remote-key.pub /home/remote_user/.ssh/authorized_keys`
- Purpose: Copies your local `remote-key.pub` (SSH public key) into the container.
- Effect:
  - The `authorized_keys` file lists public keys allowed to log in via SSH.
  - This enables passwordless SSH login for `remote_user` using the private key (`remote-key`).

---

```
RUN chown remote_user:remote_user -R /home/remote_user/.ssh/ && \
chmod 600 /home/remote_user/.ssh/authorized_keys
```
- Purpose: Fixes ownership and permissions for SSH security.
  - `chown`: Makes `remote_user` the owner of the `.ssh` directory and its contents.
  - `chmod 600`: Restricts `authorized_keys` to read/write for the owner only (critical to prevent unauthorized edits).

---

`RUN /usr/sbin/sshd-keygen`
replace it with:
`RUN ssh-keygen -A`
- It generates these in `/etc/ssh/`:
```
ssh_host_rsa_key      (RSA, for compatibility)  
ssh_host_ecdsa_key    (ECDSA, secure default)  
ssh_host_ed25519_key  (Ed25519, most secure)  
```
- Purpose: Generates host SSH keys for the container's SSH server.
- Effect: Create keys like `/etc/ssh/ssh_host_rsa_key` (required for the server to function).
- Note: Some images skip this if keys exist, but explicit generateion ensures they're present.

---

`CMD /usr/sbin/sshd -D`
- Purpose: Starts the SSH server when the container launches.
  - `-D`: Runs `sshd` in the foreground (keeps the container alive).
- Why?: Without this, the container would exit immediately after starting.