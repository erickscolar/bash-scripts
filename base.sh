function install_base() {
    # Update user directories
    xdg-user-dirs-update

    # Update system
    sudo apt update -y && \
    sudo apt upgrade -y && \
    sudo apt dist-upgrade -y

    # Install and enable ufw
    sudo apt install ufw -y && \
    sudo systemctl enable ufw && \
    sudo ufw enable

    # Install some useful packages
    sudo apt install curl network-manager -y
}

function install_pipewire() {
    # Install needed pipewire packages
    sudo apt install pipewire pipewire-audio-client-libraries libspa-0.2-bluetooth libspa-0.2-jack -y

    # Copy the example to /etc/systemd/user
    sudo touch /etc/pipewire/media-session.d/with-pulseaudio && \
    sudo cp /usr/share/doc/pipewire/examples/systemd/user/pipewire-pulse.* /etc/systemd/user/
    # Check for new service files with:
    #systemctl --user daemon-reload
    sudo systemctl daemon-reload
    # Disable and stop the PulseAudio service with:
    #systemctl --user --now disable pulseaudio.service pulseaudio.socket
    sudo systemctl --now disable pulseaudio.service pulseaudio.socket
    # Enable and start the new pipewire-pulse service with:
    #systemctl --user --now enable pipewire pipewire-pulse
    sudo systemctl --now enable pipewire pipewire-pulse
    # Mask pulseaudio so it does not start after reboot
    #systemctl --user mask pulseaudio
    sudo systemctl mask pulseaudio

    # Copy alsa configuration files
    sudo touch /etc/pipewire/media-session.d/with-alsa
    sudo cp /usr/share/doc/pipewire/examples/alsa.conf.d/99-pipewire-default.conf /etc/alsa/conf.d/

    # Copy jack configuration files
    sudo touch /etc/pipewire/media-session.d/with-jack
    sudo cp /usr/share/doc/pipewire/examples/ld.so.conf.d/pipewire-jack-*.conf /etc/ld.so.conf.d/
    sudo ldconfig

    # Purge pulseaudio bluetooth module if installed
    sudo apt remove pulseaudio-module-bluetooth --purge -y
}