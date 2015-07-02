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
  plugins=(gitfast git-extras ruby knife vagrant docker rake nvm npm web-search pip)
else # Mac OS X
  plugins=(gitfast git-extras osx ruby knife brew vagrant rake cloudapp npm web-search mvn node npm nvm pip redis-cli web-search gem docker bower)
fi

# load up oh my zsh
source $ZSH/oh-my-zsh.sh

# try to make ssh agent work better
zstyle :omz:plugins:ssh-agent agent-forwarding on

# set 4.2 to the default gcc since I only compile shit for rubygems
#export CC=/usr/bin/gcc-4.2

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

/bin/ls $HOME/.ec2/pk-*.pem >/dev/null 2>/dev/null
if [[ $? -lt 1 ]]; then
  export EC2_PRIVATE_KEY="$(/bin/ls "$HOME"/.ec2/pk-*.pem | /usr/bin/head -1)"
  export EC2_CERT="$(/bin/ls "$HOME"/.ec2/cert-*.pem | /usr/bin/head -1)"
  if [[ $OSTYPE_REAL == 'darwin' ]]; then
    export EC2_HOME="/usr/local/Library/LinkedKegs/ec2-api-tools/jars"
  fi
fi

# git-core
if [[ $OSTYPE_REAL == 'darwin' ]]; then
  export PATH=$PATH:/usr/local/Cellar/git/latest/libexec/git-core
fi

# Customize to your needs...
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
  lunchy stop mariadb
  lunchy stop mongodb
fi

# Node Version Manager (NVM)
export NVM_DIR=~/.nvm
if [[ $OSTYPE_REAL == 'darwin' ]]; then
  source $(brew --prefix nvm)/nvm.sh
  [[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
fi

if [[ $OSTYPE_REAL == 'linux-gnu' ]]; then
  source $HOME/.nvm/nvm.sh
  [[ -r $NVM_DIR/bash_completion ]] && . $NVM_DIR/bash_completion
fi

# OPAM configuration
. $HOME/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

# Cabal configuration
export PATH=$HOME/.cabal/bin:$PATH
