#!/bin/bash

## Schedule using:
##   crontab -e
## and add/remove the following line:
##   */m * * * * DISPLAY=:0.0 /home/nick/Documents/Scripts/change_wallpaper.sh
## where 'm' is the number of minutes between changes.

## Specify current season
#SEASON='Winter'
#SEASON='Spring'

#feh --randomize --bg-fill "/home/nick/Documents/Customization/Wallpapers/${SEASON}/" 2>/dev/null
#DISPLAY=:0.0 feh --randomize --bg-fill "/home/nick/Documents/Customization/Wallpapers/Spring/"


#DISPLAY=:0.0 feh --randomize --bg-fill "/home/nick/Documents/Customization/Wallpapers/Spring/" 2>/dev/null
DISPLAY=:0.0 feh --randomize --bg-fill /home/nick/Documents/Customization/4K_Wallpapers/
