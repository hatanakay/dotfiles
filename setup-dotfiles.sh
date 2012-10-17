#!/bin/bash

DOT_FILES=( .zsh .zshrc .zshrc.alias .zshrc.linux .zshrc.osx .gemrc .gitconfig .irbrc .pryrc .vimrc .vimrc.bundle .tmux.conf )

for file in ${DOT_FILES[@]}
do
    ln -s $HOME/dotfiles/$file $HOME/$file
done

