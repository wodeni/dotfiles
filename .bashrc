# Jae's ~/.bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history
# and don't put lines starting with space.
HISTCONTROL=ignoredups:ignorespace

# Git status
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

# basic prompt
PS1='\u@\h \w \$ '

sad=":("
happy=":)"
red=$(tput setaf 1)
green=$(tput setaf 2)
yellow=$(tput setaf 3)
blue=$(tput setaf 4)
reset=$(tput sgr0)
# color prompt 
# - see https://wiki.archlinux.org/index.php/Color_Bash_Prompt
# PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[\033[01;31m\]\h'; else echo '\[\033[01;32m\]\u@\h'; fi)\[\033[01;34m\] \w \$([[ \$? != 0 ]] && echo \"\[\033[01;31m\]:(\[\033[01;34m\] \" || echo \"\[\033[01;32m\]:)\[\033[01;34m\] \" )\\$\[\033[00m\] "
PS1="$(if [[ ${EUID} == 0 ]]; then echo '\[$green\]\h'; else echo '\[$green\]\u@\h'; fi)\[$blue\] \w\[$yellow\]\$(parse_git_branch) \$([[ \$? != 0 ]] && echo \"\[$red\]:(\[$blue\] \" || echo \"\[$green\]:)\[$blue\] \" )\\$\[$reset\] "


# show "[hh:mm] user@host:pwd" in xterm title bar
if [ "$TERM_PROGRAM" = "Apple_Terminal" ]; then
    # for Mac Terminal, omit "User@Users-MacBook-Air"
    # and preserve PROMPT_COMMAND set by /etc/bashrc.
    show_what_in_title_bar='"[$(date +%H:%M)] ${PWD/#$HOME/~}"'
    PROMPT_COMMAND='printf "\033]0;%s\007" '"$show_what_in_title_bar; $PROMPT_COMMAND"
else
    show_what_in_title_bar='"[$(date +%H:%M)] ${USER}@${HOSTNAME%%.*}:${PWD/#$HOME/~}"'
    case ${TERM} in
        xterm*|rxvt*|Eterm|aterm|kterm|gnome*)
            PROMPT_COMMAND='printf "\033]0;%s\007" '$show_what_in_title_bar
            ;;
        screen)
            PROMPT_COMMAND='printf "\033_%s\033\\" '$show_what_in_title_bar
            ;;
    esac
fi
unset show_what_in_title_bar

# editor
export EDITOR=vim

# set vi editing mode
set -o vi

# aliases & functions

case "$OSTYPE" in
*linux*)
        alias dmesg='dmesg --color'
        alias pacman='pacman --color=auto'
	alias ls='ls --color=auto'
	;;
*darwin*)
	alias ls='ls -G'
	;;
esac
alias ll='ls -alF'
alias l='ls -CF'
alias c='clear'
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

svndiff()     { svn diff "$@" | colordiff; }
svndiffless() { svn diff "$@" | colordiff | less -R; }

alias gccg='gcc -g -Wall'
alias g++g='g++ -g -Wall'
alias valgrindlc='valgrind --leak-check=yes'

alias graphicdir='cd $GRAPHICDIR'
alias raytradir='cd $RAYTRADIR'
alias notedir='cd ~/Documents/notes/'
alias dropboxdir='cd /Users/niw/Dropbox/'

alias semdir='cd $SEMDIR'
alias osdir="cd /Users/niw/Dropbox/Columbia/2017-Spring/coms-4118"
alias pltdir="cd ~/PLTProject"

# PATH variable
export PATH=$PATH":$HOME/bin"
export SEMDIR="/Users/niw/Dropbox/Columbia/2017-Spring/"
export GRAPHICDIR="/Users/niw/Dropbox/Columbia/2016-Fall/4160/"
export RAYTRADIR="/Users/niw/Dropbox/Columbia/2016-Fall/4160/hw/raytra"


# Powerline
if [ -f /usr/share/powerline/bindings/bash/powerline.sh ]; then
        source /usr/share/powerline/bindings/bash/powerline.sh
    fi
