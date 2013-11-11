# 1. sudo launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist
# 2. sudo /usr/libexec/locate.updatedb
function percol-search-locate() {
    if [ $# -ge 1 ]; then
        DOCUMENT_DIR=$*
    else
        DOCUMENT_DIR=($HOME/Dropbox)
        if [ -d $HOME/Documents ]; then
            DOCUMENT_DIR=($HOME/Documents $DOCUMENT_DIR)
        fi
    fi
    if [ $# -ge 1 ]; then
        SELECTED_FILE=$(locate $* | percol --match-method migemo)
        if [ $? -eq 0 ]; then
            echo $SELECTED_FILE | sed 's/ /\\ /g'
        fi
    else
        bultin locate
    fi
}
zle -N percol-search-locate
bindkey '^xl' percol-search-locate
