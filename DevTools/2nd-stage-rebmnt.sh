#!/bin/bash

export LFS=/mnt/lfs

echo ">>> Creating mount points"
mkdir -pv $LFS
mount -v /dev/sda3 $LFS

mkdir -pv $LFS/boot/efi
mount -v /dev/sda2 $LFS/boot/efi

echo ">>> Enabling swap"
swapon /dev/sda4

echo ">>> Mounting pseudo filesystems"
mount -v --bind /dev $LFS/dev
mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
  echo ">>> Creating /dev/shm as a directory..."
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi

echo "✅ All good"

chroot "$LFS" /usr/bin/env -i   \
    HOME=/root                  \
    TERM="$TERM"                \
    PS1='(lfs chroot) \u:\w\$ ' \
    PATH=/usr/bin:/usr/sbin     \
    MAKEFLAGS="-j$(nproc)"      \
    TESTSUITEFLAGS="-j$(nproc)" \
    /bin/bash --login
