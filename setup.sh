#!/bin/bash

# adds the line in a file
# $1 = line, $2 = file
function lineinfile {
	present=$(cat $2 | grep $1 | wc -l)
	
	if [ $present -eq 0 ]; then
		echo $1 >> $2
	fi
}

# adds the line in a file with root privileges
# $1 = line, $2 = file
function sudolineinfile {
	present=$(sudo cat $2 | grep $1 | wc -l)
	if [ $present -eq 0 ]; then
		sudo echo $1 >> $2
	fi
}

echo "Installing dependencies"
sudo apt-get install --no-install-recommends xserver-xorg-video-all xserver-xorg-input-all xserver-xorg-core xinit x11-xserver-utils chromium-browser unclutter

echo "Screen rotation setup"
sudolineinfile "display_rotate=1" "/boot/config.txt"
# sudolineinfile "display_rotate=1" "test.txt"

echo "Making config directory and copying over the touchscreen config"
[ ! -d "/etc/X11/xorg.conf.d" ] && sudo mkdir /etc/X11/xorg.conf.d
sudo cp 40-libinput.conf /etc/X11/xorg.conf.d/


