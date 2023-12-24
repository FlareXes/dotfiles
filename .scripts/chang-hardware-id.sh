#!/bin/bash

# Regenerate machine ID
rm -f /var/lib/dbus/machine-id
dbus-uuidgen > /var/lib/dbus/machine-id
cp -p /var/lib/dbus/machine-id /etc/machine-id

chmod 444 /etc/machine-id

