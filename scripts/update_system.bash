#!/bin/bash

# Copy files to system.
cp files/vimrc ~/.vimrc
cp files/tmux.conf ~/.tmux.conf

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall

# Install TmuxPluginManager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins
