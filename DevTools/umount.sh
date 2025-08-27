#!/bin/bash

umount_try() {
    echo ">>> Unmounting $1"
    umount -v "$1" || umount -rv "$1"
}

umount_try "$LFS/dev/pts"
mountpoint -q "$LFS/dev/shm" && umount_try "$LFS/dev/shm"
umount_try "$LFS/dev"
umount_try "$LFS/run"
umount_try "$LFS/proc"
umount_try "$LFS/sys"
umount_try "$LFS"

echo "Umounting Completed"
