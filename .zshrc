source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/git
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-autosuggestions

  zgen save
fi

export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init - zsh)"

source ~/.dotfiles-local-settings

eval "$(zoxide init zsh)"

alias cd="z"
alias cat="bat --paging=never"
alias ls="eza --icons=always"
alias dotfiles="/opt/homebrew/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

export PATH="$HOME/.poetry/bin:$PATH"
export PATH="/usr/local/opt/node@12/bin:$PATH"
. "/Users/tlauder/.acme.sh/acme.sh.env"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

export PATH="/usr/local/opt/openssl@3/bin:$PATH"

export LDFLAGS="-L/usr/local/opt/openssl@3/lib"
export CPPFLAGS="-I/usr/local/opt/openssl@3/include":

export PKG_CONFIG_PATH="/usr/local/opt/openssl@3/lib/pkgconfig"

export PATH="$PATH:/Applications/Duplicacy.app/Contents/Resources"
export PATH="/usr/local/opt/openssl@3/bin:$PATH"

export PATH="$PATH:$HOME/.local/bin"
export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export EZA_CONFIG_DIR="$HOME/.config/eza"

eval "$(starship init zsh)"

function set_win_title(){
  echo -ne "\033]0; $(basename "$PWD") \007"
}

precmd_functions+=(set_win_title)

eval "$(mise activate zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
