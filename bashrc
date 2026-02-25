# =============================================================================
# UNIX ADMIN MINIMALIST BASHRC
# =============================================================================

# --- PROMPT (Barevný a informativní) ---
# Formát: [Uživatel@Host:Adresář] $
# Červená pro root, zelená pro běžného uživatele
if [ "$ID" = "0" ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\# '
else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi

# --- TERM NASTAVENÍ ---
# Důležité pro barvy ve Vimu přes PuTTY
export TERM=xterm-256color

# --- ALIASY PRO BEZPEČNOST A POHODLÍ ---
alias ls='ls --color=auto'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Ochrana proti nechtěnému přepsání/smazání
# alias cp='cp -i'
# alias mv='mv -i'
# alias rm='rm -i'

# Rychlá navigace
alias ..='cd ..'
alias ...='cd ../..'

# Vim jako výchozí editor
export EDITOR='vim'
export VISUAL='vim'

# --- HISTORIE ---
# Nekonečná historie se hodí pro dohledávání příkazů z minulého měsíce
HISTSIZE=10000
HISTFILESIZE=20000
shopt -s histappend          # Přidávat do historie, nepřepisovat
shopt -s checkwinsize        # Aktualizovat velikost oken po každém příkazu
# Formát času v historii: [DD.MM.YY HH:MM:SS]
export HISTTIMEFORMAT="%d.%m.%y %H:%M:%S "

# --- FUNKCE PRO ADMINA ---
# Rychlé vytvoření adresáře a vstup do něj
mkcd() {
    mkdir -p "$1" && cd "$1"
}

# Rychlá aktualizace dotfiles
alias dotup='cd ~/.dotfiles && git pull && ./install.sh && source ~/.bashrc'

# Rychlé uložení změn a push
dotsave() {
    cd ~/.dotfiles
    git add .
    git commit -m "Update config: $1"
    git push
    cd -
}
