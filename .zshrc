# brew install zoxide zsh-syntax-highlighting zsh-autosuggestions

# Zoxide
eval "$(zoxide init --cmd cd zsh)"

# zsh-syntax-highlighting
source $(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# zsh-autosuggestions
source $(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh

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
# Aliases
# -------------------------------- #

alias pr="pnpm run"
alias pi="pnpm install"
alias pun="pnpm uninstall"
alias plx="pnpm dlx"

alias d="pr dev"
alias b="pr build"
alias format="pr format"
alias lint="pr lint"

# -------------------------------- #
# Git
# -------------------------------- #

alias gs="git status"
alias ga="git add"
alias gA="git add -A"
alias gcam="gA && git commit -m"
alias gp="git push"
alias grhh="git reset --hard"

# -------------------------------- #
# pnpm
# -------------------------------- #

export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
