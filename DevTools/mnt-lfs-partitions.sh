#!/bin/bash

# Bash script to mount LFS partitions after rebooting Gentoo Host LiveCD OS

# COLORS
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

problems=0

echo "Setting up mount point..."
sleep 1s
mkdir -pv $LFS
if [ $? -eq 0 ]; then
    echo -e "${GREEN}[OK]${NC} 1st process (mkdir) was done!"
else
    echo -e "${RED}[ERROR]${NC} Failed to create mount point!"
    problems=$((problems + 1))
fi

sleep 1s
echo "Mounting /dev/sda3 as root partition..."
mount -v -t ext4 /dev/sda3 $LFS
if [ $? -eq 0 ]; then
    echo -e "${GREEN}[OK]${NC} 2nd process (mount /dev/sda3) was done!"
else
    echo -e "${RED}[ERROR]${NC} Failed to mount /dev/sda3!"
    problems=$((problems + 1))
fi

sleep 2s
echo "Creating and mounting boot partition..."
mkdir -pv $LFS/boot
sleep 1s
mount -v -t ext4 /dev/sda1 $LFS/boot
if [ $? -eq 0 ]; then
    echo -e "${GREEN}[OK]${NC} 3rd process (mount /dev/sda1) was done!"
else
    echo -e "${RED}[ERROR]${NC} Failed to mount /dev/sda1!"
    problems=$((problems + 1))
fi

sleep 2s
echo "Changing permissions to root..."
chown root:root $LFS && chmod 755 $LFS
if [ $? -eq 0 ]; then
    echo -e "${GREEN}[OK]${NC} 4th process (permissions) was done!"
else
    echo -e "${RED}[ERROR]${NC} Failed to set permissions!"
    problems=$((problems + 1))
fi

sleep 1s
echo "-----------------------------"
if [ "$problems" -eq 0 ]; then
    echo -e "${GREEN}0 problems found ✔️${NC}"
else
    echo -e "${RED}$problems problem(s) found ❌${NC}"
fi
