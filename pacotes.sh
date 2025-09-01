#!/bin/bash
set -e

echo "=== Instalação de pacotes principais e extras ==="

# Atualiza sistema
sudo pacman -Syu --noconfirm

# Pacotes principais
sudo pacman -S --needed --noconfirm \
    ttf-jetbrains-mono ttf-jetbrains-mono-nerd \
    hyprpicker hyprpaper neovim hyprpolkitagent nwg-look \
    noto-fonts noto-fonts-emoji noto-fonts-extra swaync waybar hyprlock \
    gnome-terminal chromium cava scrcpy nemo rofi-wayland cmus copyq \
    flatpak fastfetch imagemagick

# Pacotes extras
sudo pacman -S --needed --noconfirm \
    mpv loupe gnome-boxes gnome-disk-utility gnome-system-monitor nemo-fileroller

echo "[✔] Pacotes principais e extras concluídos!"

