#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

#gpiochip0 - tegra234-gpio
#gpiochip1 - tegra234-gpio-aon

gpioset --mode=signal `gpiofind "PZ.07"`=0 &
PID_RS422_232=$!
gpioset --mode=signal `gpiofind "PEE.05"`=0 &
PID_HALF_FULL=$!
gpioset --mode=signal `gpiofind "PM.04"`=1 &
PID_RS485_CTRL_TX=$!
gpioset --mode=signal `gpiofind "PN.01"`=0 &
PID_RS485_CTRL_NON_RX=$!

sudo gtkterm -p /dev/ttyTHS3 -s 115200

kill $PID_RS422_232
kill $PID_HALF_FULL
kill $PID_RS485_CTRL_TX
kill $PID_RS485_CTRL_NON_RX

