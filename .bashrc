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

# Set PS1 according to server you are working on
colorUser=34
colorPath=27
case "$HOSTNAME" in
    basil) colorServer=9;;
    atlas-tier3*) colorServer=214;;
    lxplus*) colorServer=148;;
    *) colorServer=213;;
esac
export PS1="\e[38;5;${colorUser}m\u\e[m@\e[38;5;${colorServer}m\]\h\e[m: \e[38;5;${colorPath}m\]\w\e[m \$ "

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
