# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Figure out OS type, Mac or Linux. Strip out version# from Darwin
export OSTYPE_REAL=${OSTYPE//[0-9.]/}

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="robbyrussell"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# auto complete ..
autoload -Uz compinit
compinit

# Fix multiple users brew
ZSH_DISABLE_COMPFIX=true

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
# DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
if [[ $OSTYPE_REAL == 'linux-gnu' ]]; then
    plugins=(git gitfast git-extras docker npm web-search pip)
else # Mac OS X
    plugins=(git zsh-autosuggestions gitfast git-extras osx brew npm mvn node pip redis-cli web-search docker)
fi

# load up oh my zsh
source $ZSH/oh-my-zsh.sh

# try to make ssh agent work better
zstyle :omz:plugins:ssh-agent agent-forwarding on

# use keychain for a long running ssh agent process
#eval `keychain --eval --agents ssh --inherit any id_dsa`

# env vars and aliases
. ~/dotfiles/zsh/env
. ~/dotfiles/zsh/aliases
. ~/dotfiles/zsh/private_keys

# powerline go

function powerline_precmd() {
    PS1="$(~/dev/go/bin/powerline-go -error $? -shell zsh)"
}

function install_powerline_precmd() {
    for s in "${precmd_functions[@]}"; do
        if [ "$s" = "powerline_precmd" ]; then
            return
        fi
    done
    precmd_functions+=(powerline_precmd)
}

if [ "$TERM" != "linux" ]; then
    install_powerline_precmd
fi

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

# Amazon ec2
# if [[ $OSTYPE_REAL == 'darwin' ]]; then
#  export JAVA_HOME="$(/usr/libexec/java_home)"
# fi

# Paths from homebrew, cask, heroku, npm
export PATH=$HOME/.cask/bin:$HOME/bin:/usr/local/share/npm/bin:/usr/local/bin:/usr/local/sbin:$PATH

# chruby
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
    export PATH="/Users/ivan/.composer/vendor/bin:$PATH"
    source /Users/ivan/dotfiles/wp-completion.bash
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
source /usr/local/bin/aws_zsh_completer.sh

# Ruby (from homebrew)
# UPDATE this for each new verison of Ruby installed
export PATH="/usr/local/opt/ruby/bin:/usr/local/lib/ruby/gems/2.7.0/bin:$PATH"

# fnm
export PATH=$HOME/.fnm:$PATH
eval "`fnm env --multi`"

# pyenv
if command -v pyenv 1>/dev/null 2>&1; then
    eval "$(pyenv init -)"
fi

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/__tabtab.zsh ]] && . ~/.config/tabtab/__tabtab.zsh || true

# elixir
export ERL_AFLAGS="-kernel shell_history enabled"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

