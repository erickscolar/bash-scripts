function install_firejail() {
    # Install firejail firejail and apparmor for X11 sandboxing
    sudo apt install firejail firejail-profiles apparmor apparmor-utils -y && \
    
    # Enforce firejail with apparmor
    sudo aa-enforce firejail-default
    
    # Create a hook to run everytime a package is installed/uninstalled (dpkg)
    sudo touch /etc/apt/apt.conf.d/99firecfg-hook
    sudo echo "Dpkg::Post-Invoke {firecfg;};" | sudo tee /etc/apt/apt.conf.d/99-firecfg-hook && \
    sudo firecfg
}

function install_xserver() {
    # Install X11 and xephyr
    sudo apt install apparmor-utils xserver-xorg-core xserver-xorg-input-evdev x11-xserver-utils x11-xkb-utils x11-utils xinit xserver-xephyr -y && \
    
    # Remove xpra if available, we don't need it
    sudo apt remove xpra --purge -y
}

function install_xserver_dotfiles() {
    # Copy profile, xserverrc and xinitrc to home
    cp -a $SCRIPT_DIR"/dotfiles/." ~/
}

function install_vmware_drivers() {
    ##################################################
    # ONLY FOR VMWARE WORKSTATION FULLSCREEN - REMOVE AFTER TESTING!
    ##################################################
    sudo apt install xserver-xorg-video-vmware -y
}