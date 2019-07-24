#!/bin/bash
#
#*****************************************************************
#     dotfiles install.sh - equk.co.uk
#*****************************************************************
# Copyright (C) 2019  B.Walden
#*****************************************************************
# This script was made as an alternative to using multiple
# symlinks for the syncing of dotfiles to github.
# The script simply copies files from the /configs directory
#*****************************************************************
# NOTES:
#    This script will prompt before overwriting existing configs
#*****************************************************************
# LICENSE: MIT
#*****************************************************************

# COLORS
blue="\033[1;34m"
green="\033[1;32m"
red="\033[1;31m"
bold="\033[1;37m"
reset="\033[0m"

# CLI FEEDBACK
gplus="[$green+$reset]"
bplus="[$blue+$reset]"
rplus="[$red+$reset]"

# CHECK ROOT USER
if [ $(id -u) -eq 0 ]; then
    echo -e "$red ERROR:$reset do not run this script as root"
    exit 1
fi
if [ $(whoami) = "root" ]; then
    echo -e "$red ERROR:$reset do not run this script as root"
    exit 1
fi

# COPY FUNC
function copy() {
    if [ -f $1 ]; then
        ORIGIN=$1
        DESTINATION=$(echo "$ORIGIN" | sed "s#^\./configs/#$HOME/#")

        mkdir -p $(dirname "$DESTINATION")

        if [ -a "$DESTINATION" ]; then
            if diff "$ORIGIN" "$DESTINATION" >/dev/null; then
                echo -e "$bplus $DESTINATION already up to date"
                return 2
            fi

            while true; do
                echo -e "$rplus $DESTINATION already exists"
                read -p "!!! Overwrite it? [Y/N]" yn
                case $yn in
                [Yy]*)
                    echo -e "$gplus Copying $ORIGIN to $DESTINATION"
                    cp "$ORIGIN" "$DESTINATION"
                    return 2
                    ;;
                [Nn]*) return 2 ;;
                *) echo -e "$rplus Expected yes or no." ;;
                esac
            done
        else
            echo -e "$gplus Copying $ORIGIN to $DESTINATION"
            cp "$ORIGIN" "$DESTINATION"
        fi

    else
        echo "$red ERROR:$reset '$1' does not exist"
    fi
}

# BANNER
echo -e ""
echo -e "equk $red::$reset linux dotfiles install"
echo -e "------------------------------"
echo -e ""
echo -e "   $green git:$reset https://github.com/equk"
echo -e "   $blue web:$reset https://equk.co.uk"
echo -e ""
echo -e "$green+++$reset installing equk dotfiles"
echo -e ""

# COPY CONFIG FILES
for file in $(find ./configs -type f); do
    copy $file
done
