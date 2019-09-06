#!/bin/bash
while read action data; do
    #echo $action
    if [ "$action" = "LOCK" ]; then
        #echo "Standby command should be here"
        systemctl suspend
    fi
done < <(xscreensaver-command -watch)
