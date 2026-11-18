#!/bin/bash
set -euo pipefail

DOTFILES_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
cd "$DOTFILES_DIR"

echo "Restowing dotfiles..."
mkdir -p "$HOME/.config"

failed=()

restow() {
  local pkg="$1" target="$2"
  # --no-folding: always link individual files, never symlink a whole directory
  # into the repo. A folded directory means anything an app writes to
  # ~/.config/<pkg>/ lands inside this git repo.
  if stow --restow --no-folding --target="$target" "$pkg"; then
    echo "  ✓ $pkg -> $target"
  else
    echo "  ✗ $pkg -> $target (see conflicts above)"
    failed+=("$pkg")
  fi
}

restow zsh    "$HOME"
restow git    "$HOME"
restow config "$HOME/.config"

if (( ${#failed[@]} )); then
  echo
  echo "Failed to stow: ${failed[*]}"
  echo "Move or delete the conflicting file(s) listed above, then re-run."
  echo "To let stow absorb an existing file into the repo instead:"
  echo "  stow --adopt --no-folding --target=<target> <package>   # then: git diff"
  exit 1
fi

echo "Dotfiles linked."
