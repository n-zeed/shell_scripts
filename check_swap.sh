#!/bin/bash
# check-swap | grep httpd | awk '{mem+=$2}{size=$3}{process=$1} END {print process " " mem " " size}'
# check-swap | grep httpd | awk '{proc=$1}{sep=" "}{mem+=$2}{unit=$3} END {print proc sep mem sep unit}'
for proc_file in /proc/*/status ; do 
    awk '/VmSwap|Name/{printf $2 " " $3}END{ print ""}' ${proc_file} 
done | sort -k 2 -n #-r
