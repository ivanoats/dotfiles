# color terminal
# 1st = username, 2nd = working directory, 3rd = $ prompt, 4th = text-type
#Black 0;30 Dark Gray 1;30
#Blue 0;34 Light Blue 1;34
#Green 0;32 Light Green 1;32
#Cyan 0;36 Light Cyan 1;36
#Red 0;31 Light Red 1;31
#Purple 0;35 Light Purple 1;35
#Brown 0;33 Yellow 1;33
#Light Gray 0;37 White 1;37
#PS1='\[\e[0;37m\]\u\[\e[m\] \[\e[1;37m\]\w\[\e[m\] \[\e[0;35m\]\$ \[\e[m\]\[\e[1;37m\] '

function railsapp {
    template=$1
    appname=$2
    shift 2
    rails $appname -m http://github.com/ryanb/rails-templates/raw/master/$template.rb $@
  }
export PS1='\u@\h:\t:\W> '
alias myip="ifconfig | grep 'inet ' | grep -v 127.0.0.1 | cut -d\   -f2"
alias openports="sudo lsof -i -P | grep -i \"listen\""
alias whoitunes="lsof -r 2 -n -P -F n -c iTunes -a -i TCP@\`hostname\`:3689"
alias ll="ls -ltrahG"
alias ls="ls -G"
#set -o vi   #vi line editing mode 
export PATH=".:/Users/ivan/bin/ImageMagick-6.6.4/bin:/usr/local/bin:/Users/ivan/.gem/ruby/1.8/bin:/usr/local/sbin:/Users/ivan/bin:/Users/ivan/bin/narwhal/bin:/usr/local/mysql/bin:/Developer/usr/bin:$PATH" 
export WWW_HOME=http://www.google.com
export EDITOR="/usr/bin/mate -w"
export JAVA_HOME="/System/Library/Frameworks/JavaVM.framework/Versions/1.5.0/Home"
export LC_CTYPE=en_US.UTF-8
unset HISTFILESIZE
export PROMPT_COMMAND='history -a; echo -ne "\033]0;${USER}@${HOSTNAME%%.*}: ${PWD/#$HOME/~}\007"'
shopt -s histappend
export NARWHAL_ENGINE=jsc
export CAPP_BUILD="/Users/ivan/bin/cappucino"
export GEM_EDITOR="mate"
export CLICOLOR=1
export LSCOLORS=Gxfxcxdxbxegedabagacad
[[ -s $HOME/.rvm/scripts/rvm ]] && source $HOME/.rvm/scripts/rvm

