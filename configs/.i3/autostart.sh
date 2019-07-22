#!/bin/bash
# i3 autostart
# ============
## settings for Razer BlackWidow 2013
#setxkbmap -layout 'gb' -model 'pc105'
## settings for us keyboard layout (filco tenkeyless)
## us layout for ansi 60% keyboard
setxkbmap -layout 'us'
# remap dollar sign to currency symbol
# dollar: xmodmap -e "keycode  13 = 4 dollar 4 dollar"
# pound: xmodmap -e "keycode  13 = 4 sterling 4 sterling"
# euro: xmodmap -e "keycode  13 = 4 EuroSign 4 EuroSign"
# remap right menu key to function as start key
xmodmap -e "keycode 135 = Super_R NoSymbol Super_R"
# remove any wine applications or filetype references
# (not really into opening exe viruses on double click in linux)
rm -fr ~/.local/share/applications/wine-*
# remove any application shortcuts for wine
rm -fr ~/.local/share/applications/wine/Programs
# set nvidia gpu fanspeed (requires coolbits 4+)
#nvidia-settings -a "[gpu:0]/GPUFanControlState=1" -a "[fan:0]/GPUTargetFanSpeed=55"
