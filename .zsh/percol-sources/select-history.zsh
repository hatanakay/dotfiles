
function percol-select-history() {
  local tac_cmd
  which gtac &> /dev/null && tac_cmd=gtac || tac_cmd=tac
  BUFFER=$(history | $tac_cmd | sed 's/^: [0-9]*:[0-9]*;//' \
    | percol --match-method migemo --query "$LBUFFER")
  CURSOR=$#BUFFER         # move cursor
  zle -R -c               # refresh
}

zle -N percol-select-history
bindkey '^r' percol-select-history
