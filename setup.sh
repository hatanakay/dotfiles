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
dotfiles="zsh/.zshrc zsh/.zshrc.antigen zsh/.zshrc.linux zsh/.zshrc.local zsh/.zshrc.osx tmux/.tmux.conf"
for file in $dotfiles
do
	ln -sf $file $HOME/`basename $file`
done

ln -sf $HOME/dotfiles/.config $HOME/.config 


