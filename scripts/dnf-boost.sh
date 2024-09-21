#!/bin/bash -eu

if [ "$(id -u)" -ne 0 ]; then
        echo 'This script must be run by root' >&2
        exit 1
fi

FILE="/etc/dnf/dnf.conf"

echo "max_parallel_downloads=10" >> $FILE
echo "minrate=500k" >> $FILE
