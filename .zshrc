# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="frisk"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git brew autojump ruby rails3 )

source $ZSH/oh-my-zsh.sh

# Customize to your needs...

#=============================
# PATH
#=============================
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin
export DYLD_LIBRARY_PATH=/usr/local/mysql/lib:$DYLD_LIBRARY_PATH
export PATH=$PATH:$HOME/.rbenv/bin
eval "$(rbenv init -)"

#=============================
# Alias
#=============================
alias vi='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias vim='env LANG=ja_JP.UTF-8 /Applications/MacVim.app/Contents/MacOS/Vim "$@"'
alias ls='ls -hal -G -w'
alias ctags='/Applications/MacVim.app/Contents/MacOS/ctags "$@"'

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

#autoload -U predict-on # 先方予測機能
#predict-on

setopt auto_cd
setopt auto_pushd

# --prefix=~/localというように「=」の後でも
#「~」や「=コマンド」などのファイル名展開を行う。
setopt magic_equal_subst

setopt correct # コマンド自動修正
setopt list_packed # 補完候補を詰めて表示
setopt nolistbeep # 補完表示時にビープ音を鳴らさない
setopt complete_aliases # エイリアスを設定したコマンドでも補完機能を使えるようにする
setopt transient_rprompt # コピペしやすいようにコマンド実行後は右プロンプトを消す。
setopt long_list_jobs # 内部コマンド jobs の出力をデフォルトで jobs -l にする
setopt list_types # 補完候補一覧でファイルの種別をマーク表示
setopt complete_in_word # カーソル位置で補完する。
setopt glob_complete # globを展開しないで候補の一覧から補完する。
setopt hist_expand # 補完時にヒストリを自動的に展開する。
setopt no_beep # 補完候補がないときなどにビープ音を鳴らさない。
setopt numeric_glob_sort # 辞書順ではなく数字順に並べる。
setopt rm_star_wait # rm * を実行する前に確認
setopt hist_no_store # history コマンドを history に保存しない
setopt mark_dirs # ファイル名の展開でディレクトリにマッチした場合 末尾に / を付加
setopt no_flow_control # disable C-q, C-s
setopt auto_param_slash # ディレクトリ名の補完で末尾の / を自動的に付加し、次の補完に備える
setopt brace_ccl # {a-c} を a b c に展開する機能を使えるようにする

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

# set terminal title including current directory
#

#
#
case "${TERM}" in
    kterm*|xterm)
        precmd() {
            echo -ne "\033]0;${USER}@${HOST%%.*}:${PWD}\007"
        }
        ;;
esac

#autojump
alias j="autojump"
if [ -f `brew --prefix`/etc/autojump ]; then
  . `brew --prefix`/etc/autojump
fi

