fpath+=~/.zfunc

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export PATH="$PATH/:/Applications/Postgres.app/Contents/Versions/13/bin"
export PATH="$HOME/.local/bin:$PATH"

ZSH_THEME="zhann"

plugins=(git
  kubectl
  yarn
  zsh-autosuggestions
  zsh-syntax-highlighting
  emotty
  emoji
)

bindkey -s ^p "~/temp/tmux-sessionizer\n"

bindkey '^ ' autosuggest-accept

source $ZSH/oh-my-zsh.sh

# Starship top bar
eval "$(starship init zsh)"

export PATH="$HOME/.cargo/bin:$PATH"

export PATH="/opt/homebrew/bin:$PATH"

export PATH="$HOME/.docker/bin:$PATH"

if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi


alias ionic:sync='yarn build && yarn cap sync ios'
alias ionic:build='yarn build && yarn cap run ios'
alias ionic:livereload='ionic cap run ios --livereload --external'

alias replica='run-rs --mongod --keep --host 0.0.0.0'

  export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && . "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && . "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export HOMEBREW_SBIN="/opt/homebrew/sbin:$PATH"
export PATH=$HOME/bin:/usr/local/bin:$HOMEBREW_SBIN

### Kubectl completion
source <(kubectl completion zsh)

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

# pnpm
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

export STM32CubeMX_PATH=/Applications/STM32CubeMX.app/Contents/Resources

alias get_idf='. $HOME/esp/esp-idf/export.sh'
