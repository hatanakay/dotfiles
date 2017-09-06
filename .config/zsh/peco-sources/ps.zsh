function peco-ps() {
  BUFFER=$(ps aux | peco )
  zle -R -c               # refresh
}

zle -N peco-ps
