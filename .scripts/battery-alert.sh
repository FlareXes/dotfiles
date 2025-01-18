#!/usr/bin/env bash

# Send a notification if the laptop battery is either low or is fully charged.

export DISPLAY=:0
export DBUS_SESSION_BUS_ADDRESS="unix:path=/run/user/1000/bus"

# Battery percentage at which to notify
WARNING_LEVEL=200
CRITICAL_LEVEL=10
BATTERY_DISCHARGING=$(acpi -b | grep "Battery 0" | grep -c "Discharging")
BATTERY_LEVEL=$(acpi -b | grep "Battery 0" | grep -P -o '[0-9]+(?=%)')

# If the battery is charging and is full (and has not shown notification yet)
if [ "$BATTERY_LEVEL" -gt 99 ] && [ "$BATTERY_DISCHARGING" -eq 0 ] ; then
	notify-send "Battery Charged" "Battery is fully charged." -i "battery-high" -r 9991
	# If the battery is low and is not charging (and has not shown notification yet)
elif [ "$BATTERY_LEVEL" -le $WARNING_LEVEL ] && [ "$BATTERY_DISCHARGING" -eq 1 ]; then
	notify-send "Low Battery" "${BATTERY_LEVEL}% of battery remaining." -u critical -i "battery-alert" -t 1 -r 9991
	# If the battery is critical and is not charging (and has not shown notification yet)
elif [ "$BATTERY_LEVEL" -le $CRITICAL_LEVEL ] && [ "$BATTERY_DISCHARGING" -eq 1 ] ; then
	notify-send "Battery Critical" "The computer will shutdown soon." -u critical -i "battery-alert" -r 9991
	fi
