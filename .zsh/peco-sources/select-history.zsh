
function peco-select-history() {
  local tac_cmd
  which gtac &> /dev/null && tac_cmd=gtac || tac_cmd=tac
  BUFFER=$(fc -l -n 1 | eval $tac_cmd | peco --query "$LBUFFER") 
  CURSOR=$#BUFFER         # move cursor
  zle -R -c               # refresh
}

zle -N peco-select-history
bindkey '^r' peco-select-history
