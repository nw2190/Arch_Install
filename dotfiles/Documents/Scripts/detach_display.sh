#!/bin/bash
# xrandr --query
#xrandr --output eDP-1 --mode 1920x1080 --output HDMI-1 --mode 1920x1080 --same-as eDP-1

#xrandr --output eDP-1 --mode 1920x1080

# Restore default monitor settings
xrandr --auto && xrandr --output HDMI-1 --off && xrandr --output VGA-1 --off && xrandr --output DP-1 --off
# Restore default pulseaudio profile
pacmd set-card-profile 0 output:analog-stereo
echo "Detached from external displays."
