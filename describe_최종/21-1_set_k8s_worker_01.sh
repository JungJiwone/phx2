#!/usr/bin/bash

su - << EOF
VMware1!
hostnamectl set-hostname k8s-worker-01
cat /home/phoenix/set_net.yml > /etc/netplan/01-network-manager-all.yaml
netplan apply
echo "127.0.0.1 k8s-worker-01" >> /etc/hosts
EOF
