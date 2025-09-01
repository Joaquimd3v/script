#!/bin/bash
set -e

echo "=== Instalação do yay ==="

# Verifica git
if ! command -v git &> /dev/null; then
    echo "[INFO] Git não encontrado. Instalando..."
    sudo pacman -S --needed --noconfirm git
fi

# Verifica yay
if ! command -v yay &> /dev/null; then
    echo "[INFO] yay não encontrado. Instalando..."
    cd /tmp
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
    rm -rf yay
else
    echo "[INFO] yay já está instalado."
fi

echo "[✔] yay concluído!"

