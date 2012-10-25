#!/bin/bash

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

ln -s $HOME/.vim $HOME/dotfiles/.vim
ln -s $HOME/.oh-my-zsh $HOME/dotfiles/.oh-my-zsh
