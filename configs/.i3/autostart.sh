#!/bin/bash
# i3 autostart
# ============
## us layout for ansi 60% keyboard
setxkbmap -layout 'us'
# remap right menu key to function as start key
xmodmap -e "keycode 135 = Super_R NoSymbol Super_R"
# set typematic delay and rate
xset r rate 200 30

