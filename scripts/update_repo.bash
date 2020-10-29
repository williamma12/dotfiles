#!/bin/bash

cp ~/.vimrc files/vimrc
cp ~/.tmux.conf files/tmux.conf
cp -rf ~/config files/config

git commit -a -m 'Update dotfiles'
git push origin master
