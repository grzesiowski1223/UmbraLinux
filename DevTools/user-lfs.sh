#!/bin/bash

#Do not run this command if the lsf default user is already created [That sole porpouse is that gentoo live usb is not persistent so it deletes the lfs user]

# COLORS
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

problems=0

groupadd lfs
  sleep 1s
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
  sleep 1s
sudo su - lfs
  sleep 1s
export LFS=/mnt/lfs
