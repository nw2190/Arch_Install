#!/bin/bash
# Initializes Desktop Workspaces

#gnome-terminal --window --full-screen -e "tmux attach -t root"

## Log errors
exec > /tmp/debug-Start_Desktop.txt 2>&1

## Loop until wmctrl has access to window manager
## Avoids: "Cannot get client list properties. (_NET_CLIENT_LIST or _WIN_CLIENT_LIST)"
while true
do
    ## Check if ready
    ready='true'
    wmctrl -l || ready='0'
    
    if [ ${#ready} -gt 3 ]
    then
	## Loop until Terminal has been loaded
	while true
	do
	    out="$(wmctrl -l | grep -c 'Terminal')"
	    if [ ${#out} -gt 0 ]
	    then
		## Move Terminal to workspace 2
		wmctrl -r 'Terminal' -t 1
		exit
	    else
		sleep 1
	    fi
	done
    else
	sleep 5
    fi
done

#sleep 3
#/usr/bin/google-chrome-stable %U
