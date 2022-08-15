#
# Cobalt2 Theme - https://github.com/wesbos/Cobalt2-iterm
#
# # README
#
# In order for this theme to render correctly, you will need a
# [Powerline-patched font](https://gist.github.com/1595572).
##
### Segment drawing
# A few utility functions to make it easy and re-usable to draw segmented prompts

CURRENT_BG='NONE'
SEGMENT_SEPARATOR=''
RIGHT_SEG_SEP=''
package_path="."

# Begin a segment
# Takes two arguments, background and foreground. Both can be omitted,
# rendering default background/foreground.
prompt_segment() {
  local bg fg
  [[ -n $1 ]] && bg="%K{$1}" || bg="%k"
  [[ -n $2 ]] && fg="%F{$2}" || fg="%f"
  if [[ $CURRENT_BG != 'NONE' && $1 != $CURRENT_BG ]]; then
    echo -n " %{$bg%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR%{$fg%} "
  else
    echo -n "%{$bg%}%{$fg%} "
    # echo $(pwd | sed -e "s,^$HOME,~," | sed "s@\(.\)[^/]*/@\1/@g")
    # echo $(pwd | sed -e "s,^$HOME,~,")
  fi
  CURRENT_BG=$1
  [[ -n $3 ]] && echo -n $3
}

# Node Version
prompt_node() {
  local engine nvm repo_path package_path

  # Get the path of the Git repo, which should have the package.json file
  if repo_path=$(git rev-parse --git-dir 2>/dev/null); then
    if [[ "$repo_path" == ".git" ]]; then
      # If the current path is the root of the project, then the package path is
      # the current directory and we don't want to append anything to represent
      # the path to a subdirectory
      package_path="."
    else
      # If the current path is something else, get the path to the package.json
      # file by finding the repo path and removing the '.git` from the path
      package_path=${repo_path:0:-4}
    fi
  fi

  node_version=${$(node -v)//v}
  if [[ -a $package_path/package.json ]]; then
    engine=${$( jq -e '.engines.node' < "$package_path/package.json")//\"}
  fi
  if [[ -a $package_path/.nvmrc ]]; then
    nvm=${$(cat .nvmrc)}
  fi

  if [[ -a $package_path/package.json || -a $package_path/.nvmrc ]]; then
    if [[ "$engine" != null && "$nvm" != null && "$nvm" != '' ]]; then
      if [[ "$nvm" != *"$node_version"* ]]; then
        echo -n " %{$fg[black]%}$RIGHT_SEG_SEP%{$bg[black]%}%{$fg[yellow]%}$node_version %{$fg[green]%}| $nvm %{$reset_color%}"
      elif [[ "$engine" != *"$node_version"* ]]; then
        echo -n " %{$fg[black]%}$RIGHT_SEG_SEP%{$bg[black]%}%{$fg[yellow]%}$node_version %{$fg[green]%}| $engine %{$reset_color%}"
      else
        echo -n " %{$fg[green]%}$RIGHT_SEG_SEP%{$bg[green]%}%{$fg[black]%}$node_version %{$reset_color%}"
      fi
    elif [[ "$engine" != null ]]; then
      if [[ "$engine" == *"$node_version"* ]]; then
        echo -n " %{$fg[green]%}$RIGHT_SEG_SEP%{$bg[green]%}%{$fg[black]%}$node_version %{$reset_color%}"
      else
        echo -n " %{$fg[black]%}$RIGHT_SEG_SEP%{$bg[black]%}%{$fg[yellow]%}$node_version %{$fg[green]%}| $engine %{$reset_color%}"
      fi
    elif [[ "$nvm" != null && "$nvm" != '' ]]; then
      if [[ "$nvm" == *"$node_version"* ]]; then
        echo -n " %{$fg[green]%}$RIGHT_SEG_SEP%{$bg[green]%}%{$fg[black]%}$node_version %{$reset_color%}"
      else
        echo -n " %{$fg[black]%}$RIGHT_SEG_SEP%{$bg[black]%}%{$fg[yellow]%}$node_version %{$fg[green]%}| $nvm %{$reset_color%}"
      fi
    else
      echo -n " %{$fg[green]%}$RIGHT_SEG_SEP%{$bg[green]%}%{$fg[black]%}$node_version %{$reset_color%}"
    fi
  fi
}

# End the prompt, closing any open segments
prompt_end() {
  if [[ -n $CURRENT_BG ]]; then
    echo -n " %{%k%F{$CURRENT_BG}%}$SEGMENT_SEPARATOR"
  else
    echo -n "%{%k%}"
  fi
  echo -n "%{%f%}"
  CURRENT_BG=''
}

### Prompt components
# Each component will draw itself, and hide itself if no information needs to be shown

# Context: user@hostname (who am I and where am I)
prompt_context() {
  local user=`whoami`

  if [[ "$user" != "$DEFAULT_USER" || -n "$SSH_CLIENT" ]]; then
    prompt_segment black default "%(!.%{%F{yellow}%}.)✝"
  fi
}

# Git: branch/detached head, dirty status
prompt_git() {
  local ref dirty
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    ZSH_THEME_GIT_PROMPT_DIRTY='±'
    dirty=$(parse_git_dirty)
    ref=$(git symbolic-ref HEAD 2> /dev/null) || ref="➦ $(git show-ref --head -s --abbrev |head -n1 2> /dev/null)"
    if [[ -n $dirty ]]; then
      prompt_segment yellow black
    else
      prompt_segment green black
    fi
    echo -n "${ref/refs\/heads\// }$dirty"
  fi
}

# Dir: current working directory
prompt_dir() {
  prompt_segment blue black '%3~'
  # prompt_segment blue black "…${PWD: -30}"
}

# Status:
# - was there an error
# - am I root
# - are there background jobs?
prompt_status() {
  local symbols
  symbols=()
  [[ $RETVAL -ne 0 ]] && symbols+="%{%F{red}%}✘"
  [[ $UID -eq 0 ]] && symbols+="%{%F{yellow}%}⚡"
  [[ $(jobs -l | wc -l) -gt 0 ]] && symbols+="%{%F{cyan}%}⚙"

  [[ -n "$symbols" ]] && prompt_segment black default "$symbols"
}

## Main prompt
build_prompt() {
  RETVAL=$?
  prompt_status
  prompt_context
  prompt_dir
  prompt_git
  prompt_end
}

PROMPT='%{%f%b%k%}$(build_prompt) '
RPROMPT=' $(prompt_node)'
