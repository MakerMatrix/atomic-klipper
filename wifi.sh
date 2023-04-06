#!/bin/bash

# Check for arguments and print usage if failure
if [ $# -ne 2 ]; then
	echo "Usage: $0 <SSID> <WIFI_KEY>"
	exit 1
fi

SSID=$1
PASS=$2

echo -e "Installing dependencies..."

# Assumes this is a bare-bones install: Install prerequisites
apt-get install net-tools iw wpasupplicant -y

# Get the interface 
WLAN0=`/usr/sbin/iw dev | grep Interface | awk '{print $2}'`
WPA_PSK=`/usr/bin/wpa_passphrase $SSID $PASS | grep psk= | grep -v \# | awk -F '=' '{print $2}'`

echo -e "\nThis script appends lines to /etc/network/interfaces.  Don't run it more than once without cleaning up first...."

echo -e "\n#Wifi config" >> /etc/network/interfaces
echo allow-hotplug $WLAN0 >> /etc/network/interfaces
echo iface $WLAN0 inet dhcp >> /etc/network/interfaces
echo " 	wpa-ssid $SSID" >> /etc/network/interfaces
echo "	wpa-psk $WPA_PSK" >> /etc/network/interfaces

echo -e "Attempting to bring the interface up.  This may take awhile..."
ifup $WLAN0

