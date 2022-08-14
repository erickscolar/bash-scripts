function install_picom() {
    # Install dependencies needed for compiling and building picom
    sudo apt install meson ninja-build make cmake libxext-dev libxcb1-dev libxcb-damage0-dev libxcb-xfixes0-dev libxcb-shape0-dev libxcb-render-util0-dev libxcb-render0-dev libxcb-randr0-dev libxcb-composite0-dev libxcb-image0-dev libxcb-present-dev libxcb-xinerama0-dev libxcb-glx0-dev libpixman-1-dev libdbus-1-dev libconfig-dev libgl1-mesa-dev libpcre2-dev libpcre3-dev libevdev-dev uthash-dev libev-dev libx11-xcb-dev meson -y
    # Clone picom
    git clone https://github.com/yshui/picom.git ~/picom
    # Build picom with meson and ninja
    mkdir -p ~/picom/build && cd ~/picom/build
    meson -Dprefix=/usr
    ninja
    sudo ninja install
}

function install_wpgtk() {
    # Install pywal dependencies
    sudo apt install python2 python3 python3-pip imagemagick qt5-style-plugins xsettingsd -y
    sudo pip3 install pywal
    sudo pip3 install wpgtk
    wpg-install.sh

    # Copy the background
    mkdir -p ~/.backgrounds
    cp $SCRIPT_DIR"/backgrounds/background.jpg" ~/.backgrounds
    wpg-install.sh -g
    wpg -s ~/.backgrounds/background.jpg
    # Set color pallete automatically based on background image
    # Append .bashrc (~/.bashrc) with pywal settings
    echo "(cat ~/.cache/wal/sequences &)" >> ~/.bashrc
    echo "source ~/.cache/wal/colors-tty.sh" >> ~/.bashrc
    # Configure uniform look for QT and GTK themes
    echo "[Qt]" > ~/.config/Trolltech.conf
    echo "style=GTK+" >> ~/.config/Trolltech.conf
    echo -e "\n" >> ~/.profile
    echo "QT_QPA_PLATFORMTHEME=gtk2" >> ~/.profile
}

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