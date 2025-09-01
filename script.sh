#!/bin/bash
set -e

echo "=== Setup inicial Arch ==="

# --- Instala git se não existir ---
if ! command -v git &> /dev/null; then
    echo "[INFO] Git não encontrado. Instalando..."
    sudo pacman -S --needed --noconfirm git
fi

# --- Instala yay ---
if ! command -v yay &> /dev/null; then
    echo "[INFO] yay não encontrado. Instalando..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
fi

# --- Atualiza sistema ---
echo "[INFO] Atualizando pacotes do sistema..."
sudo pacman -Syu --noconfirm

# --- Pacotes principais ---
echo "[INFO] Instalando pacotes principais..."
sudo pacman -S --needed --noconfirm \
    ttf-jetbrains-mono ttf-jetbrains-mono-nerd \
    hyprpicker hyprpaper neovim hyprpolkitagent nwg-look \
    noto-fonts noto-fonts-emoji noto-fonts-extra swaync waybar hyprlock \
    gnome-terminal chromium cava scrcpy nemo rofi-wayland cmus copyq \
    flatpak fastfetch imagemagick

# --- Pacotes extras ---
echo "[INFO] Instalando pacotes extras..."
sudo pacman -S --needed --noconfirm \
    mpv loupe gnome-boxes gnome-disk-utility gnome-system-monitor nemo-fileroller

# --- Pacotes AUR ---
echo "[INFO] Instalando pacotes do AUR..."
yay -S --needed --noconfirm \
    gruvbox-dark-icons-gtk gruvbox-material-gtk-theme-git \
    hyprshot wlogout zen-browser-bin

# --- Flatpak ---
echo "[INFO] Configurando e instalando Flatpak..."

if ! command -v flatpak &> /dev/null; then
    echo "[INFO] Flatpak não encontrado. Instalando..."
    sudo pacman -S --needed --noconfirm flatpak
fi

if ! flatpak remote-list | grep -q flathub; then
    echo "[INFO] Adicionando repositório Flathub..."
    sudo flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
else
    echo "[INFO] Flathub já configurado."
fi

flatpak install -y it.mijorus.smile

# --- Dotfiles ---
echo "[INFO] Clonando dotfiles..."
mkdir -p ~/.config
cd ~/.config
if [ ! -d "dotfiles" ]; then
    git clone https://github.com/shub39/dotfiles
else
    echo "[INFO] Diretório dotfiles já existe. Pulando clone."
fi

# --- Configuração Hyprland ---
echo "[INFO] Configurando Hyprland..."
mkdir -p ~/.config/hypr

if [ ! -f ~/.config/hypr/hyprland.conf ]; then
    echo 'source = ~/.config/dotfiles/hyprland/hyprland.conf' > ~/.config/hypr/hyprland.conf
    echo "[INFO] Arquivo hyprland.conf criado."
else
    if ! grep -Fxq "source = ~/.config/dotfiles/hyprland/hyprland.conf" ~/.config/hypr/hyprland.conf; then
        echo 'source = ~/.config/dotfiles/hyprland/hyprland.conf' >> ~/.config/hypr/hyprland.conf
        echo "[INFO] Linha de source adicionada ao hyprland.conf existente."
    else
        echo "[INFO] hyprland.conf já contém o source. Nada alterado."
    fi
fi

echo "=== Instalação concluída! ==="
echo "➡️ Agora reinicie o sistema para aplicar as mudanças."

