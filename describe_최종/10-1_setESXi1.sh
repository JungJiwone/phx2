#https://www.nakivo.com/blog/most-useful-esxcli-esxi-shell-commands-vmware-environment/
#https://docs.vmware.com/kr/VMware-vSphere/7.0/com.vmware.vsphere.networking.doc/GUID-8BCBB25E-9A84-4322-94BC-C556DE9C2956.html
#https://vdc-download.vmware.com/vmwb-repository/dcr-public/24be7af7-d9cd-48d9-bab8-8c91614be19d/0ca33108-8017-4b40-86b9-f066456894ea/doc/GUID-33939200-1D76-4C67-9607-77C586ADDFBA.html

#!/bin/sh

# Set the network adapter name to be used as the management network
management_network_adapter1="vmnic0"
management_network_adapter2="vmnic1"

# Set the name of the vSwitch
vswitch_name="vSwitch0"

# Add the network adapters to the vSwitch
esxcfg-vswitch -L "vmnic1" "vSwitch0"

# Configure the IP address, netmask, default gateway, dns server for the management network
esxcli network ip interface ipv4 set -i vmk0 -t static -g 20.20.20.1 -I 20.20.20.11 -N 255.255.255.0
esxcli network ip dns server add --server="20.20.20.2"
esxcli system hostname set --host="PHX-ESXi-01"
esxcli system hostname --domain="vclass.phoenix"

# restart management network
service.sh restart

# check configuration
esxcli network ip interface ipv4 get --interface-name="vmk0"
