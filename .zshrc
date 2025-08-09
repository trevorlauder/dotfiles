source "${HOME}/.zgen/zgen.zsh"

if ! zgen saved; then
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/git
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-autosuggestions

  zgen save
fi

export PATH="$(echo /opt/homebrew/opt/{coreutils,findutils,gawk}/libexec/gnubin | tr ' ' :):$PATH"

eval "$(zoxide init zsh)"

alias cd="z"
alias cat="bat --paging=never"
alias ls="eza --icons=always"
alias dotfiles="/opt/homebrew/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
alias vim="nvim"
alias vi="nvim"

export PATH="$HOME/.poetry/bin:$PATH"

export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include":

export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

export PATH="/opt/homebrew/opt/openssl@3/bin:$PATH"

export PATH="$PATH:$HOME/.local/bin"

export PATH="$PATH:/Applications/Visual Studio Code.app/Contents/Resources/app/bin"
export EZA_CONFIG_DIR="$HOME/.config/eza"


# initialise completions with ZSH's compinit
autoload -Uz compinit && compinit

source ~/.dotfiles-local-settings
eval "$(mise activate zsh)"

eval "$(starship init zsh)"

function set_win_title(){
  echo -ne "\033]0; $(basename "$PWD") \007"
}

precmd_functions+=(set_win_title)
