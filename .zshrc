# RVM Installation
[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="robbyrussell"
ZSH_THEME="candy"

# Set to this to use case-sensitive completion
# CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
# COMPLETION_WAITING_DOTS="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git rails3 ruby rvm dirpersist autojump heroku zsh-syntax-highlighting osx bundler)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
if [ -e ~/.profile ]
then source ~/.profile
fi

# use vim as an editor
export EDITOR=vim

# aliases
if [ -e "$HOME/.aliases" ]; then
  source "$HOME/.aliases"
fi

# History awesomeness!  see rant at dotfiles.org/~brendano/.inputrc
# (zsh does not use gnu readline, so doesnt use .inputrc, 
# but this duplicates those features...)
setopt hist_no_store
setopt hist_reduce_blanks


# More options (picked from these resources)
# http://anyall.org/.zshrc
# http://wiki.archlinux.org/index.php/Zsh
setopt interactivecomments
setopt nobanghist
setopt nohup
setopt SH_WORD_SPLIT


# Key bindings 
# http://anyall.org/.zshrc works best for me
bindkey "\e[A" history-beginning-search-backward
bindkey "\e[B" history-beginning-search-forward
bindkey "\eOA" history-beginning-search-backward
bindkey "\eOB" history-beginning-search-forward

bindkey "\e[1~" beginning-of-line
bindkey "\e[2~" quoted-insert
bindkey "\e[3~" delete-char
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[7~" beginning-of-line
bindkey "\e[8~" end-of-line
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
bindkey "\eOd" backward-word
bindkey "\eOc" forward-word 



## FUNCTIONS
fin() {
  find . -iname "*$1*"
}

# Find a number latest modified files
latest() {
  ls -t **/*(D.om[1,$1])
}

# Find a number of the biggest files under the current dir
biggest() {
  ls -Sh **/*(-OL[1,$1])
}

# Create a dir with a time attached to its name
nowdir() {
  mkdir $(date "+%y%m%d")-$1
}

# Find files containting particular word
findin() {
  find $2 -type f | xargs grep -i $1
}

export PATH=/usr/local/bin:/usr/local/Cellar/php/5.3.8/bin:$HOME/bin:$PATH
export JAVA_HOME=`/usr/libexec/java_home`

#autojump
#Copyright Joel Schaerer 2008, 2009
#This file is part of autojump

#autojump is free software: you can redistribute it and/or modify
#it under the terms of the GNU General Public License as published by
#the Free Software Foundation, either version 3 of the License, or
#(at your option) any later version.
#
#autojump is distributed in the hope that it will be useful,
#but WITHOUT ANY WARRANTY; without even the implied warranty of
#MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#GNU General Public License for more details.
#
#You should have received a copy of the GNU General Public License
#along with autojump.  If not, see <http://www.gnu.org/licenses/>.

#determine the data directory according to the XDG Base Directory Specification
if [ -n "$XDG_DATA_HOME" ]
then
    export AUTOJUMP_DATA_DIR="$XDG_DATA_HOME/autojump"
else
    export AUTOJUMP_DATA_DIR=~/.local/share/autojump
fi

if [ ! -e "${AUTOJUMP_DATA_DIR}" ]
then
    mkdir -p "${AUTOJUMP_DATA_DIR}"
    mv ~/.autojump_py "${AUTOJUMP_DATA_DIR}/autojump_py" 2>>/dev/null #migration
    mv ~/.autojump_py.bak "${AUTOJUMP_DATA_DIR}/autojump_py.bak" 2>>/dev/null
    mv ~/.autojump_errors "${AUTOJUMP_DATA_DIR}/autojump_errors" 2>>/dev/null
fi

function autojump_preexec() {
    { (autojump -a "$(pwd -P)"&)>/dev/null 2>>|${AUTOJUMP_DATA_DIR}/.autojump_errors ; } 2>/dev/null
}

typeset -ga preexec_functions
preexec_functions+=autojump_preexec

alias jumpstat="autojump --stat"

function j { local new_path="$(autojump $@)";if [ -n "$new_path" ]; then echo -e "\\033[31m${new_path}\\033[0m"; cd "$new_path";else false; fi }

PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
