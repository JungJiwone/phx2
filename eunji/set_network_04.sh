#!/bin/sh

# Set the network adapter name to be used as the management network
management_network_adapter1="vmnic0"
management_network_adapter2="vmnic1"

# Set the name of the vSwitch
vswitch_name="vSwitch0"

# Set the name of the port group for the management network
port_group_name="Management Network"

# Add the network adapters to the vSwitch
esxcfg-vswitch -L "$network_adapter1" "$vswitch_name"
esxcfg-vswitch -L "$network_adapter2" "$vswitch_name"

# Add the port group to the vSwitch
esxcfg-vswitch -A "$port_group_name" "$vswitch_name"

# # Restart the management network
# esxcli network vswitch standard uplink add --uplink-name="$management_network_adapter" --vswitch-name="$new_vswitch"
# esxcli network ip interface set --interface-name="$management_network_name" --type=static

# Set the name of the management network
management_network_name="Management Network"

# Set the IP address and subnet mask for the management network
management_network_ip="10.10.10.14"
management_network_subnet="255.255.255.0"

# Set the default gateway for the management network
management_network_gateway="10.10.10.1"

# Set the DNS server(s) for the management network
management_network_dns="10.10.10.10"

# Configure the IP address, subnet mask, default gateway, and DNS server(s) for the management network
esxcli network ip interface ipv4 set --interface-name="$management_network_name" --ipv4="$management_network_ip" --netmask="$management_network_subnet"
esxcli network ip route ipv4 add --gateway="$management_network_gateway" --network="$management_network_ip"