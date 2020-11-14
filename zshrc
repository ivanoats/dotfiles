# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Fix multiple users brew, must be before oh my zsh is loaded
ZSH_DISABLE_COMPFIX="true"

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Figure out OS type, Mac or Linux. Strip out version# from Darwin
export OSTYPE_REAL=${OSTYPE//[0-9.]/}

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="powerlevel10k/powerlevel10k"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

source $HOME/dotfiles/zsh/antigen.zsh
antigen use oh-my-zsh
antigen bundle git
antigen bundle gitfast
antigen bundle git-extras
antigen bundle docker
antigen bundle npm
antigen bundle node
antigen bundle pip
antigen bundle web-search
antigen bundle asdf
antigen bundle zsh-users/zsh-completions
antigen bundle zsh-users/zsh-autosuggestions
antigen bundle zsh-users/zsh-syntax-highlighting
antigen bundle "MichaelAquilina/zsh-auto-notify"

if [[ $OSTYPE_REAL == 'darwin' ]]; then
  antigen bundle osx
  antigen bundle brew
fi
antigen apply

# Zsh completions on MacOS
if [[ $OSTYPE_REAL == 'darwin' ]]; then
  if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH
  fi
fi
# auto complete ..
autoload -Uz compinit
compinit -i # needs -i to remove security warning

# Fix multiple users brew
ZSH_DISABLE_COMPFIX=true

COMPLETION_WAITING_DOTS="true"

# load up oh my zsh
source $ZSH/oh-my-zsh.sh

# try to make ssh agent work better
zstyle :omz:plugins:ssh-agent agent-forwarding on

# use keychain for a long running ssh agent process
# eval `keychain --eval --agents ssh --inherit any id_dsa`

# env vars and aliases
. ~/dotfiles/zsh/env
. ~/dotfiles/zsh/aliases
. ~/dotfiles/zsh/private_keys

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

# jenv (Java Environment)
#if [[ $OSTYPE_REAL == 'darwin' ]]; then
#  if which jenv > /dev/null; then eval "$(jenv init -)"; fi
#fi

# java openjdk on mac
if [[ $OSTYPE_REAL == 'darwin' ]]; then
  export PATH="/usr/local/opt/openjdk/bin:$PATH"
fi

# Paths from cask, any others necessary for mac
if [[ $OSTYPE_REAL == 'darwin' ]]; then
  export PATH=$HOME/.cask/bin:$PATH
fi

# chruby - using asdf now
# if [[ $OSTYPE_REAL == 'darwin' ]]; then
#   source /usr/local/opt/chruby/share/chruby/chruby.sh
# else # linux
#   source /usr/local/share/chruby/chruby.sh
# fi
# chruby ruby

# help install sharp, needed for Gatsby, on Mac OS X with homebrew installing the vips package
if [[ $OSTYPE_REAL == 'darwin' ]]; then
    export PKG_CONFIG_PATH="/usr/local/opt/libffi/lib/pkgconfig"
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

# PHP including composer on OS X
if [[ $OSTYPE_REAL == 'darwin' ]]; then
    export PATH="$(brew --prefix php)/bin:$PATH"
    export PATH="$HOME/.composer/vendor/bin:$PATH"
    source $HOME/dotfiles/wp-completion.bash
fi

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

# Ruby (from homebrew) now managed by asdf
# UPDATE this for each new verison of Ruby installed
#if [[ $OSTYPE_REAL == 'darwin' ]]; then
#    export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.7.0/bin:$PATH"
#fi

# pyenv now managed by asdf
#if command -v pyenv 1>/dev/null 2>&1; then
#    eval "$(pyenv init -)"
#fi

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# elixir
export ERL_AFLAGS="-kernel shell_history enabled"

# iterm on mac
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

# no longer using volta until next version, using asdf now
# export VOLTA_HOME="$HOME/.volta"
# export PATH="$VOLTA_HOME/bin:$PATH"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

autoload -U +X bashcompinit && bashcompinit
complete -o nospace -C /usr/local/bin/terraform terraform
