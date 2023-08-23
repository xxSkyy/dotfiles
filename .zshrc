# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh

# Themes list: https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="zhann"

plugins=(
    git
    zsh-autosuggestions
    zsh-syntax-highlighting
)


# Starship - info bar at top
eval "$(starship init zsh)"

alias steam_compat_move='f() {mv -v $1 ~/.steam/steam/steamapps/compatdata; ln -s ~/.steam/steam/steamapps/compatdata/$1 $1};f'
alias emergency_logout='kill -9 -1'

# Keybinds
bindkey '^ ' autosuggest-accept

# NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Deno 
export DENO_INSTALL="$HOME/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"

# Godot 4 bin location for Godot-Rust
export GODOT4_BIN='/run/media/sky/Development/GameDev/Godot/Godot4/Godot_v4.0-beta4_linux.x86_64' 
