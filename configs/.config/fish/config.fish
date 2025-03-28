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

# path

## golang
set -gx GOPATH $HOME/golang

## ruby
###set -gx GEM_HOME (ruby -e 'puts Gem.user_dir')

### bin paths
set -gx PATH \
  $HOME/bin \
  $HOME/node/bin \
  $HOME/.cargo/bin \
  $GOPATH/bin \
  $PATH

# default apps
set -gx EDITOR nvim
set -gx BROWSER (which firefox)

# use sccache for rustc
set -gx RUSTC_WRAPPER (which sccache)

# init zoxide
# https://github.com/ajeetdsouza/zoxide
zoxide init --cmd j fish | source

# init atuin
# https://github.com/atuinsh/atuin
atuin init fish --disable-up-arrow | source

# aliases
alias man 'nocorrect man'
alias mv 'nocorrect mv'
alias mysql 'nocorrect mysql'
alias mkdir 'nocorrect mkdir'
alias gist 'nocorrect gist'
alias heroku 'nocorrect heroku'
alias ebuild 'nocorrect ebuild'
alias hpodder 'nocorrect hpodder'
alias sudo 'nocorrect sudo'

alias mem 'free -mot; sync && echo -n 3 | sudo tee /proc/sys/vm/drop_caches; free -mot'
alias diff 'colordiff'
alias ls 'ls -hF --color=auto --group-directories-first '
alias ll 'ls -lhF --color=auto --group-directories-first '
alias df 'df -h -T'
alias duf 'du -skh * | sort -n'

# git
alias g 'git'
# ripgrep
alias grep 'rg'
# neovim
alias vim 'nvim'
alias vimdiff 'nvim -c "colorscheme jellybeans" -d '
# bat
alias cat 'bat'
alias ip 'ip -c'
alias pscan 'proxychains nmap -sTV -PN -n -p21,22,25,80,3306,3389 '
alias pcap 'sudo tcpdump -G 300 -w $HOME/pcaps/%Y-%m-%d_%H:%M.pcap -W 10'
alias serve 'http-server . -a localhost'
alias killexe 'kill $(pgrep .exe)'
alias treesize 'ncdu'
alias wgeto 'wget -H -r --level=1 -k -p '
alias hwmonls 'ls -l /sys/class/hwmon'
alias service-log 'journalctl -b -u '
alias dnscrypt-edit 'sudo vim /etc/dnscrypt-proxy/dnscrypt-proxy.toml'
alias dnscrypt-resolvers 'sudo vim /var/cache/dnscrypt-proxy/public-resolvers.md'
alias chrome 'notify-send "No Chrome Here" "Use Firefox Instead" -i firefox'

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

