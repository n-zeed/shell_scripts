#!/bin/bash
cd /var
touch swap.img && chmod 600 swap.img

dd if=/dev/zero of=/var/swap.img bs=2024k count=1024
mkswap /var/swap.img && swapon /var/swap.img

echo "/var/swap.img  none  swap  sw  0  0" >> /etc/fstab
