#!/bin/bash

# install zsh and zsh plugins
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/paulirish/git-open ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-open

# Remove old config files
# cd ~
# rm -rf ~/.config

# got some things to do in dotfiles
cd ~/dev/dotfiles

# Get dotfiles installation directory
DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

ln -sf "$DOTFILES_DIR/.aliases" ~
ln -sf "$DOTFILES_DIR/.functions" ~
ln -sf "$DOTFILES_DIR/Brewfile" ~
ln -sf "$DOTFILES_DIR/.gitconfig" ~
ln -sf "$DOTFILES_DIR/.gitconfig-dl" ~
ln -sf "$DOTFILES_DIR/.gitconfig-nyt" ~
ln -sf "$DOTFILES_DIR/git" ~/.config/git
ln -sf "$DOTFILES_DIR/kitty" ~/.config/kitty
ln -sf "$DOTFILES_DIR/karabiner.json" ~/.config/karabiner
ln -sf "$DOTFILES_DIR/.hushlogin" ~
ln -sf "$DOTFILES_DIR/.gitignore_global" ~
ln -sf "$DOTFILES_DIR/.hyper.js" ~
ln -sf "$DOTFILES_DIR/.zshrc" ~
ln -sf "$DOTFILES_DIR/z.sh" ~
ln -sf "$DOTFILES_DIR/leininger.zsh-theme" ~/.oh-my-zsh/custom/themes
ln -sf "$DOTFILES_DIR/keybindings.json" ~/Library/Application\ Support/Code/User/keybindings.json

# back to root
cd ~

# Get homebrew and bring that badboy in
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add homebrew to PATH
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH

# Do the homebrew bundle stuff
brew tap Homebrew/bundle

# Install global npm modules that we'll need
npm i -g empty-trash-cli fkill-cli np trash-cli convert-color-cli yarn

# install homebrew applications
brew bundle

# finally go back to dotfiles and npm install
cd ~/dev/dotfiles
npm install

# reload zsh
source ~/.zshrc
