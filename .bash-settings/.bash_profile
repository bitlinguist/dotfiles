export PS1="\[\033[36m\]\h:\W \[\033[33m\]\$(parse_git_branch)\[\033[00m\]\$(git config 
user.initials)$\[\033[00m\] "
export SUDO_PS1='\[\e[0;31m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[0;31m\]\$ \[\e[0m\]'

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

export SCSS="./src/site/templates/assets/css/scss"
export PARTIALS="./src/site/templates/views/partials"
export VIEWS="./src/site/templates/views/"
