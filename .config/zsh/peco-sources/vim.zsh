function peco-vim () {
    if [ -e ./.git ]; then
        git ls-files | peco | xargs sh -c 'env LANG=ja_JP.UTF-8 reattach-to-user-namespace /Applications/MacVim.app/Contents/MacOS/Vim "$0" < /dev/tty'
    else
        find . -type f  | peco | xargs sh -c 'env LANG=ja_JP.UTF-8 reattach-to-user-namespace /Applications/MacVim.app/Contents/MacOS/Vim "$0" < /dev/tty'
    fi
    zle clear-screen
}
zle -N peco-vim
bindkey '^v' peco-vim
