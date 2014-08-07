function peco-git-recent-all-branches () {
    local selected_branch=$(git branch -a | peco | sed -e "s/\* //g" | awk "{print \$1}")
    if [ -n "$selected_branch" ]; then
        BUFFER="git checkout ${selected_branch}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-git-recent-all-branches

bindkey '^x^b' peco-git-recent-all-branches
