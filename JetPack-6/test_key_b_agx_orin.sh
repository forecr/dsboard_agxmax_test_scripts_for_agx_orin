#!/bin/bash
if [ "$(whoami)" != "root" ] ; then
	echo "Please run as root"
	exit 1
fi

#gpiochip0 - tegra234-gpio
#gpiochip1 - tegra234-gpio-aon

# rev-1.2 or newer
gpioset --mode=signal `gpiofind "PY.04"`=0 &
# rev-1.1 or older
#gpioset --mode=signal `gpiofind "PX.06"`=0 &
PID_M2B_USB_SELECT=$!

#gpioset --mode=signal `gpiofind "PP.06"`=0 &
#PID_M2B_RESET=$!
gpioset --mode=signal `gpiofind "PA.01"`=1 &
PID_M2B_PWR_ON=$!
#gpioset --mode=signal `gpiofind "PA.02"`=1 &
#PID_M2B_FULLCARD_PWRON=$!
#gpioset --mode=signal `gpiofind "PQ.04"`=1 &
#PID_M2B_ENABLE1=$!
#gpioset --mode=signal `gpiofind "PP.04"`=1 &
#PID_M2B_ENABLE2=$!

trap interrupt_func INT
interrupt_func() {
	kill $PID_M2B_USB_SELECT
	sleep 0.1
	# rev-1.2 or newer
	gpioset --mode=signal `gpiofind "PY.04"`=1 &
	# rev-1.1 or older
	#gpioset --mode=signal `gpiofind "PX.06"`=1 &
	PID_M2B_USB_SELECT=$!
	sleep 1

	kill $PID_M2B_USB_SELECT
	#kill $PID_M2B_RESET
	kill $PID_M2B_PWR_ON
	#kill $PID_M2B_FULLCARD_PWRON
	#kill $PID_M2B_ENABLE1
	#kill $PID_M2B_ENABLE2
}

watch -n 0.1 lsusb

