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

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
DISABLE_LS_COLORS="true"

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
  plugins=(gitfast git-extras ruby docker rake nvm npm web-search pip)
else # Mac OS X
  plugins=(zsh-autosuggestions gitfast git-extras osx ruby brew rake npm mvn node nvm pip redis-cli web-search gem docker)
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

# powerline
if [[ $OSTYPE_REAL == 'linux-gnu' ]]; then
  if [ -d "$HOME/.local/bin" ]; then
    PATH="$HOME/.local/bin:$PATH"
  fi
  if [[ -r ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
    source ~/.local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
  fi
  if [[ -r /usr/local/java ]]; then
    JAVA_HOME=/usr/local/java
    PATH=$PATH:$JAVA_HOME/bin
    JRE_HOME=/usr/local/java
    PATH=$PATH:$JRE_HOME/bin
    export JAVA_HOME
    export JRE_HOME
    export PATH
  fi
else # Mac OS X
  # if powerline is in ~/Library
  if [[ -r ~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
    source ~/Library/Python/2.7/lib/python/site-packages/powerline/bindings/zsh/powerline.zsh
    export PATH=$PATH:/Users/ivan/Library/Python/2.7/bin
  fi
  # or powerline is in /usr/local
  if [[ -r /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh ]]; then
    source /usr/local/lib/python2.7/site-packages/powerline/bindings/zsh/powerline.zsh
  fi
fi

# Amazon ec2
if [[ $OSTYPE_REAL == 'darwin' ]]; then
  export JAVA_HOME="$(/usr/libexec/java_home)"
fi

# git-core
if [[ $OSTYPE_REAL == 'darwin' ]]; then
  export PATH=$PATH:/usr/local/Cellar/git/latest/libexec/git-core
fi

# Paths from homebrew, cask, heroku, npm
export PATH=$HOME/.cask/bin:$HOME/bin:/usr/local/heroku/bin:/usr/local/share/npm/bin:/usr/local/bin:/usr/local/sbin:$PATH

# chruby
if [[ $OSTYPE_REAL == 'darwin' ]]; then
  source /usr/local/opt/chruby/share/chruby/chruby.sh
else # linux
  source /usr/local/share/chruby/chruby.sh
fi

# current directory bin PATH
export PATH=./bin:$PATH

# Go language
export GOPATH=$HOME/dev/go
PATH=$PATH:$GOPATH/bin

# added by travis gem
[ -f $HOME/.travis/travis.sh ] && source $HOME/.travis/travis.sh

# lunchy on betula to stop services not used
 if [[ $OSTYPE_REAL == 'darwin' && `hostname` == 'betula' ]]; then
   if [[ $(lunchy status redis | grep -q 0) ]]; then
     lunchy stop redis
   fi
   lunchy stop mariadb &> /dev/null
   lunchy stop mongodb &> /dev/null
   lunchy stop dynamodb &> /dev/null
 fi

if [[ $OSTYPE_REAL == 'darwin' ]]; then
  LUNCHY_DIR=$(dirname `gem which lunchy`)/../extras
  if [ -f $LUNCHY_DIR/lunchy-completion.zsh ]; then
    . $LUNCHY_DIR/lunchy-completion.zsh
  fi
fi

# Node Version Manager (NVM)
export NVM_DIR=~/.nvm
if [[ $OSTYPE_REAL == 'darwin' ]]; then
  source $(brew --prefix nvm)/nvm.sh
  eval "`npm completion`"
fi

if [[ $OSTYPE_REAL == 'linux-gnu' ]]; then
  source $HOME/.nvm/nvm.sh
  [[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
fi

# Autoenv
if [[ $OSTYPE_REAL == 'darwin' ]]; then
  source $(brew --prefix autoenv)/activate.sh
fi

if [[ $OSTYPE_REAL == 'linux-gnu' ]]; then
  source `which activate.sh`
fi

# Elm on linux
if [[ $OSTYPE_REAL == 'linux-gnu' ]]; then
  export ELM_HOME='/home/ivan/.nvm/versions/node/v4.2.1/lib/node_modules/elm/share'
fi

# OPAM configuration
. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Cabal configuration
export PATH=$HOME/.cabal/bin:$PATH

# fortune


# tabtab source for yo package
# uninstall by removing these lines or running `tabtab uninstall yo`
[[ -f /Users/ivan/.nvm/versions/node/v6.3.0/lib/node_modules/yo/node_modules/tabtab/.completions/yo.zsh ]] && . /Users/ivan/.nvm/versions/node/v6.1.0/lib/node_modules/yo/node_modules/tabtab/.completions/yo.zsh
