#!/bin/bash

cp ~/.vimrc files/vimrc
cp ~/.tmux.conf files/tmux.conf
cp ~/.config/nvim/ files/config/nvim
cp ~/.config/bash/ files/config/bash

git commit -a -m 'Update dotfiles'
git push origin master
