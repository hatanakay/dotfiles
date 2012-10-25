#!/bin/bash

#git submodule
git submodule init
git submodule update

#symlink
DOT_FILES=( .zsh .zshrc .zshrc.alias .zshrc.linux .zshrc.osx .gemrc .gitconfig .irbrc .pryrc .vimrc .vimrc.bundle .tmux.conf )

for file in ${DOT_FILES[@]}
do  
    if [ -e $HOME/$file ]; then
        unlink $HOME/$file
    fi
    ln -s $HOME/dotfiles/$file $HOME/$file
done

#Directory
if [ -e ~/.vim ]; then
    unlink $HOME/.vim
fi

if [ -e ~/.oh-my-zsh ]; then
    unlink $HOME/.oh-my-zsh
fi

ln -s $HOME/dotfiles/.vim $HOME/.vim
ln -s $HOME/dotfiles/.oh-my-zsh $HOME/.oh-my-zsh
