# Noble Puppet

Noble Puppet is a collection of Dockerfiles for creating containers with Puppet and ssh installed and configured.

## install docker and puppetmaster on alma-linux 9
```shell
sudo -s
dnf update -y
dnf install epel-release -y
dnf install htop -y
vi /etc/sysconfig/selinux
setenforce 0
dnf install https://yum.puppet.com/puppet8-release-el-9.noarch.rpm
dnf install puppetserver
vim /etc/sysconfig/puppetserver
hostnamectl set-hostname puppetmaster.example.com
vim /etc/hosts
hostnamectl
vim /etc/puppetlabs/puppet/puppet.conf
systemctl start puppetserver
systemctl enable puppetserver
systemctl status puppetserver
puppetserver -v
# install docker
dnf update -y
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install docker-ce docker-ce-cli containerd.io
systemctl start docker
systemctl enable docker
# choose your username
usermod -aG docker $USER
```

## Install Docker on Ubuntu 24.10
```shell
sudo apt update
sudo apt install -y curl apt-transport-https ca-certificates software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce -y
sudo systemctl status docker
sudo usermod -aG docker $USER
# log out log in again
docker ps # check
```

## Containers Supported OS

- AlmaLinux 9
- Alpine Linux
- Ubuntu 24.10

## install Puppet Master

```bash
sudo apt update -y
sudo apt install puppetserver
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
log on immediately to https://<vm_ip>:32126 and create a account and password 
because portainer container will be timeout

## build containers
```bash
git clone https://github.com/crunchy-devops/noble-puppet.git
cd noble-puppet
cd alma
docker build -t alma-puppet .
cd ../alpine
docker build -t alpine-puppet .
cd ../ubuntu
docker build -t ubuntu-puppet .
```


## Start containers 
```bash
# add-host is this internal DNS entry for the puppet server
docker run --name target1 -d -p 2222:22 --add-host=puppet:10.200.15.208 --hostname=alma.com alma-puppet
docker run --name target2 -d -p 2223:22 --add-host=puppet:10.200.15.208 --hostname=alpine.com alpine-puppet
docker run --name target3 -d -p 2224:22 --add-host=puppet:10.200.15.208 --hostname=ubuntu.com ubuntu-puppet
```

## Adding a DNS entry on all containers 
```shell

ping -c 3 puppet # Test ping
puppet agent -tv # Check if it's work fine
```
## List of Certificates Authority on server
```shell
# as root on puppet server host
/usr/bin/puppetserver ca list -a # list all current certificats
```
## Sign all certificates
```shell
# as root on puppet server host
/usr/bin/puppetserver ca sign -a
```

## Caveats, useful commands
```shell
sudo puppet resource service puppet ensure=stopped
sudo puppet resource service puppetserver ensure=stopped
sudo puppetserver ca setup
sudo puppet resource service puppetserver ensure=running
sudo puppet resource service puppet ensure=running

