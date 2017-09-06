function peco-alias(){
  TARGET_ALIAS=$(alias | peco --query "$LBUFFER")
  BUFFER=$(echo "$TARGET_ALIAS"|awk -F '=' '{print $1}')
  CURSOR=$#BUFFER
  zle clear-screen
}
zle -N peco-alias
