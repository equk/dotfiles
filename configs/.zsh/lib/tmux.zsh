# start tmux session
[[ -z "$DISPLAY" ]] && exit 0
[[ $- != *i* ]] && exit 0
[[ -z "$TMUX" ]] && exec tmux
