# ============================================================================
# INSTANT PROMPT - MUST BE AT TOP
# ============================================================================
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================================
# CORE CONFIGURATION
# ============================================================================
export DEBUG=true
# --- Powerlevel10k Theme ---
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# Path to oh-my-zsh configuration
ZSH=$HOME/.oh-my-zsh

# Figure out OS type: Mac OS (darwin) or linux-gnu (strip version numbers)
OSTYPE_REAL=${OSTYPE//[0-9.]/}

# Fix multiple users brew
ZSH_DISABLE_COMPFIX=true

# ============================================================================
# PLUGIN MANAGEMENT
# ============================================================================
if [[ -f ${ZDOTDIR:-~}/.antidote/antidote.zsh ]]; then
  source ${ZDOTDIR:-~}/.antidote/antidote.zsh
  antidote load
fi

# ============================================================================
# SHELL OPTIONS & COMPLETION
# ============================================================================
# Prompt initialization
autoload -Uz promptinit && promptinit && prompt powerlevel10k

# Enable completions
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

# Show dots while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Enable auto-cd (type directory name to cd into it)
set -o AUTO_CD

# SSH agent configuration
zstyle :omz:plugins:ssh-agent agent-forwarding on

# Disable oh-my-zsh default aliases (we define our own)
zstyle ':omz:plugins:*' aliases no
zstyle ':omz:lib:*' aliases no

# ============================================================================
# PATH CONFIGURATION - BASE PATHS
# ============================================================================
# User's local bin directories
export PATH="${PATH}:${HOME}/.local/bin"
export PATH=$HOME/bin:$PATH
export PATH=./bin:$PATH

# ============================================================================
# OS-SPECIFIC CONFIGURATION
# ============================================================================
if [[ $OSTYPE_REAL == 'darwin' ]]; then
  # macOS-specific paths and configurations
  export PATH="/usr/local/opt/openjdk/bin:$PATH"
  export PATH=$HOME/.cask/bin:$PATH
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
  
  # Only add brew-dependent paths if brew is available
  if command -v brew &> /dev/null; then
    export PATH="$(brew --prefix php)/bin:$PATH"
  fi
  
  export PATH="$HOME/.composer/vendor/bin:$PATH"
  export PATH="$HOME/Library/Python/3.10/bin:$PATH"
  export HOMEBREW_CASK_OPTS="--appdir=$HOME/Applications"
  
  # WordPress completion
  [[ -f $HOME/dotfiles/wp-completion.bash ]] && source $HOME/dotfiles/wp-completion.bash
  
  # broot launcher
  [[ -f $HOME/.config/broot/launcher/bash/br ]] && source $HOME/.config/broot/launcher/bash/br

elif [[ $OSTYPE_REAL == 'linux-gnu' ]]; then
  # Linux-specific paths and configurations
  
  # chruby for Ruby version management (if installed)
  [[ -f /usr/local/share/chruby/chruby.sh ]] && source /usr/local/share/chruby/chruby.sh
  
  # Java configuration
  if [[ -r /usr/local/java ]]; then
    export JAVA_HOME=/usr/local/java
    export JRE_HOME=/usr/local/java
    export PATH=$PATH:$JAVA_HOME/bin:$JRE_HOME/bin
  fi
  
  # Conda initialization
  if [[ -f "$HOME/miniconda3/bin/conda" ]]; then
    __conda_setup="$("$HOME/miniconda3/bin/conda" 'shell.zsh' 'hook' 2> /dev/null)"
    if [ $? -eq 0 ]; then
        eval "$__conda_setup"
    else
        if [ -f "$HOME/miniconda3/etc/profile.d/conda.sh" ]; then
            . "$HOME/miniconda3/etc/profile.d/conda.sh"
        else
            export PATH="$HOME/miniconda3/bin:$PATH"
        fi
    fi
    unset __conda_setup
  fi
fi

# ============================================================================
# LANGUAGE RUNTIMES & TOOLS
# ============================================================================

# --- Go ---
export GOPATH=$HOME/dev/go
PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# --- OCaml (OPAM) ---
. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# --- Haskell (Cabal & GHCup) ---
export PATH=$HOME/.cabal/bin:$PATH
[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env"

# --- Elixir ---
export ERL_AFLAGS="-kernel shell_history enabled"

# --- Node.js (NVM, Bun, pnpm) ---
# NVM - Node Version Manager
export NVM_DIR="$HOME/.nvm"
if [[ $OSTYPE_REAL == 'darwin' ]]; then
  # macOS with Homebrew
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"
else
  # Linux or standard installation
  [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
  [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi

# Bun runtime
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# pnpm package manager
if [[ $OSTYPE_REAL == 'darwin' ]]; then
  export PNPM_HOME="$HOME/Library/pnpm"
else
  export PNPM_HOME="$HOME/.local/share/pnpm"
fi
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# ============================================================================
# CLOUD & INFRASTRUCTURE TOOLS
# ============================================================================

# --- AWS CLI ---
if test -f "/usr/local/bin/aws_zsh_completer.sh"; then
  source /usr/local/bin/aws_zsh_completer.sh
fi

# --- Google Cloud SDK ---
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi

# --- Terraform ---
complete -o nospace -C /usr/local/bin/terraform terraform

# --- Serverless Framework ---
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh

# --- Generic tabtab completions ---
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# ============================================================================
# DEVELOPMENT TOOLS & UTILITIES
# ============================================================================

# --- iTerm2 Integration (macOS) ---
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

iterm2_print_user_vars() {
  iterm2_set_user_var arch $(arch)
}

# --- Console Ninja ---
PATH=~/.console-ninja/.bin:$PATH

# --- fzf (fuzzy finder) ---
if command -v fzf &> /dev/null; then
  source <(fzf --zsh)
fi

# --- zoxide (smart cd) ---
if command -v zoxide &> /dev/null; then
  eval "$(zoxide init zsh)"
fi

# ============================================================================
# CUSTOM FUNCTIONS
# ============================================================================
# Add custom functions directory to fpath
fpath=($HOME/.zsh/functions $HOME/dotfiles/zsh/functions $fpath)

# Auto-switch Node version when changing directories
autoload -U add-zsh-hook
add-zsh-hook chpwd auto-switch-node-version
auto-switch-node-version

# ============================================================================
# CUSTOM ENVIRONMENT, ALIASES & PRIVATE KEYS
# ============================================================================
[[ -f ~/dotfiles/zsh/env ]] && . ~/dotfiles/zsh/env
[[ -f ~/dotfiles/zsh/aliases ]] && . ~/dotfiles/zsh/aliases
[[ -f ~/dotfiles/zsh/private_keys ]] && . ~/dotfiles/zsh/private_keys

# Override oh-my-zsh ll alias with eza
unalias ll
alias ll="eza -la -s modified"
alias lo="eza -la -s modified"
