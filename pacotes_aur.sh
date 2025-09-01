#!/bin/bash
set -e

echo "=== Instalação de pacotes do AUR ==="

# Verifica se yay está instalado
if ! command -v yay &> /dev/null; then
    echo "[ERRO] yay não encontrado. Rode primeiro yay.sh"
    exit 1
fi

# Instala pacotes do AUR
yay -S --needed --noconfirm \
    gruvbox-dark-icons-gtk \
    gruvbox-material-gtk-theme-git \
    hyprshot \
    wlogout \
    zen-browser-bin

echo "[✔] Pacotes do AUR concluídos!"

