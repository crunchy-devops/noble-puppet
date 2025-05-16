# Noble Puppet

Noble Puppet is a collection of Dockerfiles for creating containers with Puppet and ssh installed and configured.

## Supported OS

- AlmaLinux 9
- Alpine Linux
- Ubuntu 24.10

## Usage

```bash
    git clone https://github.com/crunchy-devops/noble-puppet.git
    cd noble-puppet
    docker build -t alma9-puppet alma/
    docker run -d -p 2222:22 alma9-puppet
```
    