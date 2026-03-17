#!/usr/bin/env bash
if kdialog --title "Musik?" --yesno "Play musik?" ; then
	mpv --loop --volume=35 --force-window --wayland-app-id=mpv-musik /home/szczurek/github/ratfiles/musik_file &
	sleep 1
	hyprctl dispatch movetoworkspacesilent 10,class:mpv-musik
fi
