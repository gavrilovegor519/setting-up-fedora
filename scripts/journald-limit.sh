#!/bin/bash -eu

if [ "$(id -u)" -ne 0 ]; then
        echo 'This script must be run by root' >&2
        exit 1
fi

FILE="/etc/systemd/journald.conf"
CONFIG_HEADER="[Journal]"

if ! grep -Fxq "$CONFIG_HEADER" $FILE
then
    echo "$CONFIG_HEADER" >> $FILE
fi

echo "SystemMaxUse=50M" >> $FILE
systemctl restart systemd-journald.service
