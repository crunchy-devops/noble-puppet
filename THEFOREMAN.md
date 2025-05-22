# TheForeman

## install foreman
```bash
sudo -s
apt update
apt install wget ca-certificates
cd /tmp && wget https://apt.puppet.com/puppet8-release-jammy.deb
apt install /tmp/puppet8-release-jammy.deb
sudo apt install /tmp/puppet8-release-jammy.deb
wget https://deb.theforeman.org/foreman.asc -O /etc/apt/trusted.gpg.d/foreman.asc       
sudo wget https://deb.theforeman.org/foreman.asc -O /etc/apt/trusted.gpg.d/foreman.asc  
sudo echo "deb http://deb.theforeman.org/ jammy nightly" | sudo tee /etc/apt/sources.list.d/foreman.list
sudo echo "deb http://deb.theforeman.org/ plugins nightly" | sudo tee -a /etc/apt/sources.list.d/foreman.list
sudo apt update
sudo apt upgrade
sudo apt install foreman-installer
sudo foreman-installer
hostname -f
sudo foreman-installer -i
```
