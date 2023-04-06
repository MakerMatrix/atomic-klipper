#!/bin/sh
echo -n "Installing extra packages and configuring sudo..."
apt-get install sudo git -y
sed -i s/sudo:x:27:$/sudo:x:27:$USER/ /etc/group
echo "Done."

echo -n "Installing proprietary firmware files for Atomic Pi network interfaces..."
FIRMWARE_URL_BASE="https://github.com/wkennington/linux-firmware/raw/master"
mkdir /lib/firmware/rtl_nic
wget -P /lib/firmware/rtl_nic $FIRMWARE_URL_BASE/rtl_nic/rtl8168g-2.fw
wget -P /lib/firmware $FIRMWARE_URL_BASE/rt2870.bin
echo "Done. Reboot to load the firmware."
