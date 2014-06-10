source $HOME/.zshrc.antigen
bindkey -e
#=============================
# history
#=============================
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt hist_ignore_dups # ignore duplication command history list
setopt share_history # share command history data
setopt extended_history
function history-all { history -E 1 }

#=============================
# Search History
#=============================
#autoload history-search-end
#zle -N history-beginning-search-backward-end history-search-end
#zle -N history-beginning-search-forward-end history-search-end
#bindkey "^P" history-beginning-search-backward-end
#bindkey "^N" history-beginning-search-forward-end

#=============================
# setopt
#=============================
autoload -U compinit #補完機能
compinit

setopt auto_cd           # 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_list         # 補完候補が複数ある時に、一覧表示する
setopt auto_menu         # 補完キー（Tab,  Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt auto_param_keys   # カッコの対応などを自動的に補完する
#setopt auto_param_slash  # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt auto_pushd        # cd でTabを押すとdir list を表示
setopt brace_ccl         # {a-c} を a b c に展開する機能を使えるようにする
setopt complete_aliases  # エイリアスを設定したコマンドでも補完機能を使えるようにする
setopt complete_in_word  # カーソル位置で補完する。
setopt correct           # コマンド自動修正
setopt correct_all       # コマンドライン全てのスペルチェックをする
setopt glob_complete     # globを展開しないで候補の一覧から補完する。
setopt hist_expand       # 補完時にヒストリを自動的に展開する。
setopt hist_no_store     # history コマンドを history に保存しない
setopt list_packed       # 補完候補リストを詰めて表示
setopt list_types        # 補完候補一覧でファイルの種別をマーク表示
setopt long_list_jobs    # 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt magic_equal_subst # コマンドラインの引数で --prefix=/usr などの = 以降でも補完できる
setopt mark_dirs         # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt multios           # 複数のリダイレクトやパイプなど、必要に応じて tee や cat の機能が使われる
setopt no_beep           # 補完候補がないときなどにビープ音を鳴らさない。
setopt no_clobber        # 上書きリダイレクトの禁止
setopt no_flow_control   # disable C-q, C-s
setopt noautoremoveslash # 最後がディレクトリ名で終わっている場合末尾の / を自動的に取り除かない
setopt nolistbeep        # 補完表示時にビープ音を鳴らさない
setopt numeric_glob_sort # 辞書順ではなく数字順に並べる。
setopt pushd_ignore_dups # ディレクトリスタックに同じディレクトリを追加しないようになる
setopt rm_star_wait      # rm * を実行する前に確認
setopt transient_rprompt # コピペしやすいようにコマンド実行後は右プロンプトを消す。

#=============================
# zstyle
#=============================

# 補完のグループ化
zstyle ':completion:*' format '%B%d%b'
zstyle ':completion:*' group-name ''
zstyle ':completion:*:default' menu select=2 # 補完メニューの表示
zstyle ':completion:*:default' list-colors "" # 補完候補の色分け
zstyle ':completion:*' use-cache true # 補完候補をキャッシュする。
zstyle ':completion:*' verbose yes # 詳細な情報を使う。
zstyle ':completion:sudo:*' environ PATH="$SUDO_PATH:$PATH" # sudo時にはsudo用のパスも使う。
zstyle ':vcs_info:*' enable git # svn hg bzr # git以外ではvcs_infoを利用しない

#=============================
# Alias
#=============================

# ls
case "${OSTYPE}" in
freebsd*)
  alias ls="ls -G -w"
  ;;
darwin*)
  alias ls="ls -G"
  alias gvim='env LANG=ja_JP.UTF-8 open -a /Applications/MacVim.app "$@"'
  ;;
linux*)
  alias ls="ls --color"
  ;;
esac
alias la="ls -a"
alias lf="ls -F"
alias ll="ls -l"
alias lla="ls -al"

# process
alias 'ps?'='pgrep -l -f'

# du/df
alias du="du -h"
alias df="df -h"
alias duh="du -h ./ --max-depth=1"

# su
alias su="su -l"

# vim
alias v='vim'
alias 'src'='exec zsh'
alias -g V="| vim -"

# rails
alias -g RET="RAILS_ENV=test"
alias -g RED="RAILS_ENV=development"
alias -g REP="RAILS_ENV=production"

# rake
alias raket='RAILS_ENV=test rake'
alias raked='RAILS_ENV=development rake'
alias rakep='RAILS_ENV=production rake'

# less
alias less='less -r'

# grep
alias 'gr'='grep --color=auto -ERUIn'

# git
alias g='git'
alias gi='git'
alias oppai='git'
alias gs='git status'
alias gst='git status -s -b'
alias gc='git commit'
alias gci='git commit -a'
alias gfp='git fetch && git pull origin master'
alias diff='colordiff'
alias diffs='colordiff --side-by-side --suppress-common-lines -W"`tput cols`"'
alias gitkeep='find . -type d -empty -print0 |xargs -0 -I % touch %/.'
alias gro='git fetch origin && git reset --hard origin/master'

#util
alias sed="gsed"
alias awk="gawk"
alias symlinks="find ./ -type l -print0 | xargs -0 ls -plah"
alias rbs="ruby -rwebrick -e'WEBrick::HTTPServer.new(:Port => 3000,  :DocumentRoot => Dir.pwd).start'"


# extract http://d.hatena.ne.jp/jeneshicc/20110215/1297778049
extract () {
  if [ -f $1 ] ; then
      case $1 in
          *.tar.bz2)   tar xvjf $1    ;;
          *.tar.gz)    tar xvzf $1    ;;
          *.tar.xz)    tar xvJf $1    ;;
          *.bz2)       bunzip2 $1     ;;
          *.rar)       unrar x $1     ;;
          *.gz)        gunzip $1      ;;
          *.tar)       tar xvf $1     ;;
          *.tbz2)      tar xvjf $1    ;;
          *.tgz)       tar xvzf $1    ;;
          *.tbz)       tar xfj $1     ;;
          *.zip)       unzip $1       ;;
          *.Z)         uncompress $1  ;;
          *.7z)        7z x $1        ;;
          *.lzma)      lzma -dv $1    ;;
          *.xz)        xz -dv $1      ;;
          *)           echo "don't know how to extract '$1'..." ;;
      esac
  else
      echo "'$1' is not a valid file!"
  fi
}

#=============================
# OS固有設定
#=============================
case "${OSTYPE}" in
# Mac(Unix)
darwin*)
    # ここに設定
    [ -f ~/dotfiles/.zshrc.osx ] && source ~/dotfiles/.zshrc.osx
    ;;
# Linux
linux*)
    # ここに設定
    [ -f ~/dotfiles/.zshrc.linux ] && source ~/dotfiles/.zshrc.linux
    ;;
esac

lstat(){
    if [[ $# == 0 ]]; then
        if [[ -f ./.* ]]; then
            command gstat --printf "%A:%a %U:%G %.19y %n \n" .* *
        else
            command gstat --printf "%A:%a %U:%G %.19y %n \n" *
        fi
    else
        if [[ -d $@ ]]; then
            local dir=$(echo $@ | sed -e 's/\(^.*\)\/$/\1/g')
            if [[ -f $dir/.* ]]; then
                command gstat --printf "%A:%a %U:%G %.19y %n \n" $dir/.* $dir/*
            else
                command gstat --printf "%A:%a %U:%G %.19y %n \n" $dir/*
            fi
        else
            command gstat --printf "%A:%a %U:%G %.19y %n \n" $@
        fi 
    fi
}
#=============================
# tmux ssh
#=============================
# ssh wrapper that rename current tmux window to the hostname of the
# remote host.
set_term_bgcolor(){
    local R=$1
    local G=$2
    local B=$3
    /usr/bin/osascript <<EOF > /dev/null 2>&1
tell application "iTerm"
  tell the current terminal
    tell the current session
      set background color to {$(($R*65535/255)), $(($G*65535/255)), $(($B*65535/255))}
    end tell
  end tell
end tell
EOF
}

is_production() {
    if [[ -f ~/.production_hosts ]]; then
        for i in `cat ~/.production_hosts`; do
            if [[ "$@" =~ $i ]]; then
                return 0
            fi
        done
    fi
    return 1
}

ssh() {
    # Do nothing if we are not inside tmux or ssh is called without arguments
    if [[ $# == 0 || -z $TMUX ]]; then
        command ssh $@
        return
    fi
    # The hostname is the last parameter (i.e. ${(P)#})
    local remote_ip
    local full_host
    local remote
    local user
    if [[ "$@" =~ ^.*\@.*$ ]]; then
        local wk_host=${${(P)#}%}
        remote=$(echo ${wk_host} | cut -d '@' -f2)
        user=$(echo ${wk_host} | cut -d '@' -f1 )
    else
        remote=${${(P)#}%}
    fi

    if [[ $remote =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        remote_ip=$@
        full_host="NONE"
    else
        full_host=$(sed -n "/^Host ${remote}/,/^  HostName.*$/p" $HOME/.ssh/config | grep HostName | cut -d' ' -f4)
        if [[ 0 == "${#full_host}" ]]; then
            remote_ip=$(dig ${remote} +short)
        else
            remote_ip=$(dig ${full_host} +short)
        fi
    fi
    
    if is_production "$remote"; then
        set_term_bgcolor 0 102 0    
    fi

    if [[ $full_host =~ ^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$ ]]; then
        remote_ip=$full_host
        full_host=$remote
    fi

    if [[ "" == "${remote_ip}" ]]; then
        remote_ip="vagrant"
    fi

    local window_name="$(echo ${remote} | awk -F. '{ print $1}')"
    local old_name="$(tmux display-message -p '#W')"
    local renamed=0
    # Save the current name
    if [[ $remote != -* ]]; then
        renamed=1
        if [[ "NONE" == "${full_host}" ]]; then
            tmux rename-window "ssh(${remote_ip})"; 
        else
            if [[ 0 == ${#full_host} ]]; then
                full_host=$@
            fi
            if is_production "$remote"; then
               tmux rename-window "ssh:#[fg=yellow]${full_host}#[fg=default](#[fg=red]${remote_ip}#[fg=default])"; 
            else
               tmux rename-window "ssh:#[fg=white]${full_host}#[fg=default](#[fg=colour153]${remote_ip}#[fg=default])"; 
            fi
        fi
    fi
    command ssh $@
    if [[ $renamed == 1 ]]; then
        set_term_bgcolor 0 0 0
        tmux rename-window "$old_name"
    fi
}


tmuxx(){
    if ! type tmux >/dev/null 2>&1; then
        echo 'Error: tmux command not found' 2>&1
        exit 1
    fi

    if [ -n "$TMUX" ]; then
        echo "Error: tmux session has been already attached" 2>&1
        exit 1
    fi

    if tmux has-session >/dev/null 2>&1 && tmux list-sessions | grep -qE '.*]$'; then
        # detached session exists
        tmux attach && echo "tmux attached session "
    else
        if [[ ( $OSTYPE == darwin* ) && ( -x $(which reattach-to-user-namespace 2>/dev/null) ) ]]; then
            # on OS X force tmux's default command to spawn a shell in the user's namespace
            tmux_config=$(cat $HOME/.tmux.conf <(echo 'set-option -g default-command "tmux rename-window zsh; reattach-to-user-namespace -l $SHELL"'))
            tmux -f <(echo "$tmux_config") new-session && echo "tmux created new session supported OS X"
        else
            tmux new-session && echo "tmux created new session"
        fi
    fi
}

# tmuxx start
# http://qiita.com/items/1e1d3053c33f528363d9
if [ -z $TMUX ]; then
  if $(tmuxx has-session); then
    tmuxx attach
  else
    tmuxx
  fi
fi
