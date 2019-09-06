#!/bin/bash

## Arch Wiki:
# By using the -aAX set of options, the files are transferred in archive mode which ensures
# that symbolic links, devices, permissions, ownerships, modification times, ACLs, and
# extended attributes are preserved, assuming that the target file system supports the feature.
#rsync -aAXv --exclude={"/dev/*","/proc/*","/sys/*","/tmp/*","/run/*","/mnt/*","/media/*","/lost+found"} /

## Exclude File:
#/dev/*
#/proc/*
#/sys/*
#/tmp/*
#/run/*
#/mnt/*
#/media/*
#/lost+found/*
#/home/nick/.PlayOnLinux
#/home/nick/Documents/School/Homework/IGERT/Block_1/Video_Clips
#/home/nick/.cache
#/home/nick/.instant
#/home/nick/Downloads
#/home/nick/Documents/Music_Videos

## Standard
#sudo rsync -raAXvu --delete --exclude-from /home/nick/.exclude / /media/nick/Elements/Linux_Backups/MINT/

## Ignore time-stamp differences of 30 minutes
#sudo rsync -raAXvu --delete --exclude-from /home/nick/.exclude --modify-window=1800 / /media/nick/Elements/Linux_Backups/MINT/

## Ignore time-stamp differences of 1 hour
#sudo rsync -raAXvu --delete --exclude-from /home/nick/.exclude --modify-window=3600 / /media/nick/Elements/Linux_Backups/MINT/


## Ignore time-stamp differences of 1 hour and sync timestamps
sudo rsync -rtaAXvu --delete --exclude-from /home/nick/.exclude --modify-window=3600 / /run/media/nick/Elements/Linux_Backups/ARCH_DESKTOP/
#sudo rsync -rtaAXvu --delete --exclude-from /home/nick/.exclude --modify-window=3600 / /media/usb/Linux_Backups/ARCH/
