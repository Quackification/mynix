#!/usr/bin/env bash
swww-daemon &
swww img ./ScarletTree.png &
nm-applet --indicator &
dunst
