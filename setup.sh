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
	ln -sf $file $HOME/`basename $file`
done

ln -sf $HOME/dotfiles/.config $HOME/.config 
ln -sf $HOME/dotfiles/.config/zsh/.antigen $HOME/.antigen 
ln -sf $HOME/dotfiles/.config/zsh/.auto-fu.zsh $HOME/.auto-fu.zsh

echo "other Settings"
pip3 install neovim
go get github.com/monochromegane/mdt/...