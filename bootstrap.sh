#!/bin/bash

mkdir -p ${HOME}/.local/bin

git clone --depth 1 https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
rm -rf "${HOME}/.zgen/.git"

eval "$(mise activate bash)"
mise install -y

chezmoi init https://github.com/trevorlauder/dotfiles
chezmoi apply
