#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sleep_time=0.3

function kill_gpioset_bg {
	# $1 -> GPIO chip
	# $2 -> GPIO index
	if [ $(ps -t | grep gpioset | grep "$1 $2" | wc -l) -eq 1 ]; then
		PID_GPIOSET_BG=$(ps -t | grep gpioset | grep "$1 $2" | awk '{print $1;}')

		kill $PID_GPIOSET_BG

		if [ $(ps -t | grep gpioset | grep "$1 $2" | wc -l) -eq 1 ]; then
			echo "Unable to kill process $PID_GPIOSET_BG"
		fi
	fi
}

function run_gpioset_out {
	# $1 -> GPIO chip
	# $2 -> GPIO index
	# $3 -> output value

	# If there is a gpioset command is working in background (for the selected GPIO), kill it
	kill_gpioset_bg $1 $2

	# Run the gpioset command in background (to keep the GPIO value continuously)
	gpioset --mode=signal $1 $2=$3 &
}

XFI_PWR_OFF=`gpiofind "PY.07"`

run_gpioset_out $XFI_PWR_OFF 0

