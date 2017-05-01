#!/usr/bin/env sh
# -*- coding: utf-8 -*-

# ~/.bashrc: executed by bash(1) for non-login shells
#
# When  bash is invoked as an interactive login shell,
# or as a non-interactive shell with the --login option,
# it first reads and executes  commands  from  the file /etc/profile,
# if that file exists. After reading that file, it looks for
# ~/.bash_profile, ~/.bash_login, and ~/.profile,
# in  that order, and reads and executes commands from the first one
# that exists and is readable.

. /etc/bash.bashrc &> /dev/null

export VAGRANT_ROOT=/vagrant

test -z  "$PS1" && {
    cd "${VAGRANT_ROOT}"
    return $?
}

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
shopt -s dotglob    # files beginning with . to be returned in the results of path-name expansion.

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(lesspipe)"

PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
(test -z "${HOSTNAME}" && ifconfig em0 &>/dev/null) && {
    export HOSTNAME=$(ifconfig em0 | egrep 'inet [0-9]' | awk '{print $2}')
}

PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}: $(echo "$PWD" | sed "s#^${HOME}#~#" 2>/dev/null || echo "$PWD")\007"'

. /usr/local/share/bash-completion/bash_completion.sh &> /dev/null && {
    complete -cf sudo # Tab complete for sudo
}

which direnv &> /dev/null && {
    eval "$(direnv hook bash)"
}

cd "${VAGRANT_ROOT}"
