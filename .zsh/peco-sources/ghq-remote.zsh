function peco-ghq-remote() {
    local selected_dir=$(ghq list --full-path | peco --query "$LBUFFER")
    if [ -n "$selected_dir" ]; then
        BUFFER="gh-open ${selected_dir}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-ghq-remote
bindkey '^f' peco-ghq-remote
