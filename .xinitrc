#!/usr/bin/env bash

# Turn off visual bell, this doesn't work when putting it here
#xset b off

# Read in xmodmap, this remaps the menu key to the super (windows) key
xmodmap ~/.Xmodmap

# Set default interactive shell
SHELL=/bin/zsh

# Start enlightenment
#exec enlightenment_start

# Start awesome
#exec awesome >> ~/.awesome/logs/log-"$(mydate)" 2>&1

# Start i3
exec i3 -V >> ~/.i3/logs/log-$(date +"%F_%H-%M-%S") 2>&1
