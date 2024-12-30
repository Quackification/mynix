#!/bin/sh
#Simple Tablet Mode Script
libinput debug-events --device /dev/input/by-path/platform-PNP0C14:01-event | while read line; do
mode=$(echo "$line" | grep -o 'state [0-1]' | awk '{print $2}')
# maliit="/run/current-system/sw/share/applications/com.github.maliit.keyboard.desktop"
# fcitx="/run/current-system/sw/share/applications/org.fcitx.Fcitx5.desktop"
if [ "$mode" = "1" ]; then
#         sed -i -e '/InputMethod[\$e] =/ s/= .*/= $maliit/' '~/.config/kwinrc'
        systemctl stop keyd.service
else
#         sed -i "s/\(InputMethod[$e] *= *\).*/\1$fcitx/" "~/.config/kwinrc"
        systemctl start keyd.service
fi
done
