#!/bin/bash

#Automated script to run after each reboot of the Developer Host OS

# COLORS
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

export LFS=/mnt/lfs

echo Checking_for_LFS_variable
echo $LFS

if [ "$LFS" = "/mnt/lfs" ]; then
    echo -e "${GREEN}[OK] ${NC}LFS variable set properly to /mnt/lfs"
else
    echo -e "${RED}[ERROR] ${NC}LFS is NOT set to /mnt/lfs.  ERR-10"
fi

echo ".."
echo "Checking_For_umask_variable"
echo ".."
sleep 2s

if [ "$(umask)" = "0022" ]; then
    echo -e "${GREEN}[OK] ${NC}Umask set properly to 0022"
else
    echo -e "${RED}[ERROR] ${NC}Umask is NOT set properly to 0022.  ERR-22"
fi

problems=0

echo "Setting up mount point..."
sleep 1s
mkdir -pv $LFS
if [ $? -eq 0 ]; then
    echo -e "${GREEN}[OK]${NC} 1st process (mkdir) was done!"
else
    echo -e "${RED}[ERROR]${NC} Failed to create mount point! ERR-01"
    problems=$((problems + 1))
fi

sleep 1s
echo "Mounting /dev/sda3 as root partition..."
mount -v -t ext4 /dev/sda3 $LFS
if [ $? -eq 0 ]; then
    echo -e "${GREEN}[OK]${NC} 2nd process (mount /dev/sda3) was done!"
else
    echo -e "${RED}[ERROR]${NC} Failed to mount /dev/sda3! ERR-002"
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
    echo -e "${RED}[ERROR]${NC} Failed to mount /dev/sda1! ERR-003"
    problems=$((problems + 1))
fi

sleep 2s
echo "Changing permissions to root..."
chown root:root $LFS && chmod 755 $LFS
if [ $? -eq 0 ]; then
    echo -e "${GREEN}[OK]${NC} 4th process (permissions) was done!"
else
    echo -e "${RED}[ERROR]${NC} Failed to set permissions! ERR-004"
    problems=$((problems + 1))
fi

sleep 2s

echo "Turning swap partition on..."
/sbin/swapon -v /dev/sda2
if [ $? -eq 0 ]; then
    echo -e "${GREEN}[OK]${NC} 5th process (swapON) was done!"
else
    echo -e "${RED}[ERROR]${NC} Failed to turn swapON! ERR-005"
    problems=$((problems + 1))
fi

sleep 1s
echo "-----------------------------"
if [ "$problems" -eq 0 ]; then
    echo -e "${GREEN}0 problems found ✔️${NC}"
else
    echo -e "${RED}$problems problem(s) found ❌${NC}"
fi

groupadd lfs
  sleep 1s
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
  sleep 1s
sudo su - lfs
  sleep 1s
export LFS=/mnt/lfs
