# =============================================================================
# UNIX ADMIN MINIMALIST BASHRC
# =============================================================================
export BASH_SILENCE_DEPRECATION_WARNING=1

# Definice barev
RED='\[\033[01;31m\]'
GREEN='\[\033[01;32m\]'
BLUE='\[\033[01;34m\]'
RESET='\[\033[00m\]'

# Funkce pro dynamické sestavení promptu
build_prompt() {
    if [ "$(id -u)" -eq 0 ]; then
        echo "${RED}\u@\h${RESET}:${BLUE}\w${RESET}# "
    else
        echo "${GREEN}\u@\h${RESET}:${BLUE}\w${RESET}\$ "
    fi
}

# Nastavení PS1 pomocí PROMPT_COMMAND (překreslí se při každém ENTERu)
PROMPT_COMMAND='PS1=$(build_prompt)'

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

if [[ -f ~/.bash_local ]]; then
    source ~/.bash_local
fi
