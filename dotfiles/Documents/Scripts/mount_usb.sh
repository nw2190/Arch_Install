#!/bin/bash
mkdir /run/media
sleep 1
mkdir /run/media/nick
sleep 1
mkdir /run/media/nick/Elements
sleep 2
#mount -t ntfs /dev/sdh1 /media/nick/Elements
mount -t ntfs UUID=F474B7AA74B76DCC /run/media/nick/Elements

