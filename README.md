# dotfiles

Personal dotfiles for macOS. Managed with [Stow](https://www.gnu.org/software/stow/), [Homebrew](https://brew.sh/), and [mise](https://mise.jdx.dev/).

> A private companion repo (`dotfiles-private`) holds sensitive credentials, licensed fonts, and work-specific config. Clone both for a complete setup.

---

## Structure

```
dotfiles/
  zsh/
    .zshrc
    .aliases
    .functions
    .hushlogin
  git/
    .gitconfig
    .gitignore_global
  config/
    ghostty/
      config
      themes/
        cobalt-next
    herdr/
      config.toml
    karabiner/
      karabiner.json
    mise/
      config.toml
    starship/
      starship.toml
  vscode/
    keybindings.json
  scripts/
    getip
    empty-trash
  Brewfile
  install.sh
  .macos
  README.md
```

---

## Fresh Machine Setup

### 1. Prerequisites

Install Xcode CLI tools first. The `install.sh` script will prompt and exit if they're missing — just re-run after installation completes.

```bash
xcode-select --install
```

### 2. Clone both repos

```bash
mkdir -p ~/dev
git clone https://github.com/davidleininger/dotfiles ~/dev/dotfiles
gh repo clone davidleininger/dotfiles-private ~/dev/dotfiles-private
```

> Note: `gh` won't be available until after Homebrew runs. Clone the public repo with `git`, then authenticate `gh` after setup and clone the private repo.

### 3. Run the install script

```bash
cd ~/dev/dotfiles
bash install.sh
```

This will:
- Install Homebrew if not present
- Run `brew bundle` from the Brewfile
- Stow all dotfiles to their correct locations
- Apply macOS defaults via `.macos`
- Install Node LTS via mise
- Set zsh as the default shell

### 4. Run private install

```bash
# Personal machine
bash ~/dev/dotfiles-private/install-private.sh

# Work machine (also installs Brewfile.work)
bash ~/dev/dotfiles-private/install-private.sh --work
```

### 5. Manual installs

These aren't available via Homebrew and need to be installed manually:

| App | URL |
|---|---|
| 1Password | https://1password.com/downloads/mac/ |
| Figma Beta | https://www.figma.com/beta |
| Loopback | https://rogueamoeba.com/loopback/ |

### 6. Authenticate

```bash
gh auth login       # GitHub CLI
```

Then sign into Dropbox, Notion, Slack, and Spotify as needed.

---

## What's Installed

### CLI Tools
| Tool | Purpose |
|---|---|
| `bat` | Better `cat` with syntax highlighting |
| `direnv` | Per-directory environment variables |
| `ffmpeg` | Video/audio processing |
| `gh` | GitHub CLI |
| `git-lfs` | Git large file storage |
| `jq` | JSON parsing and manipulation |
| `mise` | Runtime version manager (Node, Python) |
| `pnpm` | Fast, disk-efficient package manager |
| `ripgrep` | Fast recursive search |
| `starship` | Shell prompt |
| `stow` | Symlink manager for dotfiles |
| `trash-cli` | Safer `rm` — moves to Trash instead of deleting |
| `yt-dlp` | YouTube and video downloader |
| `zoxide` | Smarter `cd` with frecency |

### Apps
BetterTouchTool, Bruno, CleanShot, Deskpad, Dropbox, Elgato Wave Link, Ghostty, Kap, Karabiner-Elements, Keycastr, Notion, Polypane, Raycast, Slack, Spotify, Thaw, Visual Studio Code, Zoom

### Mac App Store
Aware, Boop, ColorSlurp, Get Plain Text, GetIpsum, Hand Mirror

---

## Stow Packages

Stow mirrors each package folder into the target directory. On a machine that's already set up, pull the latest changes and re-link everything with:

```bash
cd ~/dev/dotfiles
bash restow.sh
```

`restow.sh` just runs:

```bash
stow --restow --target="$HOME" zsh
stow --restow --target="$HOME" git
stow --restow --target="$HOME/.config" config
```

`install.sh` calls this same script, so there's one source of truth for the stow commands.

Note: `--restow` fails if a target path already exists as a real file/directory instead of a symlink (e.g. a config file that predates being added to this repo). Resolve the conflict — move the real file's contents into the matching path under `dotfiles/config/` (or delete it if it's just a stale copy) — then re-run `restow.sh`.

VS Code keybindings use a non-standard path and are handled via a manual symlink in `install.sh`.

---

## Runtime Management

Node is managed via [mise](https://mise.jdx.dev/). After install:

```bash
mise install node@lts
mise use --global node@lts
```

Per-project versions are set via `.mise.toml` or existing `.nvmrc` / `.node-version` files — mise reads all of them automatically.

To add Python when needed:

```bash
mise install python@latest
mise use --global python@latest
```

---

## Shell Prompt

Prompt is powered by [Starship](https://starship.rs/) with a custom Cobalt Next theme. Config lives at `config/starship/starship.toml`.

Two-line layout:
```
† ~/dev/dotfiles  main ±  ⬡ 22.13.1  09:41
❯
```

- **Blue** — current directory
- **Yellow** — dirty branch
- **Green** — clean branch / Node version
- **Purple** — branch ahead of remote
- **Red** — branch behind remote

---

## Ghostty Theme

A standalone Cobalt Next theme for [Ghostty](https://ghostty.org/) lives at `config/ghostty/themes/cobalt-next`. The main Ghostty config references it by name:

```ini
theme = cobalt-next
```

---

## macOS Defaults

`.macos` applies sensible defaults for Finder, Dock, keyboard, screenshots, and Safari. Run manually or via `install.sh`:

```bash
bash .macos
```

Notable settings:
- Dock auto-hides instantly
- Screenshots save as PNG to Desktop
- Finder defaults to Home directory
- Fast keyboard repeat rate
- Full keyboard access in dialogs

---

## Private Companion Repo

`dotfiles-private` holds everything that can't be public:

- Licensed fonts (Operator Mono for Powerline)
- Git identity configs (`.gitconfig-dl`, `.gitconfig-nyt`)
- SSH config
- Private environment variables and credentials
- Work Brewfile (`Brewfile.work`)

See the [dotfiles-private README](https://github.com/davidleininger/dotfiles-private) for setup instructions.
