#!/bin/sh
FILE="/etc/dnf/dnf.conf"

echo "max_parallel_downloads=10" >> $FILE
echo "minrate=500k" >> $FILE
dnf upgrade --refresh