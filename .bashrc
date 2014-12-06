# .bashrc

# Sourced by purely interactive shells, e.g.:
# $ sudo su
# $ bash
# $ ssh user@host command
# Since .bash_profile sources .bashrc, this file is always sourced

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Are you working on a server, i.e. not locally?
# TRIUMF servers start with atlas-tier3
# LXPLUS servers start with lxplus
case "$HOSTNAME" in
    atlas-tier3*) export PS1="\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;31m\]\h\[\033[00m\]: \[\033[01;34m\]\w\[\033[00m\] \$ ";;
    lxplus*) export PS1="\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;33m\]\h\[\033[00m\]: \[\033[01;34m\]\w\[\033[00m\] \$ ";;
    basil) export PS1="\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;34m\]\h\[\033[00m\]: \[\033[01;34m\]\w\[\033[00m\] \$ ";;
    *) export PS1="\[\033[01;32m\]\u\[\033[00m\]@\[\033[01;37m\]\h\[\033[00m\]: \[\033[01;34m\]\w\[\033[00m\] \$ ";;
esac

#if [ "$server" = true ]; then
#    export LD_LIBRARY_PATH=~/pkg/lib:$LD_LIBRARY_PATH
#    export MANPATH=~/pkg/share/man:$MANPATH
#    export PATH=~/pkg/bin:$PATH
#else
#    export PATH=~/bin/:~/bin/texbin/:$PATH
#fi
export LD_LIBRARY_PATH=~/pkg/lib:$LD_LIBRARY_PATH
export MANPATH=~/pkg/share/man:$MANPATH
export PATH=~/pkg/bin:$PATH

export EDITOR=vim

### Set uniform history file among all servers to be able to access it from all servers
HISTFILE=~/.bash_history

### Set keyboard for proper use of backspace
#stty erase ^?

### Set termcap locally, needed for proper running of rxvt-unicode-256color and screen-256color-s
export TERMCAP=~/.termcap

test -s ~/.alias && . ~/.alias

#xset b off

# Source command-not-found hook
cnfhook=/usr/share/doc/pkgfile/command-not-found.bash
[ -f "$cnfhook" ] && . "$cnfhook" && unset cnfhook
