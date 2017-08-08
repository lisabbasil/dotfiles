# .bash_profile

# Sourced by login shells, e.g.:
# $ sudo su -
# $ bash --login
# $ ssh user@host

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# Instead of sourcing it every time you log onto a server, just type setupATLAS when you need it
#export ATLAS_LOCAL_ROOT_BASE=/cvmfs/atlas.cern.ch/repo/ATLASLocalRootBase
#source ${ATLAS_LOCAL_ROOT_BASE}/user/atlasLocalSetup.sh

export RUCIO_ACCOUNT=bschneid

### Set terminfo (do that in .Xdefaults now)
#TERM=rxvt-unicode-256color
#TERM=rxvt-256color
#[ -n "$TMUX" ] && export TERM=screen-256color-s # already defined in .tmux.conf, but does not work on lheppc1 (but on lheppc7)

# For the HP Elitebook laptop, set the brightness at start to max
if [ "$HOSTNAME" = "basil" ]; then
    sudo bash -c "cat /sys/class/backlight/intel_backlight/max_brightness > /sys/class/backlight/intel_backlight/brightness"
fi

export PATH="$HOME/.cargo/bin:$PATH"
