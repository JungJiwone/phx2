#!/bin/sh

# Set the network adapter name to be used as the management network
management_network_adapter1="vmnic0"
management_network_adapter2="vmnic1"

# Set the name of the vSwitch
vswitch_name="vSwitch0"

# Add the network adapters to the vSwitch
esxcfg-vswitch -L "vmnic1" "vSwitch0"

# Configure the IP address, netmask, default gateway, dns server for the management network
esxcli network ip interface ipv4 set -i vmk0 -t static -g 20.20.20.1 -I 20.20.20.13 -N 255.255.255.0
esxcli network ip dns server add --server="20.20.20.2"
esxcli system hostname set --host="PHX-ESXi-03"
esxcli system hostname --domain="vclass.phoenix"

# restart management network
service.sh restart

# check configuration
esxcli network ip interface ipv4 get --interface-name="vmk0"
