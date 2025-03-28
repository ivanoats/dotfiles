export DEBUG=true

export PATH="${PATH}:${HOME}/.local/bin"
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Figure out OS type, Mac or Linux. Strip out version# from Darwin
export OSTYPE_REAL=${OSTYPE//[0-9.]/}

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load

# prompt plugins need this
autoload -Uz promptinit && promptinit && prompt powerlevel10k

# auto complete ..
autoload -U +X bashcompinit && bashcompinit
autoload -U +X compinit && compinit

# Fix multiple users brew
ZSH_DISABLE_COMPFIX=true

COMPLETION_WAITING_DOTS="true"

set -o AUTO_CD

# load up oh my zsh
# taken care of by antidote?
#source $ZSH/oh-my-zsh.sh

# try to make ssh agent work better
zstyle :omz:plugins:ssh-agent agent-forwarding on

# disable ll alias
zstyle ':omz:plugins:*' aliases no
zstyle ':omz:lib:*' aliases no

# use keychain for a long running ssh agent process
# eval `keychain --eval --agents ssh --inherit any id_dsa`

# Java on Linux
if [[ $OSTYPE_REAL == 'linux-gnu' ]]; then
    if [[ -r /usr/local/java ]]; then
        JAVA_HOME=/usr/local/java
        PATH=$PATH:$JAVA_HOME/bin
        JRE_HOME=/usr/local/java
        PATH=$PATH:$JRE_HOME/bin
        export JAVA_HOME
        export JRE_HOME
        export PATH
    fi
fi

# java openjdk on mac
if [[ $OSTYPE_REAL == 'darwin' ]]; then
  export PATH="/usr/local/opt/openjdk/bin:$PATH"
fi

# Paths from cask, any others necessary for mac
if [[ $OSTYPE_REAL == 'darwin' ]]; then
  export PATH=$HOME/.cask/bin:$PATH
fi

# current directory bin PATH
export PATH=./bin:$PATH
# home bin
export PATH=$HOME/bin:$PATH

# Go language
export GOPATH=$HOME/dev/go
PATH=$PATH:/usr/local/go/bin:$GOPATH/bin

# OPAM configuration
. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Cabal configuration
export PATH=$HOME/.cabal/bin:$PATH
  # Requires iterm2

# Serverless Framework
#
# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.zsh
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.zsh
# tabtab source for slss package
# uninstall by removing these lines or running `tabtab uninstall slss`
[[ -f /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh ]] && . /usr/local/lib/node_modules/serverless/node_modules/tabtab/.completions/slss.zsh

# AWS CLI auto completion
if test -f "/usr/local/bin/aws_zsh_completer.sh"; then
  source /usr/local/bin/aws_zsh_completer.sh
fi

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# elixir
export ERL_AFLAGS="-kernel shell_history enabled"

# iterm on mac
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

complete -o nospace -C /usr/local/bin/terraform terraform

iterm2_print_user_vars() {
  iterm2_set_user_var arch $(arch)
}

# PHP including composer on OS X
if [[ $OSTYPE_REAL == 'darwin' ]]; then
    export PATH="$(brew --prefix php)/bin:$PATH"
    export PATH="$HOME/.composer/vendor/bin:$PATH"
    source $HOME/dotfiles/wp-completion.bash
fi

if [[ $OSTYPE_REAL == 'linux-gnu' ]]; then
  # >>> conda initialize >>>
  # !! Contents within this block are managed by 'conda init' !!
  __conda_setup="$('$HOME/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
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
  # <<< conda initialize <<<
fi

# python pipenv on MacOS
if [[ $OSTYPE_REAL == 'darwin' ]]; then
  export PATH="$HOME/Library/Python/3.10/bin:$PATH"
fi

#python pip location on linux
if [[ $OSTYPE_REAL == 'linux-gnu' ]]; then
  export PATH="$HOME/.local/bin:$PATH"
fi

# chruby on linux / WSL or brew ruby on OS X
if [[ $OSTYPE_REAL == 'linux-gnu' ]]; then
  source /usr/local/share/chruby/chruby.sh
fi
if [[ $OSTYPE_REAL == 'darwin' ]]; then
  export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '$HOME/google-cloud-sdk/path.zsh.inc' ]; then . '$HOME/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '$HOME/google-cloud-sdk/completion.zsh.inc' ]; then . '$HOME/google-cloud-sdk/completion.zsh.inc'; fi

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# env vars and aliases
. ~/dotfiles/zsh/env
. ~/dotfiles/zsh/aliases
. ~/dotfiles/zsh/private_keys

unalias ll
alias ll="eza -la -s modified"
alias lo="eza -la -s modified"

[ -f "$HOME/.ghcup/env" ] && source "$HOME/.ghcup/env" # ghcup-env
if [[ $OSTYPE_REAL == 'darwin' ]] {
  source $HOME/.config/broot/launcher/bash/br
}


# NVM - Node Version Manager
export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# my functions path
fpath=($HOME/.zsh/functions $HOME/dotfiles/zsh/functions $fpath)
# Run the above function in ZSH whenever you change directory
autoload -U add-zsh-hook
add-zsh-hook chpwd auto-switch-node-version
auto-switch-node-version

source <(fzf --zsh)

eval "$(zoxide init zsh)"
PATH=~/.console-ninja/.bin:$PATH
