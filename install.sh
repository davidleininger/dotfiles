#!/bin/bash

# # if they have a .config/fish, kill it
# echo "Installing Oh My ZSH"
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# Get dotfiles installation directory
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -sf "$DOTFILES_DIR/.aliases" ~
ln -sf "$DOTFILES_DIR/.functions" ~
ln -sf "$DOTFILES_DIR/Brewfile" ~
ln -sf "$DOTFILES_DIR/.gitconfig" ~
ln -sf "$DOTFILES_DIR/.gitconfig-dl" ~
ln -sf "$DOTFILES_DIR/.gitconfig-wwt" ~
ln -sf "$DOTFILES_DIR/.gitignore_global" ~
ln -sf "$DOTFILES_DIR/.hyper.js" ~
ln -sf "$DOTFILES_DIR/.zshrc" ~
ln -sf "$DOTFILES_DIR/z.sh" ~
ln -sf "$DOTFILES_DIR/cobalt2.zsh-theme" ~/.oh-my-zsh/custom/themes
ln -sf "$DOTFILES_DIR/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json
