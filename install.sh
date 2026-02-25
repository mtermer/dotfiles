#!/bin/bash

# Získání absolutní cesty k adresáři s dotfiles
DOTFILES_DIR=$(pwd)

echo "--- Zahajuji instalaci dotfiles ---"

# Seznam souborů k nalinkování (zdroj:cíl)
files=("vimrc:.vimrc" "bashrc:.bashrc" "screenrc:.screenrc")

for item in "${files[@]}"; do
    src="${item%%:*}"
    dest="${item#*:}"

    echo "Linkuji $src -> ~/$dest"
    ln -sf "$DOTFILES_DIR/$src" "$HOME/$dest"
done

echo "--- Hotovo! ---"
echo "Pro načtení bashrc použijte: source ~/.bashrc"
