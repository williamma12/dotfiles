#!/bin/bash

# Copy files to system.
cp files/vimrc ~/.vimrc
cp files/tmux.conf ~/.tmux.conf
cp -rf files/config ~/.config

# Install vim-plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
vim +PlugInstall +qall
vim +CocInstall coc-json coc-tsserver +qall

# Install vim-plug for nvim
sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
nvim +PlugInstall +qall
nvim +CocInstall coc-json coc-tsserver +qall

# Install TmuxPluginManager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
~/.tmux/plugins/tpm/bin/install_plugins
