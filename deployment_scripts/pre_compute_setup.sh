#!/usr/bin/env bash

lineno=$(iptables -nvL INPUT --line-numbers | grep "state RELATED,ESTABLISHED" | awk '{print $1}')
iptables -I INPUT $lineno -s 0.0.0.0/0 -p udp -m multiport --dports 4789 -m comment --comment "001 vxlan incoming" -j ACCEPT

lineno=$(iptables -nvL INPUT --line-numbers | grep "state NEW,RELATED,ESTABLISHED" | awk '{print $1}')
iptables -I INPUT $lineno -s 0.0.0.0/0 -p tcp -m multiport --dports 9697 -m comment --comment "Nuage metadata listen port for tenant VM metadata requests on compute" -j ACCEPT

iptables-save > /etc/iptables/rules.v4

out=$(cat /proc/net/bonding/bond0 | grep "Slave Interface" | grep "eth")

if [[ " ${out[*]} " == *"eth"* ]]; then
    echo "NIC Bonding exists on Openstack nodes"
    bond_intf=$(ifconfig -a | grep "bond" | awk '{print $1}')
    for intf in $bond_intf
    do
     (dhclient $intf) & sleep 10 ; kill $!
    done
    exit 0
else
    echo "No NIC Bonding present on Openstack nodes"
fi

intf_list=$(ifconfig -a | grep "eth" | awk '{print $1}')

for intf in $intf_list
do
 (dhclient $intf) & sleep 10 ; kill $!
done
