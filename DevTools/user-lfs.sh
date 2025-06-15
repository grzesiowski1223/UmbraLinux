#!/bin/bash

#Do not run this command if the lsf default user is already created [That sole porpouse is that gentoo live usb is not persistent so it deletes the lfs user]

groupadd lfs
  sleep 1s
useradd -s /bin/bash -g lfs -m -k /dev/null lfs
  sleep 1s

passwd lfs
  sleep 1s
  
chown -v lfs $LFS/{usr{,/*},var,etc,tools}
case $(uname -m) in
  x86_64) chown -v lfs $LFS/lib64 ;;
esac
