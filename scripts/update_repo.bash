#!/bin/bash

cp ~/.vimrc files/vimrc
cp ~/.tmux.conf files/tmux.conf
cp -rf ~/.config/nvim/ files/config/nvim
cp -rf ~/.config/bash/ files/config/bash

git commit -a -m 'Update dotfiles'
git push origin master
