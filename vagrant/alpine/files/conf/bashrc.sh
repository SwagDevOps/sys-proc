#!/usr/bin/env sh

# ~/.bashrc: executed by bash(1) for non-login shells

. /etc/bash.bashrc &> /dev/null
. /etc/profile.d/rvm.sh &> /dev/null

test -n "$PS1" || return 0

export CLICOLOR=yes
export GREP_OPTIONS=--color=auto
export LESS='-R'
export HISTCONTROL=ignoredups
export HISTSIZE=5000
export HISTFILESIZE=1000

which less > /dev/null && {
    export PAGER=less
}

which vim > /dev/null && {
    export EDITOR=vim
    alias vi=vim
}

which colordiff > /dev/null && alias diff='colordiff'

shopt -s histappend # append to history rather than overwrite
# shopt -s dotglob  # dotfiles returned in path-name expansion

# make less more friendly for non-text input files, see lesspipe(1)
test -x /usr/bin/lesspipe && {
    eval "$(lesspipe)"
}

PS1='\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: $(echo "$PWD" | sed "s#^${HOME}#~#" 2>/dev/null || echo "$PWD")\007"'

. /usr/local/share/bash-completion/bash_completion.sh &> /dev/null && {
    complete -cf sudo
}
