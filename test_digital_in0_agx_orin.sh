#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sudo echo 325 > /sys/class/gpio/export
sudo echo in > /sys/class/gpio/PBB.01/direction

watch -n 0.1 sudo cat /sys/class/gpio/PBB.01/value

sudo echo 325 > /sys/class/gpio/unexport
