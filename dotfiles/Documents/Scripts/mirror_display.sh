#!/bin/bash
# xrandr --query
#xrandr --output eDP-1 --mode 1920x1080 --output HDMI-1 --mode 1920x1080 --same-as eDP-1


HDMI="$(xrandr --query| grep 'HDMI-1 connected')"
VGA="$(xrandr --query| grep 'VGA-1 connected')"
DP="$(xrandr --query| grep 'DP-1 connected')"

if [[ -n "${HDMI}" ]]
then
    # Mirror screen to HDMI
    xrandr --output eDP1 --mode 3840x2160 --output HDMI-1 --mode 1920x1080 --scale 2x2 --same-as eDP1
    # Switch pulseaudio profile (c.f. pacmd list-cards)
    pacmd set-card-profile 0 output:hdmi-stereo
    echo "HDMI display is connected."
fi

if [[ -n "${VGA}" ]]
then
    # Mirror screen to VGA
    xrandr --output eDP1 --mode 3840x2160 --output VGA-1 --mode 1920x1080 --scale 2x2 --same-as eDP1
    echo "VGA display is connected."
fi

if [[ -n "${DP}" ]]
then
    # Mirror screen to VGA
    xrandr --output eDP1 --mode 3840x2160 --output DP-1 --mode 1920x1080 --scale 2x2 --same-as eDP1
    echo "VGA display is connected. [DP-1]"
fi


if [[ -z "${HDMI}" && -z "${VGA}" && -z "${DP}" ]]
then
    echo "No external displays found."
fi
