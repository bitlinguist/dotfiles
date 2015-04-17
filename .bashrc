# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

export ENV='development'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Bash profile
source ~/.bash-settings/.bash_profile
for file in ~/.bash-scripts/*.sh
do . $file
done

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash-settings/.bash_aliases ]; then
    . ~/.bash-settings/.bash_aliases
fi

# Fix git completion - http://29a.ch/2013/8/9/fixing-bash-autocomplete-on-ubuntu-13-04

#disable these two lines due to unresolved error
#source /usr/share/bash-completion/completions/git
#complete -o default -o nospace -F _git g

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

#function parse_git_branch() {
#  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
#}

#YELLOW="\[\033[0;33m\]"
#CLEAR="\[\033[0m\]"

#export PS1="\[\e]0;\u@\h: \W\a\]${debian_chroot:+($debian_chroot)}\u@\h:\W$YELLOW$(parse_git_branch)$CLEAR$ "

LTGREEN="\[\033[40;1;32m\]"
LTBLUE="\[\033[40;1;34m\]"
CLEAR="\[\033[0m\]"
GRAY2="\[\033[40;1;30m\]"
LIGHT_GRAY="\[\033[40;1;33m\]"

NORMAL='\[\033[0m\]'
BLUE='\[\033[34;01m\]'
CYAN='\[\033[36;01m\]'
GREEN='\[\033[32;01m\]'
RED='\[\033[31m\]'
GRAY='\[\033[37;01m\]'
YELLOW='\[\033[33;01m\]'

# show branch and dirty status
function minutes_since_last_commit {
  local NOW=`date +%s`
  local LAST_COMMIT=`git log --pretty=format:'%at' -1`
  local SECONDS_SINCE_LAST_COMMIT=$((NOW-LAST_COMMIT))
  local MINUTES_SINCE_LAST_COMMIT=$((SECONDS_SINCE_LAST_COMMIT/60))
  echo $MINUTES_SINCE_LAST_COMMIT
}

function git_history_graph {
  # Include --author to limit to one person: --author "Tristan Harward"
  for hour in $(seq 8 -1 0); do git log --before="${hour} hours" --after="$[${hour}+1] hours" --format=oneline | wc -l; done
}

function minutes_with_color {
  local G="$(__gitdir)"
  if [ -n "$G" ]; then
    local MINUTES=`minutes_since_last_commit`
    if [ "$MINUTES " -gt 120 ]; then
        local COLOR=${RED}
    elif [ "$MINUTES" -gt 30 ]; then
        local COLOR=${YELLOW}
    else
        local COLOR=${GREEN}
    fi
    local SINCE_LAST_COMMIT="|${COLOR}${MINUTES}m${NORMAL}|${COLOR}$(git_history_graph) ${NORMAL}"
    echo ${SINCE_LAST_COMMIT}
  fi
}

function parse_git_dirty {
  [[ $(git status 2> /dev/null | tail -n1) != "nothing to commit, working directory clean" ]]
}

function parse_git_branch {
  local BRANCH=$(__git_ps1 "%s$(minutes_with_color)")
  [[ $BRANCH ]] && echo " [$BRANCH$(parse_git_dirty)]"
}


function change_title () {
  echo -ne "\033]0;bitlinguist bash\007"
}


if [ -f ~/Projects/github/z/z.sh ];then
  . ~/Projects/github/z/z.sh
fi

function say() {
  espeak -v en "$1" --stdout | paplay
}

function gitmergedev() {
  if [ ! -d .git ]; then
    git rev-parse --git-dir 2> /dev/null
  if [ $? -ne 0 ];then
      echo 'Not in GIT directory.'
      return 1
  fi
    fi

    local branch="$1"
    if [ -z "$branch" ];then
  branch="staging"
    fi

    git show-ref --verify --quiet refs/heads/$branch
    if [ $? -ne 0 ];then
  echo "Branch $branch doesn't exist."
  return 1
    fi

    git co $branch
    git merge --no-ff dev
    git co dev
    git push
}

genpasswd() {
    local l=$1
    [ "$l" == "" ] && l=16
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c ${l} | xargs
}

if [ -f ~/.bash_prompt ];then
    . ~/.bash_prompt
fi

if [ -f ~/.bash_functions ];then
  . ~/.bash_functions
fi

export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export PATH=$HOME/.npm/bin:$PATH
export NODE_PATH=$HOME/.npm/lib/node_modules:$NODE_PATH
### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"
export PATH="$HOME/.bin:$PATH"

prompt_command() {
  export PS1="$LTGREEN\u$LTBLUE@\h:$LIGHT_GRAY\w$CLEAR"$(parse_git_branch)"\n❯ "
  change_title
  check_bash
}

PROMPT_COMMAND=prompt_command
