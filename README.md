# Arch Linux Installation Guide for Dell XPS 13 [2019]
This repository provides a basic overview of the steps required for dual-booting Arch Linux and Windows 10 on Dell XPS 13 (9380) laptops.


## Configuring Windows 10

### Disable Fast Startup
* Open 
* Click

### Disable Secure Boot
* Open 
* Click


### Disable Bitlocker Encryption
* Open 
* Click


### Switch SATA operating mode from `RAID` to `AHCI` (Optional?)
* Open 
* Click

References:
* [https://bbs.archlinux.org/viewtopic.php?id=245335](https://bbs.archlinux.org/viewtopic.php?id=245335)
* [https://support.thinkcritical.com/kb/articles/switch-windows-10-from-raid-ide-to-ahci](https://support.thinkcritical.com/kb/articles/switch-windows-10-from-raid-ide-to-ahci)




## Installing Arch Linux

Follow standard installation procedures using the newly allocated block of memory:
* [DistroTube](https://www.youtube.com/channel/UCVls1GmFKf6WlTraIb_IaJg) [English] - [Installation Video](https://www.youtube.com/watch?v=HpskN_jKyhc) following the [Arch Installation Guide](https://wiki.archlinux.org/index.php/Installation_guide)
* [GTRONICK](https://www.youtube.com/channel/UCUpnwLms-qS0APsWMXylJzA) [Spanish] - [Installation Video](https://www.youtube.com/watch?v=pd1hgF4p8gw&t=1939s) for dual-booting with the installation instructions [here](https://gtronick.github.io/ALIG-DUAL/)


```console
$ 
```

References:
* [https://askubuntu.com/questions/932331/filesystem-shows-dev-nvme0n1p1-instead-of-dev-sda](https://askubuntu.com/questions/932331/filesystem-shows-dev-nvme0n1p1-instead-of-dev-sda)



## Software and Applications
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
* [Redshift](http://jonls.dk/redshift/) - Screen color temperature and brightness scheduler
* [VLC](https://www.videolan.org/vlc/index.html) - All purpose multimedia player
* [MPlayer](http://mplayerhq.hu/design7/news.html) - Lightweight multimedia player
* [Evince](https://wiki.gnome.org/Apps/Evince) - Document viewer
* [Libre Office](https://www.libreoffice.org/) - Document editing suite
    
