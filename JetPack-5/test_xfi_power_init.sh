#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sleep_time=0.3

sudo echo 477 > /sys/class/gpio/export
sudo echo low > /sys/class/gpio/PY.07/direction

#sudo echo 477 > /sys/class/gpio/unexport

