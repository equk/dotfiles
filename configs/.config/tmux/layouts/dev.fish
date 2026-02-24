#!/usr/bin/fish
tmux new-window -n $(fish_prompt_pwd_dir_length=1 prompt_pwd)
tmux splitw -h
tmux splitw -v
tmux select-pane -L

