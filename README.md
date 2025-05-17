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
## Pre-requisites

portainer 
```shell
docker volume create portainer_data
docker run -d -p 32125:8000 -p 32126:9443 --name portainer --restart=always \
-v /var/run/docker.sock:/var/run/docker.sock \
-v portainer_data:/data portainer/portainer-ce:latest 
```

## Puppet Master

```bash
sudo apt update -y
sudo apt install puppet-master
sudo tac /etc/default/puppetserver
sudo grep ARGS /etc/default/puppetserver
sudo grep 1g /etc/default/puppetserver
sudo sed -i 's/1g/2g/g' /etc/default/puppetserver
sudo grep 2g /etc/default/puppetserver
sudo systemctl start puppetserver
sudo systemctl enable puppetserver
sudo systemctl status puppetserver
```

## Start portainer
```bash
docker volume create portainer_data
docker run -d -p 32125:8000 -p 32126:9443 --name portainer --restart=always \
-v /var/run/docker.sock:/var/run/docker.sock \
-v portainer_data:/data portainer/portainer-ce:latest
```
log on immediate to https://<vm ip>:32126 and create a account and password 
because portainer container will be timeout

## Start containers 
```bash
# add-host is this internal DNS entry for the puppet server
docker run --name target1 -d -p 2222:22 --add-host=puppet:10.200.15.207 alma-puppet
docker run --name target2 -d -p 2223:22 --add-host=puppet:10.200.15.207 alpine-puppet
docker run --name target3 -d -p 2224:22 --add-host=puppet:10.200.15.207 ubuntu-puppet
```

## Adding a DNS entry on all containers 
```shell

ping -c 3 puppet # Test ping
puppet agent -t  # Check if it's work fine
```
## List of Certificates Authority on server
```shell
# as root on puppet server host
/usr/bin/puppetserver ca list -a # list all current certificats
```

## Caveats, useful commands
```shell
sudo puppet resource service puppet ensure=stopped
sudo puppet resource service puppetserver ensure=stopped
sudo puppetserver ca setup
sudo puppet resource service puppetserver ensure=running
sudo puppet resource service puppet ensure=running

