#!/bin/sh
FILE="/etc/systemd/journald.conf"
CONFIG_HEADER="[Journal]"

if ! grep -Fxq "$CONFIG_HEADER" $FILE
then
    echo "$CONFIG_HEADER" >> $FILE
fi

echo "SystemMaxUse=50M" >> $FILE
systemctl restart systemd-journald.service