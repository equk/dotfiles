# Setup fzf
# ---------
#
# setup fzf using fzf scripts installed via package manager

# check for fzf binary installed
if ! [ -x "$(command -v fzf)" ]; then
    echo -e "ERROR: fzf executable not found"
fi

# import zsh scripts from fzf package
if [ -d "/usr/share/fzf" ] ; then
    # autocompletion
    ## [[ $- == *i* ]] && source "/usr/share/fzf/completion.zsh" 2> /dev/null

    # keybindings
    source "/usr/share/fzf/key-bindings.zsh"
else
    echo -e "ERROR: fzf imports not found"
fi

