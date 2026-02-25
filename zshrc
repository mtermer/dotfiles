# =============================================================================
# UNIX ADMIN MINIMALIST ZSHRC
# =============================================================================

# --- ZÁKLADNÍ NASTAVENÍ ---
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_ALL_DUPS  # Neukládat duplicity
setopt HIST_REDUCE_BLANKS    # Ořezat mezery
setopt INC_APPEND_HISTORY    # Přidávat historii okamžitě (sdílení mezi okny)

# --- DOPLŇOVÁNÍ (Tabulátor) ---
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select # Grafický výběr v menu
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' # Case-insensitive doplňování

# --- PROMPT (Barevný a informativní) ---
# %n=user, %m=host, %~=path (zkrácená), %#=znak podle oprávnění
autoload -U colors && colors
if [[ $UID -eq 0 ]]; then
    PROMPT="%{$fg[red]%}%n@%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}%# "
else
    PROMPT="%{$fg[green]%}%n@%m%{$reset_color%}:%{$fg[blue]%}%~%{$reset_color%}%# "
fi

# --- FORMÁT ČASU V HISTORII ---
export HISTTIMEFORMAT="%d.%m.%y %H:%M:%S "

# --- TERM NASTAVENÍ (Pro barvy ve Vimu) ---
export TERM=xterm-256color

# --- ALIASY (Identické s bashrc) ---
alias ls='ls --color=auto'
[[ "$OSTYPE" == "darwin"* ]] && alias ls='ls -G' # Oprava pro Mac ls
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# alias cp='cp -i'
# alias mv='mv -i'
# alias rm='rm -i'

alias ..='cd ..'
alias ...='cd ../..'

export EDITOR='vim'
export VISUAL='vim'

# --- FUNKCE ---
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

if [[ -f ~/.zsh_local ]]; then
    source ~/.zsh_local
fi

