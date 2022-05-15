#!/bin/bash
# Script that is executed in order to build a custom
# ISO. This will be executed in a raw archlinux docker
# image as root. Use ${OUT_DIR} for the out/ directory

pacman-key --init
pacman -Syy
pacman --noconfirm -S archiso

# Initialize profile in /archlive
cp -R /usr/share/archiso/configs/releng/ /archlive

# Add archzfs key & repository
pacman-key -r DDF7DB817396A49B2A2723F7403BD972F75D9D76
pacman-key --lsign-key DDF7DB817396A49B2A2723F7403BD972F75D9D76
echo -e "\n\n\n[archzfs]\nServer = https://archzfs.com/\$repo/\$arch" >> /archlive/pacman.conf

# Add files to the ISO to make installation easier
echo 'pacman-key -r DDF7DB817396A49B2A2723F7403BD972F75D9D76' >> /archlive/airootfs/zfs-key.sh
echo 'pacman-key --lsign-key DDF7DB817396A49B2A2723F7403BD972F75D9D76' >> /archlive/airootfs/zfs-key.sh
chmod +x /archlive/airootfs/zfs-key.sh
echo -e "\n\n\n[archzfs]\nServer = https://archzfs.com/\$repo/\$arch" >> /archlive/airootfs/zfs-pacman.conf

# Install zfs
echo "linux-headers" >> /archlive/packages.x86_64
echo "zfs-dkms" >> /archlive/packages.x86_64
echo "zfs-utils" >> /archlive/packages.x86_64

# Customize profiledef.sh
sed -i 's/iso_name=".*"/iso_name="j6s-arch-zfs"/g' /archlive/profiledef.sh

# Build the actual iso
mkarchiso -v -w /tmp/ -o ${OUT_DIR} /archlive/

chown -Rv 1000:1000 ${OUT_DIR}
chmod -Rv 777 ${OUT_DIR}
