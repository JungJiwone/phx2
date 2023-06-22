#!/usr/bin/bash

cat /home/phoenix/set_net.yml > /etc/netplan/01-network-manager-all.yaml
netplan apply

rm -rf /var/lib/dpkg/lock-frontend
rm -rf /var/lib/dpkg/lock

# repository update
#sudo systemctl stop unattended-upgrades.service
apt update -y
apt upgrade -y

# ssh server install
apt install -y openssh-server

# ifconfig command install
apt install -y net-tools

# package install
apt install -y ca-certificates curl gnupg lsb-release

# vim package install
apt install -y vim

# iptables install
echo 'iptables-persistent iptables-persistent/autosave_v4 boolean true' | sudo debconf-set-selections
echo 'iptables-persistent iptables-persistent/autosave_v6 boolean false' | sudo debconf-set-selections
apt install -y iptables-persistent

# add hosts file 
echo "127.0.0.1 k8s-master" > /etc/hosts
echo "20.20.50.2 k8s-master" >> /etc/hosts
echo "20.20.50.3 k8s-worker-01" >> /etc/hosts
echo "20.20.50.4 k8s-worker-02" >> /etc/hosts
echo "20.20.50.5 k8s-worker-03" >> /etc/hosts
