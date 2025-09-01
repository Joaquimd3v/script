#!/bin/bash
set -e

# Passo 1: Clonar o repositório
git clone https://github.com/shub39/dotfiles ~/.config/dotfiles

# Passo 2: Configurar hyprland.conf para usar os dotfiles
echo 'source = ~/.config/dotfiles/hyprland/hyprland.conf' > ~/.config/hypr/hyprland.conf

