
function percol-select-ps() {
  BUFFER=$(ps aux | peco )
  zle -R -c               # refresh
}

alias selet-ps='percol-select-ps'
zle -N percol-select-ps
bindkey '^xp' percol-select-ps
