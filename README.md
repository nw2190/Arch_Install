# Arch Linux Installation Guide for Dell XPS 13 [2019]
This repository provides a basic overview of the steps required for dual-booting Arch Linux and Windows 10 on Dell XPS 13 (9380) laptops.


## Configuring Windows 10

### Disable Fast Startup
* Open 
* Click

References:
* [https://help.uaudio.com/hc/en-us/articles/213195423-How-To-Disable-Fast-Startup-in-Windows-10](https://help.uaudio.com/hc/en-us/articles/213195423-How-To-Disable-Fast-Startup-in-Windows-10)

### Disable Secure Boot
* Open 
* Click

References:
* [https://www.appgeeker.com/recovery/disable-uefi-secure-boot-in-windows-10.html](https://www.appgeeker.com/recovery/disable-uefi-secure-boot-in-windows-10.html)

### Disable Bitlocker Encryption
* Open 
* Click

References:
* [https://www.manageengine.com/products/os-deployer/help/how-to-disable-bitlocker-encryption.html](https://www.manageengine.com/products/os-deployer/help/how-to-disable-bitlocker-encryption.html)


### Switch SATA operating mode from `RAID` to `AHCI` (Optional?)
* Open 
* Click

References:
* [https://bbs.archlinux.org/viewtopic.php?id=245335](https://bbs.archlinux.org/viewtopic.php?id=245335)
* [https://support.thinkcritical.com/kb/articles/switch-windows-10-from-raid-ide-to-ahci](https://support.thinkcritical.com/kb/articles/switch-windows-10-from-raid-ide-to-ahci)



### Resize Windows Partition 
* Open 
* Click




## Installing Arch Linux

Follow standard installation procedures using the newly allocated block of memory:
* [DistroTube](https://www.youtube.com/channel/UCVls1GmFKf6WlTraIb_IaJg) [English] - [Installation Video](https://www.youtube.com/watch?v=HpskN_jKyhc) following the [Arch Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide)
* [GTRONICK](https://www.youtube.com/channel/UCUpnwLms-qS0APsWMXylJzA) [Spanish] - [Installation Video](https://www.youtube.com/watch?v=pd1hgF4p8gw&t=1939s) for dual-booting with the installation instructions [here](https://gtronick.github.io/ALIG-DUAL/)



### Partitioning the Disk
Since the Dell XPS 13 laptops do not have standard USB ports, the ouput of commands such as `df -h` will not follow the conventional `/dev/sda*` format.  Instead the laptop's hard drive will likely have entries listed in the form `/dev/nvme0n1p*`, with the final digit specifying a partition number on the drive.

References:
* [https://askubuntu.com/questions/932331/filesystem-shows-dev-nvme0n1p1-instead-of-dev-sda](https://askubuntu.com/questions/932331/filesystem-shows-dev-nvme0n1p1-instead-of-dev-sda)


### Installing a Boot Loader
For the choice of boot loader, I personally followed GTRONICK and used `systemd-boot` which worked well without much effort and correctly identified and included the Windows 10 boot option.  This method can be carried out using the following commands:

```console
$ pacman -S systemd-boot
$ bootctl --path=/boot install
```
The configuration settings should then be specified in the `/boot/loader/loader.conf` file, with something along the lines of:
```
default arch
timeout 3
console-mode max
editor 0
```
GTRONICK also provides an easy way of retrieving the hard drive's UUID which starts by issuing the command:
```
echo $(blkid -s PARTUUID -o value /dev/sda6) > /boot/loader/entries/arch.conf
```
and is completed by editing the `/boot/loader/entries/arch.conf` file to include the loader specifications:
```
title ArchLinux
linux /vmlinuz-linux
initrd /initramfs-linux.img
options root=PARTUUID=<UUID SENT TO FILE IN PREVIOUS STEP> rw
```

Also be sure to install the networking and wireless packages (e.g. `wpa_supplicant`) so that you will have an internet connection after rebooting the machine.



## Configuring Graphical Environment for 4K Display

The graphical environment which I personally installed comprised the following packages:
* [LightDM](https://freedesktop.org/wiki/Software/LightDM/) - Lightweight display manager
* [Xorg](https://www.x.org/wiki/) - Open source implementation of X window system
* [Qtile](http://www.qtile.org/) - Tiling window manager



### Installing Xorg and LightDM

The Xorg window system and LightDM desktop manager can be installed from the Arch repositories via: 
```console
$ sudo pacman -S xorg lightdm lightdm-gtk-greeter 
```

### Installing Qtile

The Qtile window manager can be installed from the Arch repositories via: 
```console
$ sudo pacman -S qtile
```

At the time of this writing, the default configuration file is not placed correctly (or at all) and must be pulled from the project's GitHub repository:
```console
$ sudo pacman -S wget
$ mkdir .config
$ mkdir .config/qtile
$ wget https://raw.githubusercontent.com/qtile/qtile/master/libqtile/resources/default_config.py ./
$ chmod 755 default_config.py
$ mv default_config.py .config/qtile/
```


### Configuring Display
```console
$ sudo pacman -S compton lightdm-gtk-greeter-settings lxappearance 
```

Example `.xinitrc` file:
```
xrandr --dpi 150
xrandr --output eDP1 --scale 1x1 --mode 3840x2160
sleep 2
compton --config /home/nick/.config/compton/compton.conf 
exec qtile
```

Example `.Xresources` file:
```
! Fonts {{{
Xft.antialias:  true
Xft.hinting:    true
Xft.rgba:       rgb
Xft.hintstyle:  hintfull
Xft.dpi:        150
! }}}
```



## Additional Software and Applications
* [Xorg](https://www.x.org/wiki/) - Open source implementation of X window system
* [GTK+](https://www.gtk.org/) - Toolkit for graphical user interfaces
* [LXAppearance](https://wiki.lxde.org/en/LXAppearance) - Lightweight GTK+ style configuration tool
* [LightDM](https://freedesktop.org/wiki/Software/LightDM/) - Lightweight display manager
* [Qtile](http://www.qtile.org/) - Tiling window manager
* [tmux](https://github.com/tmux/tmux) - Terminal multiplexer
* [Emacs](https://www.gnu.org/software/emacs/) - Text editor with
* [Tabbar](https://github.com/dholm/tabbar) - Emacs mode for viewing in tabs
* [Mutt](http://www.mutt.org/) - Command line email client
* [Cmus](https://cmus.github.io/) - Command line music player
* [cli-visualizer](https://github.com/dpayne/cli-visualizer) - Command line visual audio equalizer
* [Powerline](https://github.com/powerline/powerline) - Terminal status bar
* [Conky](https://github.com/brndnmtthws/conky) - System monitor    
* [Ranger](https://github.com/ranger/ranger) - Terminal file manager
* [PCManFM](https://wiki.lxde.org/en/PCManFM) - Lightweight GUI file manager
* [Baobab](http://www.marzocca.net/linux/baobab/) - Graphical disk usage analyzer
* [Xscreensaver](https://www.jwz.org/xscreensaver/) - Screensaver for Xorg
* [Redshift](http://jonls.dk/redshift/) - Screen color temperature/brightness scheduler
* [VLC](https://www.videolan.org/vlc/index.html) - All purpose multimedia player
* [MPlayer](http://mplayerhq.hu/design7/news.html) - Lightweight multimedia player
* [Evince](https://wiki.gnome.org/Apps/Evince) - Document viewer
* [Libre Office](https://www.libreoffice.org/) - Document editing suite
    
