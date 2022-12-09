###

# Set Defaults
export EDITOR="nvim"
export TERMINAL="alacritty"
export BROWSER=$(which brave)
export HISTCONTROL="ignoredups"

# ls colors
autoload colors; colors;
export LSCOLORS="Gxfxcxdxbxegedabagacad"

setopt auto_name_dirs
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
setopt auto_cd
setopt multios
setopt cdablevarS
setopt prompt_subst

PS1="%n@%m:%~%# "
SHORT_HOST=${HOST/.*/}
ZSH_COMPDUMP="${ZDOTDIR:-${HOME}}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION}"
autoload -U compaudit compinit
compinit -i -d "${ZSH_COMPDUMP}"

# Colors
export NC='\e[0m'
export white='\e[0;30m'
export WHITE='\e[1;30m'
export red='\e[0;31m'
export RED='\e[1;31m'
export green='\e[0;32m'
export GREEN='\e[1;32m'
export yellow='\e[0;33m'
export YELLOW='\e[1;33m'
export blue='\e[0;34m'
export BLUE='\e[1;34m'
export magenta='\e[0;35m'
export MAGENTA='\e[1;35m'
export cyan='\e[0;36m'
export CYAN='\e[1;36m'
export black='\e[0;37m'
export BLACK='\e[1;37m'

# Colorful manpages using less
export LESS_TERMCAP_mb=$'\e[1;31m'
export LESS_TERMCAP_md=$'\e[1;31m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[1;44;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;32m'

# autocorrection
setopt correct_all
alias man='nocorrect man'
alias mv='nocorrect mv'
alias mysql='nocorrect mysql'
alias mkdir='nocorrect mkdir'
alias gist='nocorrect gist'
alias heroku='nocorrect heroku'
alias ebuild='nocorrect ebuild'
alias hpodder='nocorrect hpodder'
alias sudo='nocorrect sudo'

## Command history configuration
if [ -z $HISTFILE ]; then
    HISTFILE=$HOME/.zsh_history
fi
HISTSIZE=10000
SAVEHIST=10000

setopt append_history
setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups # ignore duplication command history list
setopt hist_ignore_space
setopt hist_verify
setopt inc_append_history
setopt share_history # share command history data

# Key bindings
bindkey "\e[1~" beginning-of-line
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[3~" delete-char
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "^[[A" history-beginning-search-backward
bindkey "^[[B" history-beginning-search-forward

# Set Aliases
alias update='paru -Syu'
alias mem='free -mot; sync && echo -n 3 | sudo tee /proc/sys/vm/drop_caches; free -mot'
alias diff='colordiff'
alias ls='ls -hF --color=auto --group-directories-first '
alias ll='ls -lhF --color=auto --group-directories-first '
alias df='df -h -T'
alias duf='du -skh * | sort -n'
# git alias
alias g='git'
# use ripgrep instead of grep
alias grep='rg'
# use neovim instead of vim
alias vim='nvim'
# use neovim with jellybeans for vimdiff
alias vimdiff='nvim -c "colorscheme jellybeans" -d '
# add color to ip
alias ip='ip -c'
# quick nmap scan over socks
alias pscan='proxychains nmap -sTV -PN -n -p21,22,25,80,3306,3389 '
# start pcap split into 5min chunks (max 50min)
alias pcap='sudo tcpdump -G 300 -w $HOME/pcaps/%Y-%m-%d_%H:%M.pcap -W 10'
# http server for testing static content
alias serve='hs . -a localhost'
# update grub config
alias grub-update='sudo grub-mkconfig -o /boot/grub/grub.cfg'
# kill all running windows executables
alias killexe='kill $(pgrep .exe)'

# Treesize view of current directory
## alias treesize='du -h --max-depth=1 | sort -nr'
alias treesize='ncdu'

# Wget open directory
alias wgeto='wget -H -r --level=1 -k -p '

# get http request headers with httpie
alias header='http --headers '
alias headers='http --headers '

# list explicitly installed packages which are not dependencies
# can use to cleanup packages - eg: python, ruby
alias paclsnodep='pacman -Qetq | grep'

# Extract
function extract () {
    if [ -f $1 ] ; then
        case $1 in
            *.tar.bz2) tar xjf $1 ;;
            *.tar.gz) tar xzf $1 ;;
            *.bz2) bunzip2 $1 ;;
            *.rar) unrar x $1 ;;
            *.gz) gunzip $1 ;;
            *.tar) tar xf $1 ;;
            *.tbz2) tar xjf $1 ;;
            *.tgz) tar xzf $1 ;;
            *.tar.xz) tar xJf $1 ;;
            *.zip) unzip $1 ;;
            *.Z) uncompress $1 ;;
            *.7z) 7z x $1 ;;
            *) echo "'$1' cannot be extracted via extract()" ;;
        esac
    else
        echo "'$1' is not a valid file"
    fi
}

# remove orphaned/un-needed packages
alias pacclean='sudo pacman -Rs $(pacman -Qqdt)'
# remove unused packages in cache
alias paccleanup='sudo pacman -Sc'

## use paru for cleanup (also cleans ~/.cache/paru/)
# remove unused packages & aur builds in cache
if command -v paru &> /dev/null
then
    alias paccleanup='paru -Sc'
    # use paru instead of yay
    alias yay='paru'
    alias p='paru'
fi

alias paclsorphans='pacman -Qdt'
alias pacrmorphans='sudo pacman -Rs $(pacman -Qtdq)'

# list 30 largest packages installed
alias pacbig='expac -s -H M "%-30n %m" | sort -rhk 2 | head -n 30'

# list hwmon devices
alias hwmonls='ls -l /sys/class/hwmon'

# mongodb gui
alias robomongo='robo3t'
alias mongogui='robo3t'

# systemd log view
alias service-log='journalctl -b -u '

## smart urls
autoload -U url-quote-magic
zle -N self-insert url-quote-magic

## file rename magick
bindkey "^[m" copy-prev-shell-word

## jobs
setopt long_list_jobs

## pager
export PAGER="less"
export LESS="-R"

export LC_CTYPE=$LANG

## custom theme - equk
function prompt_char {
  if [ $UID -eq 0 ]; then echo "#"; else echo $; fi
}

PROMPT='%(!.%{$fg_bold[red]%}.%{$fg_bold[green]%}%n@)%m %{$fg_bold[blue]%}%(!.%1~.%~)$(git_prompt_info)$(virtualenv_prompt_info)%{$fg_bold[blue]%}%_$(prompt_char)%{$reset_color%} '

ZSH_THEME_GIT_PROMPT_PREFIX=" (%{$fg[red]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%}✗%{$fg[blue]%})%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$fg[green]%}✔%{$fg[blue]%})%{$reset_color%}"

## virtualenv support for theme
function virtualenv_prompt_info(){
  if [[ -n $VIRTUAL_ENV ]]; then
    printf "%s[%s] " "%{${fg[yellow]}%}" ${${VIRTUAL_ENV}:t}
  fi
}

###
## PATHS
###

# check path is directory
# add to $PATH if not already added
function uniqpath {
  if [ -d "$1" ] ; then
    case ":$PATH:" in
      *":$1:"*) :;;
      *) export PATH="$1:$PATH";;
    esac
  fi
}

# HOME BIN PATH
uniqpath "$HOME/bin"

## RUBY STUFF (user installed gems)
# GEM_HOME for bundler
export GEM_HOME=$(ruby -e 'puts Gem.user_dir')
# RUBY BIN PATH
uniqpath "$GEM_HOME/bin"

# GOLANG PATHS
if [ -d "$HOME/golang" ] ; then
    # go projects path
    export GOPATH=$HOME/golang
    # adding binary path for golang projects
    uniqpath $GOPATH/bin
fi

# NODEJS PATH
uniqpath $HOME/node/bin

# RUST CARGO PATH
uniqpath $HOME/.cargo/bin

# N_PREFIX for nodejs manager `n`
if [ -d "$HOME/node" ] ; then
    export N_PREFIX=$HOME/node
fi

# disables prompt mangling in virtual_env/bin/activate
export VIRTUAL_ENV_DISABLE_PROMPT=1

# set wine to always run 64bit
export WINEPREFIX=$HOME/win64/
export WINEARCH=win64

# alias for golang dnscrypt-proxy
alias dnscrypt-edit='sudo vim /etc/dnscrypt-proxy/dnscrypt-proxy.toml'
alias dnscrypt-resolvers='sudo vim /var/cache/dnscrypt-proxy/public-resolvers.md'

# set QEMU to use ALSA for audio
export QEMU_AUDIO_DRV=alsa

# display error message for chrome
alias chrome='notify-send "No Chrome Here" "Use Brave Instead" -i brave-desktop'
# display error message for firefox
alias firefox='notify-send "No Firefox Here" "Use Brave Instead" -i brave-desktop'

# restart dnscrypt-proxy
# show service log
alias dnsre='sudo systemctl restart dnscrypt-proxy.service && sleep 1 && journalctl -b -u dnscrypt-proxy.service'

