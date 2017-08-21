function peco-vim () {
    if [ -e ./.git ]; then
        git ls-files | peco | xargs sh -c 'nvim "$0" < /dev/tty'
    else
        find . -type f  | peco | xargs sh -c 'nvim "$0" < /dev/tty'
    fi
    zle clear-screen
}
zle -N peco-vim
bindkey '^v' peco-vim
