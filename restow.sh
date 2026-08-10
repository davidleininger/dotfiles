#!/bin/bash
set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DOTFILES_DIR"

echo "Restowing dotfiles..."
mkdir -p "$HOME/.config"

stow --restow --target="$HOME" zsh
stow --restow --target="$HOME" git
stow --restow --target="$HOME/.config" config

echo "Dotfiles linked."
