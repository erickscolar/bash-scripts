#!/bin/bash

SCRIPT_DIR=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && pwd)
source "$SCRIPT_DIR/tools/shout.sh"
source "$SCRIPT_DIR/base.sh"
source "$SCRIPT_DIR/xserver.sh"
source "$SCRIPT_DIR/i3.sh"

if [ ! command -v sudo &>/dev/null ]
then
    shout er "sudo could not be found"
    exit
fi

if [ $EUID == 0 ]
then
    shout er "Do not run as root."
    exit
fi

shout nf "This script comes with no guarantee. Use it at your own risk" brk

# base.sh
#shout nf "Installing base packages..."
#install_base
#shout nf "Installing pipewire..."
#install_pipewire

# xserver.sh
#shout nf "Installing firejail..."
#install_firejail
#shout nf "Installing xserver..."
#install_xserver
#shout nf "Copying xserver configuration files..."
#install_xserver_dotfiles
#shout nf "Installing VMWare video drivers... Remove this if you are not using VMWare"
#install_vmware_drivers

# i3.sh
shout nf "Installing picom..."
install_picom
shout nf "Installing pywal and wpgtk..."
install_wpgtk
shout nf "Installing i3-gaps..."
install_i3