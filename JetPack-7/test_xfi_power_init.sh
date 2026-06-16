#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

sleep_time=0.3

function run_gpioset_out {
	# $1 -> GPIO chip
	# $2 -> GPIO index
	# $3 -> output value

	# If there is a gpioset command working in background (for the selected GPIO), kill it
	for pid in `ps -ef | grep "$1 $2" | awk '{print $2}'` ; do
		if [ $(ps $pid | grep "gpioset" | wc -l) -ne 0 ]; then
			kill $pid
		fi
	done

	# Run the gpioset command in background (to keep the GPIO value continuously)
	gpioset --mode=signal $1 $2=$3 &
}

XFI_PWR_OFF=`gpiofind "PY.07"`

run_gpioset_out $XFI_PWR_OFF 0

