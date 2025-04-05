if status is-interactive
  # start Hyprland on login
  if test -z "$DISPLAY"
    exec Hyprland
  end
  # start tmux
  if test -z "$TMUX"
    exec tmux
  end
end

set -U fish_greeting
set fish_prompt_pwd_dir_length 0

## $PATH
###
# HOME
fish_add_path $HOME/bin
# NODEJS
fish_add_path $HOME/node/bin
# RUST
fish_add_path $HOME/.cargo/bin
# GOLANG
if test -d $HOME/golang
  set -gx GOPATH $HOME/golang
end
fish_add_path $GOPATH/bin
## RUBY
###set -gx GEM_HOME (ruby -e 'puts Gem.user_dir')

# N
# https://github.com/tj/n
if test -d $HOME/node
  set -gx N_PREFIX $HOME/node
end

# default apps
set -gx EDITOR (which nvim)
set -gx BROWSER (which firefox)

# use sccache for rustc
set -gx RUSTC_WRAPPER (which sccache)

# init zoxide
# https://github.com/ajeetdsouza/zoxide
zoxide init --cmd j fish | source

# init atuin
# https://github.com/atuinsh/atuin
atuin init fish --disable-up-arrow | source

## aliases

# use colors
alias diff 'colordiff'
alias ls 'ls -hF --color=auto --group-directories-first '
alias ll 'ls -lhF --color=auto --group-directories-first '

# df human readable + system type
alias df 'df -h -T'
# du human readable + summary + sort
alias duf 'du -skh * | sort -n'

# eza
# https://github.com/eza-community/eza
if command -v eza &>/dev/null
  alias l 'eza -lhA --icons --group-directories-first --time-style=iso'
  alias ll 'eza -lh --icons --group-directories-first --time-style=iso'
  alias tree 'eza -lh --icons --group-directories-first --time-style=iso -T'
end

# git
alias g 'git'
# ripgrep
alias grep 'rg'
# neovim
alias vim 'nvim'
alias vimdiff 'nvim -c "colorscheme jellybeans" -d '
# bat
alias cat 'bat'

# network related
alias ip 'ip -c'
alias pscan 'proxychains nmap -sTV -PN -n -p21,22,25,80,3306,3389 '
alias pcap 'sudo tcpdump -G 300 -w $HOME/pcaps/%Y-%m-%d_%H:%M.pcap -W 10'
alias serve 'http-server . -a localhost'

# kill all exe running in wine
alias killexe 'kill $(pgrep .exe)'
# use ncdu for treesize
alias treesize 'ncdu'
# wget open directory
alias wgeto 'wget -H -r --level=1 -k -p '
# list hwmon devices
alias hwmonls 'ls -l /sys/class/hwmon'
# show systemd log for service
alias service-log 'journalctl -b -u '

# archlinux package management
alias p 'pacman'
alias update 'p -Syu'
alias updaur 'p -Sua'
alias paclsnodep 'pacman -Qetq | grep'
alias pacclean 'sudo pacman -Rs $(pacman -Qqdt)'
alias paccleanup 'sudo pacman -Sc'
alias paclsorphans 'pacman -Qdt'
alias pacrmorphans 'sudo pacman -Rs $(pacman -Qtdq)'
alias pacbig 'expac -s -H M "%-30n %m" | sort -rhk 2 | head -n 30'

# use custom package manager
if command -v paru &>/dev/null
  alias p paru
end

