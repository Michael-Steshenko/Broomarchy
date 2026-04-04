# If not running interactively, don't do anything (leave this at the top of this file)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source ~/.local/share/omarchy/default/bash/rc

# Add your own exports, aliases, and functions here.

# WinApps
# From https://github.com/winapps-org/winapps/blob/main/docs/libvirt.md
# We need this for libvirt to be able to talk to our VM
export LIBVIRT_DEFAULT_URI="qemu:///system"
