#!/bin/bash
set -e

export LFS=/mnt/lfs

echo ">>> Creating Mount points..."
mkdir -pv $LFS
mount -v /dev/sda3 $LFS

mkdir -pv $LFS/boot/efi
mount -v /dev/sda2 $LFS/boot/efi

echo ">>> Enabling swap..."
swapon /dev/sda4

echo ">>> Mountings..."
mount -v --bind /dev $LFS/dev
mount -v --bind /dev/pts $LFS/dev/pts
mount -vt proc proc $LFS/proc
mount -vt sysfs sysfs $LFS/sys
mount -vt tmpfs tmpfs $LFS/run

if [ -h $LFS/dev/shm ]; then
  echo ">>> /dev/shm ..."
  mkdir -pv $LFS/$(readlink $LFS/dev/shm)
fi

echo "✅ Done go chroot:"
echo "chroot $LFS /usr/bin/env -i HOME=/root TERM=\"$TERM\" PS1='(lfs chroot) \\u:\\w\\$ ' PATH=/bin:/usr/bin:/sbin:/usr/sbin /bin/bash"
