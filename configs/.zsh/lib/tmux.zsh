# automatically execute tmux session
[[ $- != *i* ]] && return
[[ -z "$TMUX" ]] && exec tmux

