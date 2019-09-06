# Copyright (c) 2010 Aldo Cortesi
# Copyright (c) 2010, 2014 dequis
# Copyright (c) 2012 Randall Ma
# Copyright (c) 2012-2014 Tycho Andersen
# Copyright (c) 2012 Craig Barnes
# Copyright (c) 2013 horsik
# Copyright (c) 2013 Tao Sauvage
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in
# all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

import os
import subprocess

from libqtile.config import Key, Screen, Group, Drag, Click
from libqtile.command import lazy, Client
from libqtile import layout, bar, widget, hook

## Specify default layout theme
def init_layout_theme():
    return {"border_width": 1,
            "margin": 0,
            #"border_focus": "0000BB",
            "border_focus": "000000",
            "border_normal": "000000"
    }

## Specify alternate layout theme
def init_altlayout_theme():
    return {"border_width": 1,
            "margin": 0,
#            "border_focus": "00BB",
            "border_focus": "000000",
            "border_normal": "000000"
    }

## Specify default xmonad layout theme
def xinit_layout_theme():
    return {"border_width": 3,
            "margin": -7,
            #"border_focus": "0000BB",
            "border_focus": "000000",
            "border_normal": "000000"
    }

## Specify battery configuration
def init_bat_config():
    return {"battery_name": "BAT1",
            "energy_full_file": "/sys/class/power_supply/BAT1/energy_full",
            "energy_now_file": "/sys/class/power_supply/BAT1/energy_now",
            "power_now_file": "/sys/class/power_supply/BAT1/power_now",
            "discharge_char":	" ",
            #"format": '{char} {percent:2.0%} {hour:d}:{min:02d}'
            "format": 'Battery:  {percent:2.0%}  ',
            #"format": ' {percent:2.0%}  ',
            "low_foreground":	'FF3333',   #  Font color on low battery
            "low_percentage":	0.2         #  Define 'low battery'
    }


## Initialize global settings
if __name__ in ["config", "__main__"]:
    mod = "mod4"
    myTerm = "terminator --layout=tmux-layout"
    #myTerm = "gnome-terminal --window-with-profile=qtile"
    #myTerm = "terminator --profile=Nick-tmux --layout=tmux-layout"
    #myTerm = "terminator --profile='Nick-tmux'"
    myAltTerm = "terminator"
    #myChrome = "/usr/bin/google-chrome-beta --force-device-scale-factor=1.2 --profile-directory='Default'"
    myChrome = "/usr/bin/google-chrome-beta --force-device-scale-factor=2.0 --profile-directory='Default' --disable-features=SendMouseLeaveEvents"
    #myAltChrome = "/usr/bin/google-chrome-beta --force-device-scale-factor=1.2 --profile-directory='Profile 1'"
    myAltChrome = "/usr/bin/google-chrome-beta --force-device-scale-factor=2.0 --profile-directory='Profile 1' --disable-features=SendMouseLeaveEvents"
    layout_theme = init_layout_theme()
    xlayout_theme = xinit_layout_theme()
    altlayout_theme = init_altlayout_theme()
    bat_config = init_bat_config()

## Run autostart files 
@hook.subscribe.startup_once
def autostart():
    home = os.path.expanduser('~/.config/qtile/autostart.sh')
    subprocess.call([home])
    #lazy.spawn(myTerm)
    #lazy.spawn(myChrome)

"""
## Initialize layout
@hook.subscribe.startup
def autolayout():
    c = Client()
    c.to_screen(1)
    c.spawn(myTerm)
    c.to_screen(2)
    c.spawn(myChrome)
    c.to_screen(1)
    #lazy.spawn("gnome-terminal")
    #lazy.spawn(myChrome)
    #lazy.group["1"].toscreen()
    #lazy.spawn(myTerm)
    #lazy.group["2"].toscreen()
    #lazy.spawn(myChrome)
    #lazy.group["1"].toscreen()
"""

"""    
@lazy.function
def window_to_prev_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        qtile.currentWindow.togroup(qtile.groups[i - 1].name)
        #qtile.currentWindow.togroup(qtile.groups[i - 1  % len(qtile.screens)].name)
        #qtile.currentScreen.togroup(qtile.groups[i - 1].name)

@lazy.function
def window_to_next_group(qtile):
    if qtile.currentWindow is not None:
        i = qtile.groups.index(qtile.currentGroup)
        group_count = len(qtile.groups)
        if int(i) == int(group_count) - 1:
            qtile.currentWindow.togroup(qtile.groups[0].name)
        else:
            qtile.currentWindow.togroup(qtile.groups[i + 1].name)
        #qtile.currentWindow.togroup(qtile.groups[i + 1 % len(qtile.screens)].name)
        #qtile.currentScreen.togroup(qtile.groups[i + 1].name)
"""

@lazy.function
def window_to_prev_group(qtile):
    if qtile.current_window is not None:
        i = qtile.groups.index(qtile.current_group)
        qtile.current_window.togroup(qtile.groups[i - 1].name)
        #qtile.current_window.togroup(qtile.groups[i - 1  % len(qtile.screens)].name)
        #qtile.currentScreen.togroup(qtile.groups[i - 1].name)

@lazy.function
def window_to_next_group(qtile):
    if qtile.current_window is not None:
        i = qtile.groups.index(qtile.current_group)
        group_count = len(qtile.groups)
        if int(i) == int(group_count) - 1:
            qtile.current_window.togroup(qtile.groups[0].name)
        else:
            qtile.current_window.togroup(qtile.groups[i + 1].name)
        #qtile.current_window.togroup(qtile.groups[i + 1 % len(qtile.screens)].name)
        #qtile.currentScreen.togroup(qtile.groups[i + 1].name)

# kick a window to another screen (handy during presentations)
#def kick_to_next_screen(qtile, direction=1):
    #other_scr_index = (qtile.screens.index(qtile.currentScreen) + direction) % len(qtile.screens)
    #othergroup = None
    #for group in qtile.cmd_groups().values():
    #    if group['screen'] == other_scr_index:
    #        othergroup = group['name']
    #        break
    #if othergroup:
    #    qtile.moveToGroup(othergroup)

    #new_name =  (int(qtile.screens.name(qtile.currentScreen)) + direction) % len(qtile.screens)
    #lazy.window.togroup(new_name))
    


keys = [
    # Switch between windows in current stack pane
    #Key([mod], "k", lazy.layout.down()),
    #Key([mod], "j", lazy.layout.up()),

    # Move windows up or down in current stack
    Key([mod, "control"], "k", lazy.layout.shuffle_down()),
    Key([mod, "control"], "j", lazy.layout.shuffle_up()),

    # Switch window focus to other pane(s) of stack
    Key([mod], "space", lazy.layout.next()),

    # Swap panes of split stack
    Key([mod, "shift"], "space", lazy.layout.rotate()),

    # Toggle between split and unsplit sides of stack.
    # Split = all windows displayed
    # Unsplit = 1 window displayed, like Max layout, but still with
    # multiple stack panes
    Key([mod, "shift"], "Return", lazy.layout.toggle_split()),
    #Key([mod], "Return", lazy.spawn("gnome-terminal --window-with-profile=qtile")),
    Key([mod], "Return", lazy.spawn(myAltTerm)),

    # Toggle between different layouts as defined below
    Key([mod], "Tab", lazy.next_layout()),
    Key([mod, 'shift'], 'Tab', lazy.prev_layout()),
    Key([mod], "w", lazy.window.kill()),

    Key([mod, "control"], "r", lazy.restart()),
    Key([mod, "control"], "q", lazy.shutdown()),
    Key([mod], "r", lazy.spawncmd()),

    ## CUSTOM KEYS
    #  Identify keys using the command:
    #  xbindkeys -k
    #Key(["control", "shift"], "t", lazy.spawn("gnome-terminal --window-with-profile=qtile")),
    Key(["control", "shift"], "t", lazy.spawn(myTerm)),
    Key([mod], "t", lazy.spawn(myAltTerm)),
    Key(["control", "shift"], "w", lazy.spawn(myChrome)),
    #Key(["control", "shift"], "m", lazy.spawn(myAltChrome)),
    Key([mod], "b", lazy.spawn(myAltChrome)),
    Key([mod], "m", lazy.spawn(myAltChrome)),
    Key(["control", "shift"], "s", lazy.spawn("spotify --force-device-scale-factor=2.25 %U")),
    Key(["control", "shift"], "f", lazy.spawn("pcmanfm")),
    ## Toggle windows between floating and tiles
    Key([mod], "f", lazy.window.toggle_floating()),
    ## Toggle fullscreen (i.e. hide qtile bar)
    Key(["control", "shift"], "m", lazy.window.toggle_fullscreen()),
    #Key([mod], "m", lazy.window.toggle_fullscreen()),
    ## Launch cmus
    Key([mod], "c", lazy.spawn(myAltTerm + " -e cmus")),
    #Key(["control", "shift"], "n", lazy.spawn(myAltTerm + " -e neomutt")),
    #Key(["control", "shift"], "n", lazy.spawn(myTerm + " -e neomutt")),
    Key(["control", "shift"], "n", lazy.spawn(myTerm + " -e '. ~/.terminator_tmux_bashrc; neomutt'")),
    Key([mod], "v", lazy.spawn(myAltTerm + " -e '/home/nick/Documents/Scripts/start_vis.sh'")),
    Key(["control", "shift"], "r", lazy.spawn(myAltTerm + " -e '/home/nick/Documents/Scripts/start_ranger.sh'")),
    #Key(["control", "shift"], "r", lazy.spawncmd()),
    Key(["mod1"], "Tab", lazy.layout.next(), lazy.spawn("paplay /home/nick/Documents/Customization/Mint_Sounds/tile.oga &")),
    Key(["control"], "Right", lazy.screen.next_group()),
    Key(["control"], "Left", lazy.screen.prev_group()),
    #Key(["control"], "Left", lazy.group(str(lazy.screen.info()["index"] - 1 )).toscreen()),
    ## ADD VIM NAVIGATION (Edit: used by pane navigation)
    #Key([mod], "l", lazy.screen.next_group()),
    #Key([mod], "h", lazy.screen.prev_group()),
    #Key(["control", "shift"], "Right", lazy.function(kick_to_next_screen, 1)),
    #Key(["control", "shift"], "Left", lazy.function(kick_to_next_screen, -1)),
    Key(["control", "shift"], "Left", window_to_prev_group , lazy.screen.prev_group()),
    Key(["control", "shift"], "Right", window_to_next_group , lazy.screen.next_group()),
    #Key(["control"], "Left", window_to_prev_group),
    #Key(["control"], "Right", lazy.window_to_next_group),
    Key(["control", "shift"], 'm', lazy.window.toggle_fullscreen()),
    #### DON'T ADD FOR EMACS COMPATABILITY  ####   Key(["control"], "w", lazy.window.kill()),
    #### DON'T ADD SINCE IT IS USED BY CHROME #### Key(["control", "shift"], "w", lazy.window.kill()),
    Key([], "XF86AudioLowerVolume", lazy.spawn("/home/nick/.config/qtile/volume-down.sh")),
    Key([], "XF86AudioRaiseVolume", lazy.spawn("/home/nick/.config/qtile/volume-up.sh")),
    Key([], "XF86AudioMute", lazy.spawn("/home/nick/.config/qtile/volume-mute-toggle.sh")),
    #Key([],"Scroll_Lock", lazy.spawn("amixer set Master 3%-"),lazy.spawn("paplay /home/nick/Documents/Customization/Mint_Sounds/volume.oga")),
    #Key([],'Pause', lazy.spawn("amixer set Master 3%+"),lazy.spawn("paplay /home/nick/Documents/Customization/Mint_Sounds/volume.oga")),
    #Key([],"Scroll_Lock", lazy.spawn("amixer set Master 3%-")),
    #Key([],'Pause', lazy.spawn("amixer set Master 3%+")),
    #Key([], "XF86AudioMute", lazy.spawn("/home/nick/.config/qtile/volume-mute-toggle.sh")),
    #Key([], "XF86AudioLowerVolume", lazy.spawn("/home/nick/.config/qtile/volume-down.sh")),
    #Key([], 'XF86AudioRaiseVolume', lazy.spawn("/home/nick/.config/qtile/volume-up.sh")),
    #Key([], "XF86AudioMute", lazy.spawn("/home/nick/.config/qtile/volume-mute-toggle.sh")),
    Key([], 'Print', lazy.spawn("gnome-screenshot")),
    #Key(["mod4"], "o", lazy.spawn("/home/nick/.config/qtile/volume-mute-toggle.sh")),
    #Key([mod], "o", lazy.spawn("/home/nick/.config/qtile/volume-mute-toggle.sh")),
    #Key([], "XF86RotateWindows", lazy.spawn("/home/nick/.config/qtile/volume-mute-toggle.sh")),
    ## Control audio settings
    Key([mod], "a", lazy.spawn("pavucontrol")),
    ## Toggle screensaver
    Key([mod],'s', lazy.spawn("/home/nick/.config/qtile/toggle_screensaver.sh")),
    #Key([mod], "k", lazy.spawn("onboard -x 3 -y 625 -s 1900x400 -l /usr/share/onboard/layouts/Full\ Keyboard.onboard -t /usr/share/onboard/themes/Blackboard.theme")),
    Key(["control", "shift"], "Down", lazy.layout.shrink()),
    Key(["control", "shift"], "Up", lazy.layout.grow()),
    ## ADD VIM NAVIGATION
    Key([mod], "h", lazy.layout.left()),
    Key([mod], "l", lazy.layout.right()),
    Key([mod], "j", lazy.layout.down()),
    Key([mod], "k", lazy.layout.up()),
    Key([mod, "shift"], "h", lazy.layout.swap_left()),
    Key([mod, "shift"], "l", lazy.layout.swap_right()),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down()),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up()),
]

groups = [Group(i) for i in "1234"]

for i in groups:
    keys.extend([
        # mod1 + letter of group = switch to group
        Key([mod], i.name, lazy.group[i.name].toscreen()),

        # mod1 + shift + letter of group = switch to & move focused window to group
        Key([mod, "shift"], i.name, lazy.window.togroup(i.name)),
    ])

layouts = [
    layout.Max(**layout_theme),
    layout.MonadTall(**xlayout_theme),
    layout.MonadWide(**xlayout_theme),
    #layout.Floating(),
    #layout.Stack(stacks=2, **layout_theme),
    #layout.verticaltile.VerticalTile(**altlayout_theme)
]

widget_defaults = dict(
    font='sans',
    #fontsize=19,
    #padding=7,
    fontsize=32,
    padding=14,
)
extension_defaults = widget_defaults.copy()


screens = [
    Screen(
        #top=bar.Bar(
        bottom=bar.Bar(
            [
                widget.GroupBox(),
                widget.Prompt(),
                widget.TextBox("  |  ", name="spacing"),
                widget.WindowName(),
                #widget.CurrentLayout(),
                #widget.TextBox("default config", name="default"),
                widget.Systray(),
                ## Show Cmus status
                #widget.Cmus(play_color='4f89cc'),
                ## Show disk usage
                #widget.HDDGraph(),
                ## Show CPU usage
                #widget.YahooWeather(location="lafayette, in",format="{location_city}: {condition_temp}"),
                #widget.TextBox("CPU:  ", name="CPU"),
                #widget.CPUGraph(),
                ## Show volume status
                #widget.TextBox("   | ", name="spacing"),
                #widget.TextBox("Battery:", name="Battery"),
                #widget.Battery(**bat_config),
                #widget.TextBox("| ", name="spacing"),
                #widget.BatteryIcon(),
                widget.Battery(**bat_config),
                #widget.TextBox("|   Volume:", name="Volume"),
                #widget.YahooWeather(woeid="2517274"),
                #widget.KhalCalendar(),
                ###
                ### Python strftime documentation: http://strftime.org/
                ###
                widget.Clock(format='|    %B %d,  20%y     |'),
                widget.TextBox("   Volume:", name="Volume"),
                widget.Volume(),
                #widget.TextBox("", name="spacing"),
                ## Show date and time
                #widget.Clock(format=' |   %A  %m / %d   |    %I:%M %p   '),
                #widget.Clock(format=' |   %A  %m / %d   '),
                widget.TextBox("   |   ", name="spacing"),
                widget.CheckUpdates(distro="Arch",display_format="{updates}  available updates"),
                #widget.TextBox("  ", name="spacing"),
                widget.TextBox(" ", name="spacing"),
                widget.Clock(format='|    %H:%M     '),
            ],
        # SET HEIGHT OF BOTTOM BAR
        72,
        ),
    ),
]


# Drag floating layouts.
mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(),
         start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(),
         start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front())
]

dgroups_key_binder = None
dgroups_app_rules = []
main = None
follow_mouse_focus = True
bring_front_click = False
cursor_warp = False
floating_layout = layout.Floating(float_rules=[
    {'wmclass': 'confirm'},
    {'wmclass': 'dialog'},
    {'wmclass': 'download'},
    {'wmclass': 'error'},
    {'wmclass': 'file_progress'},
    {'wmclass': 'notification'},
    {'wmclass': 'splash'},
    {'wmclass': 'toolbar'},
    {'wmclass': 'confirmreset'},  # gitk
    {'wmclass': 'makebranch'},  # gitk
    {'wmclass': 'maketag'},  # gitk
    {'wname': 'branchdialog'},  # gitk
    {'wname': 'pinentry'},  # GPG key password entry
    {'wmclass': 'ssh-askpass'},  # ssh-askpass
    #{'wname': 'onboard'},  # ONBOARD
    {'wmclass': 'onboard'},  # ONBOARD
])
auto_fullscreen = True
focus_on_window_activation = "smart"

# XXX: Gasp! We're lying here. In fact, nobody really uses or cares about this
# string besides java UI toolkits; you can see several discussions on the
# mailing lists, github issues, and other WM documentation that suggest setting
# this string if your java app doesn't work correctly. We may as well just lie
# and say that we're a working one by default.
#
# We choose LG3D to maximize irony: it is a 3D non-reparenting WM written in
# java that happens to be on java's whitelist.
wmname = "LG3D"



