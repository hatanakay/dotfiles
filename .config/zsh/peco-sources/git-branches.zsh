function peco-git-recent-all-branches () {
    #local selected_branch=$(git branch -a | peco | sed -e "s/\* //g" | awk "{print \$1}" | sed -e 's/remote\/refs\///g' | sed -e 's/remotes\/origin\///g')
    local selected_branch="$(git for-each-ref --format='%(refname:short) | %(committerdate:relative) | %(committername) | %(subject)' --sort=-committerdate refs/heads refs/remotes \
        | column -t -s '|' \
        | peco \
        | head -n 1 \
        | awk '{print $1}' \
        | sed -e 's/remote\/refs\///g' | sed -e 's/remotes\/origin\///g' | sed -e 's/origin\///g')"

    if [ -n "$selected_branch" ]; then
        BUFFER="git checkout ${selected_branch}"
        zle accept-line
    fi
    zle clear-screen
}
zle -N peco-git-recent-all-branches
