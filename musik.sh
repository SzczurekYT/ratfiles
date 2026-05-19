#!/usr/bin/env bash

MUSIK_FILE="./musik_file"

cd "$(dirname "$(readlink -f "${BASH_SOURCE[0]}")")"

if [ ! -f "$MUSIK_FILE" ]; then
	exit
fi

if kdialog --title "Musik?" --yesno "Play musik?" ; then
	mpv --loop --volume=35 --force-window --wayland-app-id=mpv-musik "$MUSIK_FILE" &
	sleep 1
	hyprctl dispatch movetoworkspacesilent 10,class:mpv-musik
fi
