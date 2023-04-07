#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi


sudo echo 485 > /sys/class/gpio/export 
sudo echo 344 > /sys/class/gpio/export 
sudo echo low > /sys/class/gpio/PZ.07/direction 
sudo echo low > /sys/class/gpio/PEE.05/direction 

sudo gtkterm -p /dev/ttyTHS4 -s 115200

sudo echo 485 > /sys/class/gpio/unexport
sudo echo 344 > /sys/class/gpio/unexport 

