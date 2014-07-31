function peco-dir-open-vim () {
    find . -path '*.git' -prune -o -type f  | peco | xargs sh -c 'vim "$0" < /dev/tty'
    zle clear-screen
}
zle -N peco-dir-open-vim
bindkey '^x^v' peco-dir-open-vim
