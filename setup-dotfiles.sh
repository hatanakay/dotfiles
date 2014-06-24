#!/bin/bash

export DOTFILES=".zsh .vim zprofile .zshrc .zshrc.alias .zshrc.osx .zshrc.linux .zshrc.osx .zshrc.antigen .gemrc .gitconfig .irbrc .pryrc .vimrc .vimrc.bundle .tmux.conf .antigen .tmux .peco"

#backup
if [ ! -e ~/dotfiles_backup ]; then
    mkdir ~/dotfiles_backup
    for FILE in ${FILELIST};
    do
        mv ~/${FILE} $HOME/dotfiles_backup/
    done
fi

#link
for dotfile in $DOTFILES
do  
    if [ -e $HOME/$dotfile ]; then
        rm -rf $HOME/$dotfile
    fi
    ln -s $HOME/dotfiles/$dotfile $HOME/$dotfile
done

#git submodule
cd $HOME/dotfiles
git submodule init
git submodule update



#vim
vim +NeoBundleInstall! +qall
