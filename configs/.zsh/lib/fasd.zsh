## load fasd - equk
## ref: https://github.com/clvv/fasd/
# add prehook to zsh
_fasd_preexec() {
    {
        eval "fasd --proc $(fasd --sanitize $1)"
    } >>"/dev/null" 2>&1
}
# autoload fasd hook
autoload -Uz add-zsh-hook
add-zsh-hook preexec _fasd_preexec
# fasd directory jump function
fasd_cd() {
    if [ $# -le 1 ]; then
        fasd "$@"
    else
        local _fasd_ret="$(fasd -e 'printf %s' "$@")"
        [ -z "$_fasd_ret" ] && return
        [ -d "$_fasd_ret" ] && cd "$_fasd_ret" || printf %s\n "$_fasd_ret"
    fi
}
# fasd aliases
alias a='fasd -a'
alias s='fasd -si'
alias sd='fasd -sid'
alias sf='fasd -sif'
alias d='fasd -d'
alias f='fasd -f'
# fasd jump to directory
alias z='nocorrect fasd_cd -d'
alias j='nocorrect fasd_cd -d'
## end fasd
