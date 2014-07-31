function peco_select_rake_task_all() {
    local tasks="bundle exec rake -AT"
    task=$(eval $tasks | peco --query "$LBUFFER" )
    task_split=("${(s/ /)task}")
    BUFFER=$task_split[1,2]
    CURSOR=$#BUFFER
    zle -R -c
}
zle -N peco_select_rake_task_all
bindkey '^x^ar' peco_select_rake_task

function peco_select_rake_task() {
    local tasks="bundle exec rake -T"
    task=$(eval $tasks | peco --query "$LBUFFER" )
    task_split=("${(s/ /)task}")
    BUFFER=$task_split[1,2]
    CURSOR=$#BUFFER
    zle -R -c
}
zle -N peco_select_rake_task
bindkey '^x^r' peco_select_rake_task

