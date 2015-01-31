function peco-rake-task() {
    local tasks="bundle exec rake -AT"
    task=$(eval $tasks | peco --query "$LBUFFER" )
    task-split=("${(s/ /)task}")
    BUFFER=$task-split[1,2]
    CURSOR=$#BUFFER
    zle -R -c
}
zle -N peco-rake-task
