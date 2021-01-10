#!/bin/bash
###########################################################################
##-------------------------#_Terminal  Aliases_#-------------------------##
###########################################################################
if [  darwinup ]; then 
    alias aptse='aptitude search'
    alias aptin='sudo apt-get install'
fi;
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias .....="cd ../../../../.."
alias ......="cd ../../../../../.."




###########################################################################
##----------------------------#_Git Aliases_#----------------------------##
###########################################################################
alias g='git'
alias ga='git add'
alias gc='git commit -m'
alias gca='git commit --amend'
alias gst='git status'
alias gch='git checkout'
alias gbr='git branch'
alias gpu='git fetch'
alias gpuu='git fetch upstream'
alias gpu='git pull'
alias gpuu='git pull upstream'
alias gp='git push'

#Git Flow
alias gfl='git flow'
alias gflf='git flow feature'	
alias gflfs='git flow feature start'
alias gflff='git flow feature finish'
alias gflh='git flow hotfix'
alias gflhs='git flow hotfix start'
alias gflhf='git flow hotfix finish'
alias gflr='git flow release'
alias gflrs='git flow release start'
alias gflrf='git flow release finish'



############################################################################

alias ssh-add='ssh-add -t 4h'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'
