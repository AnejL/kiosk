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
sudo apt-get install xserver-xorg-video-all xserver-xorg-input-all xserver-xorg-core xinit x11-xserver-utils chromium-browser unclutter

echo "Screen rotation setup"
sudolineinfile "display_rotate=1" "/boot/config.txt"

echo "Making config directory and copying over the touchscreen config"
[ ! -d "/etc/X11/xorg.conf.d" ] && sudo mkdir /etc/X11/xorg.conf.d
sudo cp configs/40-libinput.conf /etc/X11/xorg.conf.d/

echo "Creating scripts folder"
SCRIPTDIR="$HOME/.local/scripts"
[ ! -d "$SCRIPTDIR" ] && mkdir $SCRIPTDIR

echo "Adding scripts folder to path"
lineinfile 'export PATH="$PATH:$SCRIPTDIR"' $HOME/.bashrc

echo "Copying the scripts in the created folder"
cp scripts/* $SCRIPTDIR/
