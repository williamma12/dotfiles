#!/bin/bash

cp ~/.vimrc files/vimrc
cp ~/.tmux.conf files/tmux.conf
cp -rf ~/.config/nvim/ files/config/nvim

git commit -a -m 'Update dotfiles'
git push origin master
