ZSH=$HOME/.oh-my-zsh
ZSH_THEME="frisk"

plugins=(git ruby gem brew rails3 node npm git-flow github vi-mode vagrant osx fabric deb compleat rbenv pow powder pip python cpanm)
source $ZSH/oh-my-zsh.sh

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
autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

#=============================
# setopt
#=============================
autoload -U compinit #補完機能
compinit

setopt auto_cd           # 指定したコマンド名がなく、ディレクトリ名と一致した場合 cd する
setopt auto_list         # 補完候補が複数ある時に、一覧表示する
setopt auto_menu         # 補完キー（Tab,  Ctrl+I) を連打するだけで順に補完候補を自動で補完する
setopt auto_param_keys   # カッコの対応などを自動的に補完する
setopt auto_param_slash  # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
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


#Ctrl-x Ctrl-pでクリップボードにコピー
pbcopy-buffer(){ 
    echo $BUFFER | pbcopy
    zle -M "pbcopy: ${BUFFER}" 
}

zle -N pbcopy-buffer
bindkey '^x^p' pbcopy-buffer


