#!/bin/bash

## Enable screen locking
# dconf write /org/gnome/desktop/screensaver/lock-enabled true

## Trigger suspend from xscreensaver "LOCK" action
# /home/nick/.config/qtile/screensaver_suspend.sh

## Xscreensaver settings
# blank after:  2 min
# cycle after: 10 min
# lock after:   5 min

## Additional power settings:
# xset dpms 240 900 7200
# xset s 0 0


#output="$(ps -A|grep xscreensaver)"


## See if xscreensaver-command is running in background
output1="$(ps -A -o comm=|grep xscreensaver-co|wc -l)"

## Get number of commands with name including 'xscreensaver'
output2="$(ps -A -o comm=|grep xscreensaver|wc -l)"


## Specify the base count for checking screensaver status
if [[ "${output1}" -gt 0 ]]
then
    base=1
else
    base=0
fi


if [[ "${output2}" -gt "${base}" ]]
then
    #echo "xscreensaver is running"
    xscreensaver-command -exit 2>/dev/null &
else
    #echo "xscreensaver is not running"
    xscreensaver -nosplash 2>/dev/null &
fi

#if [[ -z "${output}" ]]
#then
#    #echo "xscreensaver is not running"
#    xscreensaver -nosplash 2>/dev/null&
#else
#    #echo "xscreensaver is running"
#    xscreensaver-command -exit 2>/dev/null &
#fi
