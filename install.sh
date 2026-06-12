#!/bin/bash
set -e

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo "🚀 Starting machine setup..."

# ── Xcode CLI Tools ───────────────────────────────────────────────────────────
if ! xcode-select -p &>/dev/null; then
  echo "Installing Xcode CLI tools..."
  xcode-select --install
  echo "Once Xcode CLI tools are installed, re-run this script."
  exit 0
fi

# ── Homebrew ──────────────────────────────────────────────────────────────────
if ! command -v brew &>/dev/null; then
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Add Homebrew to PATH for the rest of this script (Apple Silicon)
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH

echo "Running brew bundle..."
brew bundle --file="$DOTFILES_DIR/Brewfile"

# ── Stow dotfiles ─────────────────────────────────────────────────────────────
echo "Stowing dotfiles..."
mkdir -p "$HOME/.config"
cd "$DOTFILES_DIR"

stow --restow --target="$HOME" zsh
stow --restow --target="$HOME" git
stow --restow --target="$HOME/.config" config

# VS Code keybindings (non-standard path, manual symlink)
VSCODE_USER="$HOME/Library/Application Support/Code/User"
mkdir -p "$VSCODE_USER"
ln -sf "$DOTFILES_DIR/vscode/keybindings.json" "$VSCODE_USER/keybindings.json"

echo "Dotfiles linked."

# ── macOS defaults ────────────────────────────────────────────────────────────
echo "Applying macOS defaults..."
bash "$DOTFILES_DIR/.macos"

# ── mise: Node ────────────────────────────────────────────────────────────────
echo "Setting up mise..."
eval "$(mise activate bash)"

mise install node@lts
mise use --global node@lts
echo "Node $(node -v) ready."

# Uncomment if you need Python on this machine:
# mise install python@latest
# mise use --global python@latest
# echo "Python $(python --version) ready."

# ── Global npm packages ───────────────────────────────────────────────────────
echo "Updating npm..."
npm install -g npm@latest
# Add any globals here as needed

# ── Shell ─────────────────────────────────────────────────────────────────────
if [ "$SHELL" != "/bin/zsh" ]; then
  echo "Setting zsh as default shell..."
  chsh -s /bin/zsh
fi

# ── Private dotfiles ──────────────────────────────────────────────────────────
PRIVATE_DIR="$HOME/dev/dotfiles-private"
if [ -d "$PRIVATE_DIR" ]; then
  echo "Found private dotfiles, running private install..."
  bash "$PRIVATE_DIR/install-private.sh"
else
  echo ""
  echo "⚠️  Private dotfiles not found. Clone and run manually:"
  echo "     gh repo clone davidleininger/dotfiles-private ~/dev/dotfiles-private"
  echo "     bash ~/dev/dotfiles-private/install-private.sh"
fi

echo ""
echo "✅ Core setup complete."
echo ""
echo "⚠️  Manual installs required:"
echo "  - 1Password:  https://1password.com/downloads/mac/"
echo "  - Figma Beta: https://www.figma.com/beta"
echo "  - Loopback:   https://rogueamoeba.com/loopback/"
echo ""
echo "Next steps:"
echo "  - Open a new terminal to load your zsh config"
echo "  - Sign into Dropbox, Notion, Slack, Spotify as needed"
echo "  - On work machines: brew bundle --file=$HOME/dev/dotfiles-private/Brewfile.work"
echo "  - Authenticate gh CLI: gh auth login"
