# Linux Configuration Details
This repository stores the main configuration files for Arch Linux and associated applications.


## Main Applications
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


## Installing Yaourt

```console
$ sudo pacman -S --needed base-devel git wget yajl
$ git clone https://aur.archlinux.org/package-query.git
$ cd package-query/
$ makepkg -si
$ cd ..
$ git clone https://aur.archlinux.org/yaourt.git
$ cd yaourt/
$ makepkg -si
```

Reference: [https://www.ostechnix.com/install-yaourt-arch-linux/](https://www.ostechnix.com/install-yaourt-arch-linux/)


### Google Chrome Beta
```console
$ yaourt -S google-chrome-beta
```


Recommended Extensions:
* [Vimium](https://chrome.google.com/webstore/detail/vimium/dbepggeogbaibhgnhhndojpepiihcmeb?hl=en) - Customized key bindings for Chrome with an easy [configuration](https://github.com/philc/vimium/blob/master/README.md).    
* [Stylus](https://chrome.google.com/webstore/detail/stylus/clngdbkpkpeebahjckkjfobafhncgmne?hl=en) - Custom CSS styles for viewing sites in Chrome.

## Qtile Commands
The following commands are defined in the provided `.config/qtile/config.py` file.

|  Command  |  Action  |
|:---------:|----------|
| `Super` + `Enter` | Terminal |    
| `Ctrl` + `Shift` + `t` | Terminal with new tmux session |
| `Super` + `r` |  Spawn terminal command launcher |
| `Super` + `Tab` | Switch window layout |    
| `Alt` + `Tab` | Switch windows |
| `Super` + `w` | Kill/close current window |
| `Ctrl` + `Left`/`Right` | Switch to workspace on the left/right |     
| `Ctrl` + `Shift` + `Left`/`Right` | Move window to workspace on the left/right |
| `Ctrl` + `Shift` + `Up`/`Down` | Increase/decrease current window size |
| `Ctrl` + `Shift` + `m` | Maximize/full-screen |
| `Super` + left click | Move floating window |
| `Super` + right click | Resize floating window |        
| `Super` + `c` | Cmus |
| `Super` + `v` | cli-visualizer |                
| `Ctrl` + `Shift` + `w` | Web Browser |
| `Ctrl` + `Shift` + `f` | PCManFM |
| `Ctrl` + `Shift` + `r` | Ranger |    
| `Ctrl` + `Shift` + `s` | Spotify |    
| `Super` + `a` | Pulse audio volume control |
| `Super` + `s` | Toggle X Screensaver |         
| `Super` + `Ctrl` + `r` | Restart Qtile |
| `Super` + `Ctrl` + `q` | Quit Qtile |    
        
## tmux Commands
The following commands are defined in the provided `.tmux.conf` file.

|  Command  |  Action  |
|:---------:|----------|
| `tmux` | Start new tmux session|        
| `tmux ls`  | List current tmux sessions  |
| `tmux attach -t ID`  | Attach to tmux session "ID"  |
| `Esc` | Cancel tmux command |    
| `Ctrl` + `Q` + `?` | List tmux key bindings |
| `Ctrl` + `Q` + `c` | Create new window |
| `Ctrl` + `Q` + `w` | List  windows in current session |
| `Ctrl` + `Q` + `n` | Move to next window |    
| `Ctrl` + `Q` + `p` | Move to previous window |
| `Ctrl` + `Q` + `[` | Enter selection mode|
| `Ctrl` + `Space` | Begin marking selection |
| `Ctrl` + direction  | Highlight selection using emacs controls |
| `Alt` + `w`  | Copy selection |
| `Ctrl` + `Q` + `]`  | Paste selection |        
| `Ctrl` + `Q` + `:` | Prompt for text commands |    
| `Ctrl` + `Q` + `,` | Rename current window |    
| `Ctrl` + `Q` + `"` | Split window into vertical panes |
| `Ctrl` + `Q` + `%` | Split window into  horizontal panes | 
| `Ctrl` + `Q` + `o` | Switch pane |  
| `Ctrl` + `Q` + `Ctrl` + `o` | Cycle pane positions |  
| `Ctrl` + `Q` + `x` | Kill current pane |  
| `Ctrl` + `Q` + `d` | Detach from tmux session |    
    


## Emacs Commands
The following commands are defined in the provided `.emacs` file.    

|  Command  |  Action  |
|:---------:|----------|
| `emacs -nw` | Start emacs in terminal |
| `emacs -nw FILE` |  Open "FILE" in emacs |
| `Ctrl` + `g` | Cancel emacs command | 
| `Ctrl` + `X` + `f` | Find file to open |
| `Ctrl` + `X` + `s` | Save file |
| `Ctrl` + `X` + `c` | Close/quit |
| `Ctrl` + `/` |  Undo |
| `Alt` + `x` | Prompt for text commands |
| `Ctrl` + `s` | Search for text string (forward) |
| `Ctrl` + `r` | Search for text string (reverse) |
| `Alt` + `%` | Find and replace string |
| `Ctrl` + `b` | Move cursor back/left |
| `Ctrl` + `f` | Move cursor forward/right |
| `Ctrl` + `n` | Move cursor down/next line |
| `Ctrl` + `p` | Move cursor up/previous line |
| `Ctrl` + `a` | Move cursor to start of line |
| `Ctrl` + `e` | Move cursor to end of line |
| `Ctrl` + `d` | Delete character under cursor |
| `Ctrl` + `v` | Page down |
| `Alt` + `v` | Page up |
| `Alt` + `<` | Jump to start of file |
| `Alt` + `>` | Jump to end of file |
| `Ctrl` + `l` | Vertically align cursor on screen| 
| `Ctrl` + `Space` | Begin marking region |
| `Ctrl` + `w` | Cut selection |
| `Alt` + `w` | Copy selection | 
| `Ctrl` + `y` | Paste selection |
| `Ctrl` + `Shift` + `c` | Copy mouse selection |
| `Ctrl` + `Shift` + `v` | Paste mouse selection |
| `Ctrl` + `X` + `2` | Create new frame |
| `Ctrl` + `X` + `o` | Move to next frame |
| `Ctrl` + `X` + `0` | Kill/close current frame |
| `Ctrl` + `X` + `n`  | Move to next tab | 
| `Ctrl` + `X` + `p`  | Move to previous tab | 
| `Ctrl` + `X` + `k`  | Kill/close current tab | 
| `Ctrl` + `c` + `f` | Compile document with pdflatex |


### Word count
The line, word, and character count of a region can be displayed using `Alt` + `=` after selecting the region of interest.

### Modifying the beginning/ending of a collection of lines
To append a character or string to the beginning of each line in a selction, one can use the `replace-regexp` command.  For example, the following will add a `#` character to the start of each line:


`Alt` + `x` + `replace-regexp` + `ENTER` + `^` + `ENTER` + `#` + `ENTER`

Similarly, the following `$` character can be used to append to end of each line:

`Alt` + `x` + `replace-regexp` + `ENTER` + `$` + `ENTER` + `#` + `ENTER`


### Copying/Pasting rectangular regions of text


After marking/selecting a region's initial and terminal (x,y) positions, rectangular regions can be copied and pasted via:


Copy  ~ `Ctrl` - `x` + `r` + `Alt` - `w`


Paste ~ `Ctrl` - `x` + `r` + `y`


The 'rectangle mark mode' can also be toggled on/off via `Ctrl` + `x` + `SPACE`; when the mode is enabled, cutting and pasting text can be achieved using the standard `Ctrl` + `w` and `Ctrl` + `y` commands.


## Cmus Commands
The following commands are defaults for Cmus.



|  Command  |  Action  |
|:---------:|----------|
| `cmus` | Start Cmus |
| `q`  | Quit Cmus |
| `c` | Start/Pause song | 
| `v` | Stop song | 
| `+` | Increase volume by 10% |
| `-` | Decrease volume by 10% |
| `j` | Down | 
| `k` | Up | 
| `/`  | Search for string |
| `n` | Jump to next search result |
| `Space` | Expand artist album list |
| `Tab` | Toggle between artist and track selection |
| `h` | Rewind 5 seconds | 
| `l` | Fast-forward 5 seconds |
| `Ctrl` + `<` | Rewind 1 minute | 
| `Ctrl` + `>` | Fast-forward 1 minute |
| `Shift` + `C` | Toggle continue mode |
| `r` | Toggle repeat mode |
| `s` | Toggle shuffle mode |
| `:`  |  Prompt for text commands |
| `:add DIR` | Add music from directory "DIR" to library |
| `y` | Add selected song to playlist (library view) |
| `e` | Add selected song to queue (library view) |
| `Shift` + `D` | Remove selected song (playlist/queue view) |
| `p` | Move track down (playlist/queue view)|
| `Shift` + `P` | Move track up (playlist/queue view)|
| `1` | Library view | 
| `2` | Sorted library view | 
| `3` | Playlist view | 
| `4` | Play queue view | 
| `5` | File browser view | 
| `6` | Filters view |
| `7` | Settings view | 


## Mutt Commands
The following commands are defaults for Mutt.

|  Command  |  Action  |
|:---------:|----------|
| `mutt` | Start Mutt |
| `q`  | Quit Mutt | 
| `Ctrl` + `g`  | Cancel command | 
| `?`  | Help |
| `j` | Navigate down |
| `k` | Navigate up |
| `=` | Jump to first message|
| `*` | Jump tp last message|
| `\`  | Search |
| `n` | Next search result|
| `l` | Filter inbox by search results |
| `l` + `all` | Remove filter / show all |
| `m`	| Compose a new message|
| `r`	| Reply to sender|
| `g`	| Reply to all recipients|
| `L`	| Reply to mailing list|
| `f`	| Forward message|
| `Return` | Open message |
| `h` | Toggle header |
| `i` | Return to inbox |
| `c`   |   Change mailbox|
| `d`   |   Delete current message|
| `F`   |   Mark as important|
| `N`   |   Mark message as new|
| `s`   |   Save message|
| `u`   |   Undelete message|
| `v`   |   View attachments|
| `Tab` |   Jump to the next new message|
| `$`   |   Save changes to mailbox|

### Advanced Search
Search results can be filtered using the following prefixes:

| Command | Search Result |
|:-------:|---------------|  
|`~s SUBJECT` |     messages with `SUBJECT` in the subject|
|`~b STR`     |     messages with `STR` in body|
|`~B STR`     |     messages with `STR` anywhere|
|`~f USER`    |     messages originating from `USER`|
|`~t USER`    |     messages addressed to `USER`|
|`~c USER`    |     messages carbon-copied to `USER` |
|`~d MIN-MAX` |     messages in a specified date range|
|`~Q`         |     messages which have been replied to.|
|`flagged`    |     flagged messages|
|`new`        |     new messages|
|`unread`     |     unread messages|
|`!`          |     logical NOT operator|
|`\|`         |     logical OR operator|
|`()`         |     logical grouping operator|



String patterns can also be matched using regular expressions (regexp) in the "POSIX extended" syntax.  A complete overview of regular expressions in Mutt is available in the [manual](http://www.mutt.org/doc/manual/#regexp).  In particular, the following repetition operators are available:


| Operator  | Description |
|:-------:|---------------|  
|`?` 	 |   The preceding item is optional and matched at most once|
|`*`	 |   The preceding item will be matched zero or more times|
|`+`	 |   The preceding item will be matched one or more times|
|`{n}`	 |   The preceding item is matched exactly n times|
|`{n,}`	 |   The preceding item is matched n or more times|
|`{,m}`	 |   The preceding item is matched at most m times|
|`{n,m}` |   The preceding item is matched at least n times, but no more than m times|


The following character classes are also available:

| Class  | Description |
|:-------:|---------------|  
|`[:alnum:]`	|Alphanumeric characters|
|`[:alpha:]`	|Alphabetic characters|
|`[:blank:]`	|Space or tab characters|
|`[:cntrl:]`	|Control characters|
|`[:digit:]`	|Numeric characters|
|`[:graph:]`	|Characters that are both printable and visible |
|`[:lower:]`	|Lower-case alphabetic characters|
|`[:print:]`	|Printable characters (non-control characters)|
|`[:punct:]`	|Punctuation characters |
|`[:space:]`	|Space characters |
|`[:upper:]`	|Upper-case alphabetic characters|
|`[:xdigit:]`	|Characters that are hexadecimal digits|



### Flags
The following table provides a description of the flags used to mark messages in Mutt:



| Flag  | Description |
|:-------:|---------------|  
|`D`  |  deleted (marked for deletion)|
|`d`  |  has attachments marked for deletion|
|`K`  |  contains a PGP public key|
|`N`  |  new|
|`O`  |  old|
|`P`  |  PGP encrypted|
|`r`  |  replied to|
|`S`  |  PGP signed and verified|
|`s`  |  PGP signed|
|`!`  |  flagged|
|`*`  |  tagged|
|`+`  |  to you only|
|`T`  |  to you and others|
|`C`  |  cc'ed to you|
|`F`  |  from you|
|`L`  |  sent to a subscribed mailing list|
