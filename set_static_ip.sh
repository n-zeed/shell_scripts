#!/bin/bash
## Set Static IP in CentOS 6.x
## Set Constants
IFCFG_FILE="/etc/sysconfig/network-scripts/ifcfg-eth0"
NETWORK_FILE="/etc/sysconfig/network"
RESOLV_FILE="/etc/resolv.conf"
IPADDR="192.168.0.70"
IPGTWY="192.168.0.1"
SRV_HOSTNAME="centos6"

# Backup original scripts
cp -v ${IFCFG_FILE} ${IFCFG_FILE}.bak
cp -v ${NETWORK_FILE} ${NETWORK_FILE}.bak
cp -v ${RESOLV_FILE} ${RESOLV_FILE}.bak

## Configure eth0
sed -i.bak 's/ONBOOT=no/ONBOOT=yes/' ${IFCFG_FILE}
sed -i.bak 's/BOOTPROTO=dhcp/BOOTPROTO=static/' ${IFCFG_FILE}
echo "IPADDR=${IPADDR}" >> ${IFCFG_FILE}
echo "NETMASK=255.255.255.0" >> ${IFCFG_FILE}

## Configure Default Gateway
echo "NETWORKING=yes" > ${NETWORK_FILE}
echo "HOSTNAME=${SRV_HOSTNAME}" >> ${NETWORK_FILE}
echo "GATEWAY=${IPGTWY}" >> ${NETWORK_FILE}

## Configure DNS Server
# vi /etc/resolv.conf
# nameserver 8.8.8.8      # Replace with your nameserver ip
# nameserver 192.168.1.1  # Replace with your nameserver ip

## Restart Network Interface
/etc/init.d/network restart
