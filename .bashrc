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
colorUser='0;32'
colorPath='1;34'
case "$HOSTNAME" in
    basil) colorServer='1;31';;
    atlas-tier3*) colorServer='1;36';;
    lxplus*) colorServer='1;33';;
    *) colorServer='1;35';;
esac
export PS1="\[\033[${colorUser}m\]\u\[\033[00m\]@\[\033[${colorServer}m\]\h\[\033[00m\]: \[\033[${colorPath}m\]\w\[\033[00m\] \$ "

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

# For the HP Elitebook laptop, set the brightness at start to max
if [ "$HOSTNAME" = "basil" ]; then
    sudo bash -c "cat /sys/class/backlight/intel_backlight/max_brightness > /sys/class/backlight/intel_backlight/brightness"
fi
