#!/bin/bash

# Získání absolutní cesty k adresáři s dotfiles
DOTFILES_DIR=$(pwd)

echo "--- Zahajuji instalaci dotfiles ---"

# Seznam souborů k nalinkování (zdroj:cíl)
files=("vimrc:.vimrc" "bashrc:.bashrc" "screenrc:.screenrc" "zshrc:.zshrc")

DATE_EXT="$(date +%Y%m%d%H%M)"

for item in "${files[@]}"; do
    src="${item%%:*}"
    dest="${item#*:}"

    echo "Linkuji $src -> ~/$dest"
    [ -f "$HOME/$dest" ] && cp -p "$HOME/$dest"  "$HOME/${dest}.${DATE_EXT}"


    ln -sf "$DOTFILES_DIR/$src" "$HOME/$dest"
done

echo "--- Hotovo! ---"
echo "Pro načtení bashrc použijte: source ~/.bashrc"
