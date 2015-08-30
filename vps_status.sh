#!/bin/bash

## System Colors ##
black='\e[0;30m'
blue='\e[0;34m'
green='\e[0;32m'
cyan='\e[0;36m'
red='\e[0;31m'
purple='\e[0;35m'
brown_orange='\e[0;33m'
light_gray='\e[0;37m'
dark_gray='\e[1;30m'
light_blue='\e[1;34m'
light_green='\e[1;32m'
light_cyan='\e[1;36m'
light_red='\e[1;31m'
light_purple='\e[1;35m'
yellow='\e[1;33m'
white='\e[1;37m'
NC='\e[0m'

## System Commands ##
ssh_ip=`echo ${SSH_CONNECTION} | cut -d ' ' -f 1`
sys_uptime=`uptime`
free_mem=`free -m | sed s/://g | awk '/Mem|Swap/{printf $1" Used: " $3"MB "}END{print ""}'`
eth0_data=`/sbin/ifconfig | grep venet0 -A 7| grep "RX bytes" | sed s/"          "/"eth0  "/g`
est_connections_count=`netstat -an | grep  ESTABLISHED | wc -l`
updates=`sudo yum check-update | grep -v 'mirrors.kernel.org\|linux.mirrors.es.net' | grep updates | wc -l`
free_space=`df -h | awk '/vda/ {print $4 " Free"}'`


## Show Message ##
clear
echo """
███╗   ██╗███████╗ ██████╗     ███████╗███████╗███████╗██████╗ 
████╗  ██║██╔════╝██╔═══██╗    ╚══███╔╝██╔════╝██╔════╝██╔══██╗
██╔██╗ ██║█████╗  ██║   ██║      ███╔╝ █████╗  █████╗  ██║  ██║
██║╚██╗██║██╔══╝  ██║   ██║     ███╔╝  ██╔══╝  ██╔══╝  ██║  ██║
██║ ╚████║███████╗╚██████╔╝    ███████╗███████╗███████╗██████╔╝
╚═╝  ╚═══╝╚══════╝ ╚═════╝     ╚══════╝╚══════╝╚══════╝╚═════╝ 
"""
echo -e "${light_blue}Welcome back ${yellow}${USER} ${light_blue}!!"
echo -e "Here is the current status for your VPS:\n${NC}"
echo -e "${white}connected from: ${yellow}${ssh_ip}\n"
echo -e "${green}${sys_uptime}"
echo -e "${red}${eth0_data}"
echo -e "${white}${free_mem}"
echo -e "${white}FileSystem: ${brown_orange}${free_space}"
echo -e "${white}${est_connections_count} ${cyan}established connection(s)"
echo -e "${yellow}${updates}${white} updates available${NC}"

