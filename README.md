# Archiso with ZFS

This repository contains a script to build an archlinux ISO that also contains
the ZFS module and ZFS utilities. The ISO-building happens in a container, so
no additional dependencies (other than docker) are required on the host system.

2 Additional helpers exist in order to make installing ZFS inside of the final
system easier:

* `/zfs-key.sh` is a script to add the archzfs pacman key. This saves you the tedious job of manually typing the ID
* `/zfs-pacman.conf` is the pacman configuration for the archzfs repository

```
# pacstrap ......
# cat /zfs-pacman.conf >> /mnt/etc/pacman.conf
# cp /zfs-key.sh /mnt/zfs-key.sh
# arch-chroot /mnt
# /zfs-key.sh
```

## Buiding the ISO

To build the ISO run `make build`. A ISO fill will be generated in the `./out` directory
