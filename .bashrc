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
source ~/.bash-scripts/*

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

prompt_command() {
  export PS1="$LTGREEN\u$LTBLUE@\h:$LIGHT_GRAY\w$CLEAR"$(parse_git_branch)"\n❯ "
  change_title
}

function change_title () {
  echo -ne "\033]0;ter\007"
}

PROMPT_COMMAND=prompt_command



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
