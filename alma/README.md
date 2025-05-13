# AlmaLinux 9 with Python, SSH, and Puppet Agent

This container provides an AlmaLinux 9 environment with:
- Python 3
- SSH Server
- Puppet Agent
- Supervisor (managing services)

## Building the Container

```bash
docker build -t alma9-puppet .
```

## Running the Container

```bash
docker run -d -p 22:22 alma9-puppet
```

The container will start with:
- SSH server running on port 22
- Puppet agent running and managed by supervisor
- Python 3 available for use

Note: Remember to set up proper SSH credentials and Puppet configuration before using in production.
