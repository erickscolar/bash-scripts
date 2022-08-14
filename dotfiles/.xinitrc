#!/bin/sh

# /etc/X11/xinit/xinitrc
#
# global xinitrc file, used by all X sessions started by xinit (startx)

# invoke global X session script
. /etc/X11/Xsession
xrdb ~/.Xresources
firejail --x11=xephyr --net=$( ip -o -4 route show to default | awk '{print $5}' ) i3
