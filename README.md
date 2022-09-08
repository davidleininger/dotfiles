# Dotfiles

These are my dotfiles. It's for me, using my settings, and it helps me set up new machines for how I work. That said, I stole a lot of this from other people, so feel free to steal from me. I would, however, highly recommend forking this repo and changing my user name to yours to avoid any issues. That will also allow you to add your own customizations and remove any of mine that you don't like. Good luck!

## Getting started
Before we run the install and setup scripts, we need to take care of a few things. So that you can actually run these scripts.

> It's worth noting that this setup is for macOS only and assumes you're using bash or zsh to execute the scripts.

### Initial setup
You need `git` in order to get settings and plugins.

```bash
xcode-select --install
```

After that finishes, you need to run a few other scripts before we can do everything else.

```bash
sudo mkdir -p /usr/local/{bin,lib,include,share}
sudo chown -R $(whoami) /usr/local/{bin,lib,include,share}
```

### 1Password (or something like it)
A password manager is essential to running a machine. One it provided a solid level of security around your info, and two it just makes it easier to get set up. So, download your password manager of choice and sign in to make everything that follows easier.

### Node
Odds are you're going to need [Node.js](https://nodejs.org/en/download) on your machine. Odds are you're a web developer if you're looking at this. Please download and install [Node](https://nodejs.org/en/download) before continuing with the rest of this setup. I'm assuming that you're running the current LTS version or higher moving forward.

### Clone this repo
You'll need a cop of this repo locally on your machine. So now that you have `git`, let's clone some dotfiles. You've got two options here. First navigate to or make your development directory and then clone. For me, I keep everything in `/dev`:

```bash
mkdir dev
cd dev
git clone https://github.com/davidleininger/dotfiles.git
```

## Scripts
Okay, time to really get the ball rolling with scripts. Let's talk about what it will do before we run it. Feel free to take a look in `install.sh` file, but we'll walk through it here.

First, we need to install `oh-my-zsh` and install some plugins (we already have them defined in our zshrc). We'll also make sure zsh is our default shell:

```bash
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
git clone https://github.com/paulirish/git-open ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/git-open
```

Then we'll move to the home directory. We need to get rid of any existing configuration files. Though if you have them you might want to store them somewhere else and bring them back after we're done. Ideally we don't have a ~/.config directory, but if so... you probably need to delete it.

```bash
cd ~
rm -rf ~/.config
```

Now we need to get [Homebrew](https://brew.sh/) up and running. If you already have it, you can run `brew update` instead of installing it. Install with this script:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

You may or may not need to do this, but ever since switching to an M1 Mac, I've needed to add Homebrew to the PATH. If you're following along here, the Homebrew install will give the same info, but you'll need to run this:

```bash
export PATH=/opt/homebrew/bin:$PATH
export PATH=/opt/homebrew/sbin:$PATH
```

Now, we'll use Homebrew Bundle to go through our Bundle file and install a bunch of stuff, but we need to let set up Homebrew to run the bundle.

```bash
brew tap Homebrew/bundle
```

Now that we've got Node and Homebrew up and running, we can install all of the things. First we'll install some global npm modules.

```bash
npm i -g empty-trash-cli fkill-cli np trash-cli convert-color-cli yarn
```

Now we'll install all of the homebrew applications (even Mac App Store applications)

```bash
brew bundle
```

Next we'll stay in the `dotfiles` directory because we've got some local dependencies to install.

```bash
cd ~/dev/dotfiles && npm install
```

### Install script
That is a lot, but, honestly, it only takes a few minutes. If you want, you can run that entire script in order:

```bash
sh ~/dev/dotfiles/install.sh
```

## What did the scripts do?

## Additional setup
Let's get this mac finished setting up. Here are some steps.

### mac-setup.sh
Using the `mac-setup.sh` script you can set your computer up to run just like I want. I think these are good Mac defaults, but you might not like it. Feel free to change it or and/remove stuff as you see fit.

```bash
sh ~/dev/dotfiles/mac-setup.sh
```

### Logins and applications
- You should already have 1Password downloaded, now let's get the browser extension loaded up
- Arc is your favorite browser, so get that bad boy and Logins
- Login to github and do your auth diddy for `gh`
- Download Raycast and get rid of spotlightå
- You know you need Bartender
- Karabiner
- Don't forget your dev fonts (grab them from drobox)

### Tweak your shortcuts
- Copy screenshot to clipboard
- Shottr shortcuts
