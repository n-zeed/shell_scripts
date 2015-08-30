#!/bin/bash
iptables -P INPUT ACCEPT
iptables -F

#Tell the firewall to take all incoming packets with tcp flags NONE and just DROP them. Null packets are, simply said, recon packets
iptables -A INPUT -p tcp --tcp-flags ALL NONE -j DROP
#reject is a syn-flood attack. Syn-flood attack means that the attackers open a new connection, but do not state what they want (ie. SYN, ACK, whatever). They just want to take up our servers' resources.
iptables -A INPUT -p tcp ! --syn -m state --state NEW -j DROP
#XMAS packets, also a recon packet. 
iptables -A INPUT -p tcp --tcp-flags ALL ALL -j DROP

iptables -A INPUT -i lo -j ACCEPT
iptables -I INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT
iptables -A INPUT -p tcp -m tcp --dport 22 -j ACCEPT 

##open ssh port to specific IP
#iptables -A INPUT -p tcp -s SOURCE_IP_ADDRESS -m tcp --dport 22 -j ACCEPT
##Rules for NFS server
#iptables -I INPUT -m state --state NEW -p tcp -m multiport --dports 111,892,2049,32803 -s SOURCE_IP_ADDRESS -j ACCEPT
##Rules for http(s)
#iptables -A INPUT -p tcp -m multiport --dports 80,443 -j ACCEPT
##Rules for mysql
#iptables -A INPUT -p tcp --dport 3306 -j ACCEPT
##Rules for squid proxy
#iptables -A INPUT -p tcp --dport 3128 -j ACCEPT

iptables -P INPUT DROP
iptables -P FORWARD DROP
iptables -P OUTPUT ACCEPT
iptables-save > /etc/sysconfig/iptables
service iptables restart
