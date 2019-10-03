#!/bin/bash

cp ~/.vimrc files/vimrc
cp ~/.tmux.conf files/tmux.conf

git commit -a -m 'Update dotfiles'
git push origin master
