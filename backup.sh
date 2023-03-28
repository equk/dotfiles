#!/bin/bash
#
#*****************************************************************
#     dotfiles backup.sh - equk.co.uk
#*****************************************************************
# Copyright (C) 2019 B.Walden
#*****************************************************************
# This script was made as an alternative to using multiple
# symlinks for the syncing of dotfiles to github.
# The script simply copies files to the /configs directory
#
# LICENSE: MIT
#*****************************************************************

# COLORS
blue="\033[1;34m"
green="\033[1;32m"
red="\033[1;31m"
bold="\033[1;37m"
reset="\033[0m"

# VARIABLES
base_files=".bashrc .zshrc .tmux.conf .Xdefaults .Xresources"
day=$(date '+%d/%m/%Y')

gplus="[$green+$reset]"
bplus="[$blue+$reset]"

# CHECK ROOT USER
if [ $(id -u) -eq 0 ]; then
    echo -e "$red ERROR:$reset do not run this script as root"
    exit 1
fi
if [ $(whoami) = "root" ]; then
    echo -e "$red ERROR:$reset do not run this script as root"
    exit 1
fi

# BANNER
echo -e ""
echo -e "equk $red::$reset linux dotfiles backup"
echo -e "-----------------------------"
echo -e ""
echo -e "   $green git:$reset https://github.com/equk"
echo -e "   $blue web:$reset https://equk.co.uk"
echo -e ""
echo -e "$green+++$reset copying dotfiles to $PWD/configs"
echo -e ""

# COPY FUNC
function copy() {
    if [ -f $1 ]; then
        ORIGIN=$1
        DESTINATION=$(echo "$ORIGIN" | sed "s#^$HOME/#./configs/#")

        mkdir -p $(dirname "$DESTINATION")

        if [ -a "$DESTINATION" ]; then
            if diff "$ORIGIN" "$DESTINATION" >/dev/null; then
                echo -e "  $bplus $DESTINATION already up to date"
                return 2
            fi

            while true; do
                echo -e "  $gplus updating file $DESTINATION"
                cp "$ORIGIN" "$DESTINATION"
                return 2
            done
        else
            echo -e "  $gplus Copying $ORIGIN"
            cp "$ORIGIN" "$DESTINATION"
        fi

    else
        echo -e "  $red ERROR:$reset '$1' does not exist"
    fi
}

# START COPYING FILES
echo -e "$gplus copying base files"
for file in $base_files; do
    copy $HOME/$file
done

echo -e "$gplus copying zsh configuration files"
copy ~/.zsh/config.sh
for file in $(find ~/.zsh/lib -type f); do
    copy $file
done

echo -e "$gplus copying neovim configuration files"
copy ~/.config/nvim/init.lua
for file in $(find ~/.config/nvim/lua -type f); do
    copy $file
done

echo -e "$gplus copying alacritty configuration files"
copy ~/.config/alacritty/alacritty.yml

echo -e "$gplus copying picom configuration files"
copy ~/.config/picom/picom.conf

echo -e "$gplus starting Visual Studio Code"
echo -e "  $gplus creating extension list for Visual Studio Code"
[ -d ./lists/ ] || mkdir -p ./lists/
code --list-extensions >./lists/vscode_extensions.txt
echo -e "  $gplus copying user preferences for Visual Studio Code"
copy ~/.config/Code/User/settings.json
echo -e "  $gplus copying commandline arguments for Visual Studio Code"
copy ~/.vscode/argv.json

echo -e "$gplus copying font configuration files"
for file in $(find ~/.config/fontconfig -type f); do
    copy $file
done

echo -e "$gplus copying i3wm configuration files"
copy ~/.i3/config

echo -e "$gplus copying neofetch configuration files"
copy ~/.config/neofetch/config.conf

echo -e "$gplus copying mpv configuration files"
copy ~/.config/mpv/mpv.conf

echo -e "$gplus copying radare2 configuration files"
copy ~/.config/radare2/radare2rc

echo -e "$gplus copying imwheel configuration files"
copy ~/.imwheelrc

echo -e "$gplus copying firefox desktop entry"
copy ~/.local/share/applications/firefox.desktop

# FINISHED
echo -e ""
echo -e "$green+++$reset finished copying equk configuration files"
echo -e ""
