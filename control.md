# Sound Control
alsamixer
amixer

# Network
nmtui
iwctl

# Startup Services
systemctl enable/disable

# Screen Brightness
xrandr --brightness
brightnessctl set

# Window Manager
* edit "~/.aur/dwm/config.h"
* rebuild via "makepkg -sif"

# Status Menu
* edit "~/c/dwmstatus"
* run "sudo make install"

# Bluetooth
blueman
blueberry

# System Monitor
free -m
zenith
htop
df -h

# Start Window Server
Hyprland
dwl
startx
dwm

# Screen Lock
- for dwm -> slock : enabled by /etc/systemd/system/slock.service
- for niri -> swaylock -> enabled by ~/.profile

# Lid Close Behavior
controlled by /etc/systemd/logind.conf

# 
