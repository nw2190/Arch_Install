#!/bin/bash

homedir='/home/nick/'
bakdir='/home/nick/git/Linux/ARCH_LAPTOP/nick/'

confdir="/home/nick/.config/"
bakconfdir="/home/nick/git/Linux/ARCH_LAPTOP/nick/config/"

## Netctl wifi settings
#sudo cp "/usr/lib/systemd/system/netctl-auto@.service" "/home/nick/git/Linux/ARCH_LAPTOP/netctl/netctl-auto@.service"
#sudo cp "/usr/lib/systemd/system/netctl-ifplugd@.service" "/home/nick/git/Linux/ARCH_LAPTOP/netctl/netctl-ifplugd@.service"
#sudo cp "/etc/ifplugd/ifplugd.conf" "/home/nick/git/Linux/ARCH_LAPTOP/ifplugd/ifplugd.conf"

## Save list of installed packages
pacman -Qqe > "/home/nick/git/Linux/ARCH_LAPTOP/pkglist.txt"

## Lightdm settings
cp "/etc/lightdm/lightdm.conf" "/home/nick/git/Linux/ARCH_LAPTOP/lightdm.conf"
cp "/etc/lightdm/lightdm-gtk-greeter.conf" "/home/nick/git/Linux/ARCH_LAPTOP/lightdm-gtk-greeter.conf"

## Themes
cp -rfu "/usr/share/themes" "/home/nick/git/Linux/ARCH_LAPTOP/"


## Netctl wifi profiles
sudo cp "/etc/netctl/wlp2s0-NW2190" "/home/nick/git/Linux/ARCH_LAPTOP/netctl/wlp2s0-NW2190"
#sudo cp "/etc/netctl/enp1s0-NW2190" "/home/nick/git/Linux/ARCH_LAPTOP/netctl/enp1s0-NW2190"
sudo chown nick "/home/nick/git/Linux/ARCH_LAPTOP/netctl/wlp2s0-NW2190"
#sudo chown nick "/home/nick/git/Linux/ARCH_LAPTOP/netctl/enp1s0-NW2190"



## General configuration files
rsync -rqu --exclude="google-chrome-beta/" --exclude="google-chrome/" "${confdir}" "${bakconfdir}" 
#cp -rfu "${homedir}.config/"* "${bakdir}config"
cp -rfu "${homedir}Documents/Scripts" "${bakdir}Documents/"
cp -rfu "${homedir}Documents/Services" "${bakdir}Documents/"
#cp -rfu "${homedir}Setup"* "${bakdir}"
cp "${homedir}.tmux.conf" "${bakdir}tmux.conf"
cp "${homedir}.bashrc" "${bakdir}bashrc"
cp "${homedir}.bash_aliases" "${bakdir}bash_aliases"
cp "${homedir}.terminator_bashrc" "${bakdir}terminator_bashrc"
cp "${homedir}.terminator_tmux_bashrc" "${bakdir}terminator_tmux_bashrc"
#cp "${homedir}.conkyrc_qtile" "${bakdir}conkyrc_qtile"
#cp "${homedir}.conkyrc_qtile_weather" "${bakdir}conkyrc_qtile_weather"
#cp "${homedir}.conkyrc_qtile_calendar" "${bakdir}conkyrc_qtile_calendar"
##cp -rfu "${homedir}.conky-vision" "${bakdir}conky-vision"
cp "${homedir}.emacs" "${bakdir}emacs"
#cp "${homedir}.muttrc" "${bakdir}muttrc"
#cp "${homedir}.mailcap" "${bakdir}mailcap"
#cp "${homedir}/Setup/PRINTER_SETUP.txt" "${bakdir}PRINTER_SETUP.txt"
#cp "${homedir}/Setup/Mouse_Settings.txt" "${bakdir}Mouse_Settings.txt"
#rm -rf "${bakdir}emacs.d"
#cp -rfu "${homedir}.emacs.d" "${bakdir}emacs.d"
rsync -rqu "${homedir}.emacs.d/" "${bakdir}emacs.d/"
cp "${homedir}.tmux.conf" "${bakdir}tmux.conf"
cp "${homedir}.tmux.conf" "/home/nick/git/Linux/ARCH_LAPTOP/tmux/tmux.conf"
#cp "/etc/systemd/system/tmux@.service" "/home/nick/git/Linux/ARCH_LAPTOP/tmux/tmux@.service"
#cp "${homedir}.lynx.lss" "${bakdir}lynx.lss"
#cp "/etc/lynx.cfg" "${bakdir}lynx.cfg"
#cp "${homedir}.Xmodmap" "${bakdir}Xmodmap"
cp "${homedir}.Xresources" "${bakdir}Xresources"
cp "${homedir}.xinitrc" "${bakdir}xinitrc"

