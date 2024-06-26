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

DIGITAL_OUT0=`gpiofind "PN.02"`
DIGITAL_OUT1=`gpiofind "PM.05"`
DIGITAL_OUT2=`gpiofind "PM.06"`

run_gpioset_out $DIGITAL_OUT0 1
run_gpioset_out $DIGITAL_OUT1 1
run_gpioset_out $DIGITAL_OUT2 1

sleep $sleep_time

echo "DIGITAL_OUT0 OFF"
run_gpioset_out $DIGITAL_OUT0 0
echo "DIGITAL_OUT1 OFF"
run_gpioset_out $DIGITAL_OUT1 0
echo "DIGITAL_OUT2 OFF"
run_gpioset_out $DIGITAL_OUT2 0

sleep $sleep_time

#Single Test
echo "step: 1/14"
echo "DIGITAL_OUT0 ON"
run_gpioset_out $DIGITAL_OUT0 1
sleep $sleep_time

echo "step: 2/14"
echo "DIGITAL_OUT0 OFF"
run_gpioset_out $DIGITAL_OUT0 0
sleep $sleep_time

echo "step: 3/14"
echo "DIGITAL_OUT1 ON"
run_gpioset_out $DIGITAL_OUT1 1
sleep $sleep_time

echo "step: 4/14"
echo "DIGITAL_OUT1 OFF"
run_gpioset_out $DIGITAL_OUT1 0
sleep $sleep_time

echo "step: 5/14"
echo "DIGITAL_OUT2 ON"
run_gpioset_out $DIGITAL_OUT2 1
sleep $sleep_time

echo "step: 6/14"
echo "DIGITAL_OUT2 OFF"
run_gpioset_out $DIGITAL_OUT2 0
sleep $sleep_time

#Double Test
echo "step: 7/14"
echo "DIGITAL_OUT0 ON"
echo "DIGITAL_OUT1 ON"
run_gpioset_out $DIGITAL_OUT0 1
run_gpioset_out $DIGITAL_OUT1 1
sleep $sleep_time

echo "step: 8/14"
echo "DIGITAL_OUT0 OFF"
echo "DIGITAL_OUT1 OFF"
run_gpioset_out $DIGITAL_OUT0 0
run_gpioset_out $DIGITAL_OUT1 0
sleep $sleep_time

echo "step: 9/14"
echo "DIGITAL_OUT1 ON"
echo "DIGITAL_OUT2 ON"
run_gpioset_out $DIGITAL_OUT1 1
run_gpioset_out $DIGITAL_OUT2 1
sleep $sleep_time

echo "step: 10/14"
echo "DIGITAL_OUT1 OFF"
echo "DIGITAL_OUT2 OFF"
run_gpioset_out $DIGITAL_OUT1 0
run_gpioset_out $DIGITAL_OUT2 0
sleep $sleep_time

echo "step: 11/14"
echo "DIGITAL_OUT0 ON"
echo "DIGITAL_OUT2 ON"
run_gpioset_out $DIGITAL_OUT0 1
run_gpioset_out $DIGITAL_OUT2 1
sleep $sleep_time

echo "step: 12/14"
echo "DIGITAL_OUT0 OFF"
echo "DIGITAL_OUT2 OFF"
run_gpioset_out $DIGITAL_OUT0 0
run_gpioset_out $DIGITAL_OUT2 0
sleep $sleep_time

#Triple Test
echo "step: 13/14"
echo "DIGITAL_OUT0 ON"
echo "DIGITAL_OUT1 ON"
echo "DIGITAL_OUT2 ON"
run_gpioset_out $DIGITAL_OUT0 1
run_gpioset_out $DIGITAL_OUT1 1
run_gpioset_out $DIGITAL_OUT2 1
sleep $sleep_time

echo "step: 14/14"
echo "DIGITAL_OUT0 OFF"
echo "DIGITAL_OUT1 OFF"
echo "DIGITAL_OUT2 OFF"
run_gpioset_out $DIGITAL_OUT0 0
run_gpioset_out $DIGITAL_OUT1 0
run_gpioset_out $DIGITAL_OUT2 0
sleep $sleep_time

echo "Completed"

sleep 1
run_gpioset_out $DIGITAL_OUT0 1
run_gpioset_out $DIGITAL_OUT1 1
run_gpioset_out $DIGITAL_OUT2 1
sleep 1


