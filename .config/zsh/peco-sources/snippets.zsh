function peco-snippets() {

    local SNIPPETS=$(grep -Ev "^#|^$" ~/.snippets | peco --query "$LBUFFER" | pbcopy)
    zle clear-screen
}

zle -N peco-snippets
