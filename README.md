# Automated Secure Web Stack (RHCSA/DO188 Project)

An automated deployment pipeline for a hardened, containerized Python application on RHEL.

## Features
* **Rootless Podman:** Enhanced security by running without root privileges.
* **Systemd Integration:** Automated lifecycle management and self-healing.
* **Idempotent Scripting:** One-command deployment (`deploy.sh`).

## How to Run
1. Clone the repo.
2. Run `chmod +x deploy.sh`.
3. Execute `./deploy.sh`.
