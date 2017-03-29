function peco-git-diff() {
  git rev-parse --git-dir >/dev/null 2>&1
  if [[ $? == 0 ]]; then
    local target=$(git diff --stat master | peco | awk '{print $1}')
    if [[ -n $target ]]; then
        local master_file=/tmp/peco-git-diff-$(date +%Y%m%d%H%M%S)
        git show master:$target > $master_file
        vimdiff $master_file $target
        rm -f $master_file
    fi
  fi
}
alias pdiff="peco-git-diff"
