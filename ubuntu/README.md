# Ubuntu 22.04 with Python, SSH, and Puppet Agent

This container provides an Ubuntu 22.04 environment with:
- Python 3
- SSH Server
- Puppet Agent
- Supervisor (managing services)

## Building the Container

```bash
docker build -t ubuntu-puppet .
```

## Running the Container

```bash
docker run -d -p 2222:22 ubuntu-puppet
```

The container will start with:
- SSH server running on port 2222
- Puppet agent running and managed by supervisor
- Python 3 available for use

Note: Remember to set up proper SSH credentials and Puppet configuration before using in production.
