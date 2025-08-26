source "${HOME}/.zgen/zgen.zsh"
if ! zgen saved; then
  zgen oh-my-zsh
  zgen oh-my-zsh plugins/git
  zgen load zsh-users/zsh-syntax-highlighting
  zgen load zsh-users/zsh-autosuggestions
  zgen save
fi

# Use path array for cleaner manipulation and uniqueness.
typeset -U path PATH

# Helper for adding paths: path_add <prepend|append> paths...
path_add() {
  local mode=$1; shift
  local p
  for p in "$@"; do
    [[ -d $p ]] || continue
    case $mode in
      prepend) path=($p $path) ;;
      append)  path+=($p) ;;
    esac
  done
}

# Prepend higher-priority user/tool bins.
path_add prepend \
  /opt/homebrew/opt/{coreutils,findutils,gawk}/libexec/gnubin \
  "$HOME/.poetry/bin" \
  /opt/homebrew/opt/openssl@3/bin

# Append lower-priority convenience bins.
path_add append \
  "$HOME/.local/bin" \
  "/Applications/Visual Studio Code.app/Contents/Resources/app/bin"

unset -f path_add

# OpenSSL build flags (Homebrew OpenSSL 3).
export LDFLAGS="-L/opt/homebrew/opt/openssl@3/lib"
export CPPFLAGS="-I/opt/homebrew/opt/openssl@3/include"
export PKG_CONFIG_PATH="/opt/homebrew/opt/openssl@3/lib/pkgconfig"

# Tool-specific environment.
export EZA_COLORS="\
  uu=36:\
  uR=31:\
  un=35:\
  gu=37:\
  da=2;34:\
  ur=34:\
  uw=95:\
  ux=36:\
  ue=36:\
  gr=34:\
  gw=35:\
  gx=36:\
  tr=34:\
  tw=35:\
  tx=36:\
  xx=95:"

eval "$(zoxide init zsh)"
eval "$(mise activate zsh)"
eval "$(starship init zsh)"

alias cd="z"
alias cat="bat --paging=never"
alias ls='eza -lagX --icons --color=always'
alias dotfiles="/opt/homebrew/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

export HOMEBREW_NO_ENV_HINTS=1

autoload -Uz compinit
if [[ -z ${ZSH_COMPDUMP:-} || ! -f ${ZSH_COMPDUMP} ]]; then
  compinit
else
  compinit -C
fi

# Per-machine or secret values: $HOME/.dotfiles-local-settings (optional)
[[ -f "$HOME/.dotfiles-local-settings" ]] && source "$HOME/.dotfiles-local-settings"

function set_win_title(){
  echo -ne "\033]0; $(basename "$PWD") \007"
}

precmd_functions+=(set_win_title)
