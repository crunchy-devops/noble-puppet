# Alpine Linux with Python, SSH, and Puppet Agent

This container provides an Alpine Linux environment with:
- Python 3
- SSH Server
- Puppet Agent (installed via Ruby gems)
- Supervisor (managing services)

## Building the Container

```bash
docker build -t alpine-puppet .
```

## Running the Container

```bash
docker run -d -p 22:22 alpine-puppet
```

The container will start with:
- SSH server running on port 22
- Puppet agent running and managed by supervisor
- Python 3 available for use

Note: 
- This setup uses Puppet installed via Ruby gems as Alpine Linux doesn't have official Puppet packages
- Remember to set up proper SSH credentials and Puppet configuration before using in production
