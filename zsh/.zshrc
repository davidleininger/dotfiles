# ── Homebrew ──────────────────────────────────────────────────────────────────
eval "$(/opt/homebrew/bin/brew shellenv)"

# ── Path ──────────────────────────────────────────────────────────────────────
export PATH="$HOME/.npm-global/bin:$PATH"
export PATH="$HOME/.local/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ── Shell options ──────────────────────────────────────────────────────────────
unsetopt PROMPT_SP

# ── Window title ───────────────────────────────────────────────────────────────
DISABLE_AUTO_TITLE="true"
function precmd() {
  echo -ne "\033]0;✝ ${PWD/$HOME/~}\007"
}

# ── Source extras ──────────────────────────────────────────────────────────────
for file in "$HOME"/.{extras,exports,aliases,functions}; do
  [ -r "$file" ] && source "$file"
done
unset file

# ── Private env ────────────────────────────────────────────────────────────────
[ -f "$HOME/.env" ] && source "$HOME/.env"

# ── Ghostty cursor fix ────────────────────────────────────────────────────────
zle-line-init() { echo -ne "\e[2 q" }
zle -N zle-line-init

# ── Tools ─────────────────────────────────────────────────────────────────────
eval "$(zoxide init zsh)"
eval "$(direnv hook zsh)"
eval "$(mise activate zsh)"
eval "$(starship init zsh)"

# ── Plugins ───────────────────────────────────────────────────────────────────
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
