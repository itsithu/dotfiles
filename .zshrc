# First make a backup: `cp ~/.zshrc ~/.zshrc.bak`
# then `curl -o ~/.zshrc https://raw.githubusercontent.com/itsithu/dotfiles/refs/heads/main/.zshrc`

# Some parts adapted from https://github.com/antfu/dotfiles

# Zoxide
# `brew install zoxide`
eval "$(zoxide init --cmd cd zsh)"

# zsh-syntax-highlighting
# `brew install zsh-syntax-highlighting``
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-autosuggestions
# `brew install zsh-autosuggestions`
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# -------------------------------- #
# ZSH Prompt with Git Branch
# -------------------------------- #
# -------------------------------- #
# ZSH Prompt with Git Branch
# -------------------------------- #
function parse_git_branch() {
  git rev-parse --abbrev-ref HEAD 2> /dev/null
}

local BLUE="%F{blue}"
local MAGENTA="%F{magenta}"
local GREEN="%F{green}"
local RESET_COLOR="%f"

setopt PROMPT_SUBST

function prompt() {
    local git_branch=$(parse_git_branch)

    if [ -n "$git_branch" ]; then
        PROMPT="${GREEN}%~${RESET_COLOR} ${MAGENTA}(${git_branch})${RESET_COLOR} > "
    else
        PROMPT="${GREEN}%~${RESET_COLOR} > "
    fi
}

precmd_functions+=prompt

# -------------------------------- #
# Deno Package Manager
# -------------------------------- #
# https://github.com/itsithu/di
# `curl -fsSL https://raw.githubusercontent.com/itsithu/di/main/install.sh | sh`

# added by di installer
export PATH="$HOME/.local/bin:$PATH"

alias d="di dev"
alias b="di build"
alias fmt="df"
alias lint="dl"
alias lintf="dl --fix"

# -------------------------------- #
# Git
# -------------------------------- #

# Use github/hub
alias git=hub

# Go to project root
alias grt='cd "$(git rev-parse --show-toplevel)"'

alias gs='git status'
alias gp='git push'
alias gpf='git push --force'
alias gpft='git push --follow-tags'
alias gpl='git pull --rebase'
alias gcl='git clone'
alias gst='git stash'
alias grm='git rm'
alias gmv='git mv'

alias main='git checkout main'

alias gco='git checkout'
alias gcob='git checkout -b'

alias gb='git branch'
alias gbd='git branch -d'

alias grb='git rebase'
alias grbom='git rebase origin/master'
alias grbc='git rebase --continue'

alias gl='git log'
alias glo='git log --oneline --graph'

alias grh='git reset HEAD'
alias grh1='git reset HEAD~1'
alias grhh='git reset --hard HEAD'

alias ga='git add'
alias gA='git add -A'

alias gc='git commit'
alias gcm='git commit -m'
alias gca='git commit -a'
alias gcam='git add -A && git commit -m'
alias gfrb='git fetch origin && git rebase origin/master'

alias gxn='git clean -dn'
alias gx='git clean -df'

alias gsha='git rev-parse HEAD | pbcopy'

alias ghci='gh run list -L 1'

function glp() {
  git --no-pager log -$1
}

function gd() {
  if [[ -z $1 ]] then
    git diff --color | diff-so-fancy
  else
    git diff --color $1 | diff-so-fancy
  fi
}

function gdc() {
  if [[ -z $1 ]] then
    git diff --color --cached | diff-so-fancy
  else
    git diff --color --cached $1 | diff-so-fancy
  fi
}

# -------------------------------- #
# Directories
#
# I put
# `~/i` for my projects
# `~/f` for forks
# `~/r` for reproductions
# -------------------------------- #

function i() {
  cd ~/i/$1
}

function repros() {
  cd ~/r/$1
}

function forks() {
  cd ~/f/$1
}

function pr() {
  if [ $1 = "ls" ]; then
    gh pr list
  else
    gh pr checkout $1
  fi
}

function dir() {
  mkdir $1 && cd $1
}

function clone() {
  if [[ -z $2 ]] then
    hub clone "$@" && cd "$(basename "$1" .git)"
  else
    hub clone "$@" && cd "$2"
  fi
}

# Clone to ~/i and cd to it
function clonei() {
  i && clone "$@" && code . && cd ~2
}

function cloner() {
  repros && clone "$@" && code . && cd ~2
}

function clonef() {
  forks && clone "$@" && code . && cd ~2
}

function codei() {
  i && code "$@" && cd -
}

function serve() {
  if [[ -z $1 ]] then
    live-server dist
  else
    live-server $1
  fi
}
