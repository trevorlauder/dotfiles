#!/bin/bash
set -euo pipefail

mkdir -p ${HOME}/.local/bin

rm -rf "${HOME}/.zgen"
git clone --depth 1 https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
rm -rf "${HOME}/.zgen/.git"

mise trust ~/.dotfiles

cp ~/.dotfiles/dot_config/mise/config.toml ~/.config/mise/
cp ~/.dotfiles/dot_config/mise/conf.d/100-dotfiles.toml ~/.config/mise/conf.d/
cp ~/.dotfiles/dot_config/mise/mise.lock ~/.config/mise/

mise install chezmoi

mise exec -- chezmoi init https://github.com/trevorlauder/dotfiles
mise exec -- chezmoi apply
