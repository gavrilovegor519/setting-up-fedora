#!/bin/bash -eu

if [ "$(id -u)" -ne 0 ]; then
        echo 'This script must be run by root' >&2
        exit 1
fi

dnf install -y https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
dnf groupupdate -y core
dnf swap ffmpeg-free ffmpeg --allowerasing -y
dnf groupupdate multimedia -y --setop="install_weak_deps=False" --exclude=PackageKit-gstreamer-plugin
dnf groupupdate sound-and-video -y
# dnf install mozilla-openh264 -y
dnf install gnome-tweaks gnome-extensions-app -y
dnf install curl cabextract xorg-x11-font-utils fontconfig -y
rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm
# dnf install nm-connection-editor-desktop -y
# dnf install fastfetch -y
# dnf install google-chrome-stable -y
# dnf install unrar p7zip p7zip-plugins -y
dnf remove --oldinstallonly -y
