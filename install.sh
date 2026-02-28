#!/bin/bash -e

# dotfiles dir
DOTFILES_DIR=$(pwd)

echo "--- Zahajuji instalaci dotfiles ---"

# List of files for installation
files=("vimrc:.vimrc" "bashrc:.bashrc" "screenrc:.screenrc" "zshrc:.zshrc" "vim:.vim")

DATE_EXT="$(date +%Y%m%d%H%M)"
mkdir "${HOME}/backup.${DATE_EXT}"

for item in "${files[@]}"; do
    src="${item%%:*}"
    dest="${item#*:}"

    echo "Linking $src -> ~/$dest"
    [ -f "$HOME/$dest" || -d "$HOME/$dest" ] && mv "$HOME/$dest"  "$HOME/backup.${DATE_EXT}/"


    ln -sf "$DOTFILES_DIR/$src" "$HOME/$dest"
done

echo "--- Done! ---"
echo "For aplication use: source ~/.bashrc"
