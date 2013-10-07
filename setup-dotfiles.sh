#!/bin/bash

symlink
DOT_FILES=( .zsh .zshrc .zshrc.alias .zshrc.linux .zshrc.osx .zshrc.antigen .gemrc .gitconfig .irbrc .pryrc .vimrc .vimrc.bundle .tmux.conf )

for file in ${DOT_FILES[@]} do  
    if [ -e $HOME/$file ]; then
        unlink $HOME/$file
    fi
    ln -s $HOME/dotfiles/$file $HOME/$file
done

#Directory
if [ -d $HOME/.vim ]; then
    unlink $HOME/.vim
fi

if [ -d $HOME/.antigen ]; then
    unlink $HOME/.antigen
fi

if [ -d $HOME/.zsh ]; then
    unlink $HOME/.zsh
fi

#git submodule
git submodule init
git submodule update

ln -s $HOME/dotfiles/.vim $HOME/.vim
ln -s $HOME/dotfiles/.zsh $HOME/.zsh
ln -s $HOME/dotfiles/.antigen $HOME/.antigen
