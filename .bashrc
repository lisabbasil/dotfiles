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

# Colors! Set PS1 according to machine you are working on
if [ $UID -eq 0 ]; then
    colorUser='1;31'
else
    colorUser='0;32'
fi
colorPath='0;36'
case "$HOSTNAME" in
    basilkiste) colorServer='1;31';;
    archserver*) colorServer='0;33';;
    *) colorServer='1;35';;
esac
export PROMPT_DIRTRIM=3
export PS1="\[\033[${colorUser}m\]\u\[\033[00m\]@\[\033[${colorServer}m\]\h\[\033[00m\]: \[\033[${colorPath}m\]\w\[\033[00m\] \$ "

# Set vi mode! Woohoo!
set -o vi

# Eternal bash history; see also
# http://stackoverflow.com/questions/9457233/unlimited-bash-history
export HISTFILESIZE=500000

#setxkbmap -layout us -variant altgr-intl &> /dev/null

# Change the file location because certain bash sessions truncate .bash_history
# file upon close.
# http://superuser.com/questions/575479/bash-history-truncated-to-500-lines-on-each-login

# Force prompt to write history after every command.
# http://superuser.com/questions/20900/bash-history-loss
#PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

. ~/.shellrc
