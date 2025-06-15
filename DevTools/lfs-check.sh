#!/bin/bash

#Check for LFS variable and umask number script

#Created by grzesowski1223

# COLORS
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

echo Checking_for_LFS_variable
echo $LFS

if [ "$LFS" = "/mnt/lfs" ]; then
    echo -e "${GREEN}[OK] ${NC}LFS variable set properly to /mnt/lfs"
else
    echo -e "${RED}[ERROR] ${NC}LFS is NOT set to /mnt/lfs"
fi

echo ".."
echo "Checking_For_umask_variable"
echo ".."
sleep 2s

if [ "$(umask)" = "0022" ]; then
    echo -e "${GREEN}[OK] ${NC}Umask set properly to 0022"
else
    echo -e "${RED}[ERROR] ${NC}Umask is NOT set properly to 0022"
fi
