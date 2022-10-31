function install_i3() {
    # Install dependencies needed for compiling and building i3-gaps
    sudo apt install i3-wm i3 rxvt-unicode polybar rofi meson ninja-build make cmake dh-autoreconf libxcb-keysyms1-dev libpango1.0-dev libxcb-util0-dev xcb libxcb1-dev libxcb-icccm4-dev libyajl-dev libev-dev libxcb-xkb-dev libxcb-cursor-dev libxkbcommon-dev libxcb-xinerama0-dev libxkbcommon-x11-dev libstartup-notification0-dev libxcb-randr0-dev libxcb-xrm0 libxcb-xrm-dev libxcb-shape0 libxcb-shape0-dev -y
    sudo apt purge xterm -y
    # Clone i3-gaps
    git clone https://www.github.com/Airblader/i3.git ~/i3-gaps
    # Build i3-gaps with meson and ninja
    mkdir -p ~/i3-gaps/build && cd ~/i3-gaps/build
    meson -Dprefix=/usr
    ninja
    sudo ninja install

     # Copy dotfiles to ~/.config
    cp -r $SCRIPT_DIR"/dotfiles/.config/." ~/.config
    chmod 755 ~/.config/i3 && \
    chmod 755 ~/.config/rofi && \
    chmod 755 ~/.config/polybar && \
    chmod 755 ~/.config/picom
    # write .Xresources to home (~/.Xresources)
    echo "URxvt*scrollBar: false" > ~/.Xresources
    echo "URxvt*internalBorder: 16" >> ~/.Xresources
}