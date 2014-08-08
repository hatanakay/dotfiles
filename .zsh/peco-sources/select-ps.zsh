
function peco-select-ps() {
  BUFFER=$(ps aux | peco )
  zle -R -c               # refresh
}

zle -N peco-select-ps
bindkey '^x^p' peco-select-ps
