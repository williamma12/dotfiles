#!/bin/bash

# Install HomeBrew
bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install stuff
brew install neovim
brew install tmux
brew install fzf
brew install zsh
brew install chezmoi  # Dotfile manager
brew install ripgrep  # Used for telescope.nvim

# Get hack nerd font
brew tap homebrew/cask-fonts
brew install --cask font-hack-nerd-font

# Install Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
tmux source ~/.tmux.conf
~/.tmux/plugins/tpm/bin/install_plugins

# Install oh-my-zsh and plugins
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

source ~/.zshrc
