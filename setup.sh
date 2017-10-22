#!/bin/bash

echo "setup command line tools"
xcode-select --install

echo "Setup HomeBrew ..."
type brew 
if [ $? -ne 0 ]; then
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew tap Homebrew/bundle
  cd $HOME/dotfiles
  brew bundle
fi

echo "Link dotfiles"
mkdir -p $HOME/develop/{bin, src}
mkdir -p $HOME/.zsh

dotfiles="zsh/.zshrc zsh/.zshrc.antigen zsh/.zshrc.linux zsh/.zshrc.local zsh/.zshrc.osx tmux/.tmux.conf git/.gitconfig"
for file in $dotfiles
do
	ln -sf $HOME/dotfiles/.config/$file $HOME/`basename $file`
done

ln -s $HOME/dotfiles/.config $HOME/.config 

echo "other Settings"
pip3 install neovim powerline-status
go get -u github.com/nsf/gocode

echo "osx settings"
mv ~/Applications/.localized ~/Applications/.localized.bk
mv ~/Desktop/.localized ~/Desktop/.localized.bk
mv ~/Downloads/.localized ~/Downloads/.localized.bk
mv ~/Public/.localized ~/Public/.localized.bk
mv ~/Pictures/.localized ~/Pictures/.localized.bk
mv ~/Music/.localized ~/Music/.localized.bk
mv ~/Movies/.localized ~/Movies/.localized.bk
mv ~/Documents/.localized ~/Documents/.localized.bk

defaults write NSGlobalDomain InitialKeyRepeat -int 12
defaults write NSGlobalDomain KeyRepeat -int 1



