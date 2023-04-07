#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sleep_time=0.3

sudo echo 341 > /sys/class/gpio/export
sudo echo high > /sys/class/gpio/PEE.02/direction
sudo echo 480 > /sys/class/gpio/export
sudo echo high > /sys/class/gpio/PZ.02/direction
sudo echo 423 > /sys/class/gpio/export
sudo echo high > /sys/class/gpio/PL.03/direction

sleep $sleep_time

echo "POWER_LED0 OFF"
sudo echo 0 > /sys/class/gpio/PEE.02/value
echo "POWER_LED1 OFF"
sudo echo 0 > /sys/class/gpio/PZ.02/value
echo "POWER_LED2 OFF"
sudo echo 0 > /sys/class/gpio/PL.03/value

sleep $sleep_time

#Single Test
echo "step: 1/14"
echo "POWER_LED0 ON"
sudo echo 1 > /sys/class/gpio/PEE.02/value
sleep $sleep_time

echo "step: 2/14"
echo "POWER_LED0 OFF"
sudo echo 0 > /sys/class/gpio/PEE.02/value
sleep $sleep_time

echo "step: 3/14"
echo "POWER_LED1 ON"
sudo echo 1 > /sys/class/gpio/PZ.02/value
sleep $sleep_time

echo "step: 4/14"
echo "POWER_LED1 OFF"
sudo echo 0 > /sys/class/gpio/PZ.02/value
sleep $sleep_time

echo "step: 5/14"
echo "POWER_LED1 ON"
sudo echo 1 > /sys/class/gpio/PL.03/value
sleep $sleep_time

echo "step: 6/14"
echo "POWER_LED1 OFF"
sudo echo 0 > /sys/class/gpio/PL.03/value
sleep $sleep_time

#Double Test
echo "step: 7/14"
echo "POWER_LED0 ON"
echo "POWER_LED1 ON"
sudo echo 1 > /sys/class/gpio/PEE.02/value
sudo echo 1 > /sys/class/gpio/PZ.02/value
sleep $sleep_time

echo "step: 8/14"
echo "POWER_LED0 OFF"
echo "POWER_LED1 OFF"
sudo echo 0 > /sys/class/gpio/PEE.02/value
sudo echo 0 > /sys/class/gpio/PZ.02/value
sleep $sleep_time

echo "step: 9/14"
echo "POWER_LED0 ON"
echo "POWER_LED1 ON"
sudo echo 1 > /sys/class/gpio/PZ.02/value
sudo echo 1 > /sys/class/gpio/PL.03/value
sleep $sleep_time

echo "step: 10/14"
echo "POWER_LED0 OFF"
echo "POWER_LED1 OFF"
sudo echo 0 > /sys/class/gpio/PZ.02/value
sudo echo 0 > /sys/class/gpio/PL.03/value
sleep $sleep_time

echo "step: 11/14"
echo "POWER_LED0 ON"
echo "POWER_LED1 ON"
sudo echo 1 > /sys/class/gpio/PEE.02/value
sudo echo 1 > /sys/class/gpio/PL.03/value
sleep $sleep_time

echo "step: 12/14"
echo "POWER_LED0 OFF"
echo "POWER_LED1 OFF"
sudo echo 0 > /sys/class/gpio/PEE.02/value
sudo echo 0 > /sys/class/gpio/PL.03/value
sleep $sleep_time

#Triple Test
echo "step: 13/14"
echo "POWER_LED0 ON"
echo "POWER_LED1 ON"
echo "POWER_LED2 ON"
sudo echo 1 > /sys/class/gpio/PEE.02/value
sudo echo 1 > /sys/class/gpio/PZ.02/value
sudo echo 1 > /sys/class/gpio/PL.03/value
sleep $sleep_time

echo "step: 14/14"
echo "POWER_LED0 OFF"
echo "POWER_LED1 OFF"
echo "POWER_LED2 OFF"
sudo echo 0 > /sys/class/gpio/PEE.02/value
sudo echo 0 > /sys/class/gpio/PZ.02/value
sudo echo 0 > /sys/class/gpio/PL.03/value
sleep $sleep_time

echo "Completed"

sleep 1
sudo echo 1 > /sys/class/gpio/PEE.02/value
sudo echo 1 > /sys/class/gpio/PZ.02/value
sudo echo 1 > /sys/class/gpio/PL.03/value
sleep 1

sudo echo 341 > /sys/class/gpio/unexport
sudo echo 480 > /sys/class/gpio/unexport
sudo echo 423 > /sys/class/gpio/unexport

