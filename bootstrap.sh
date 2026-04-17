#!/bin/bash

mkdir -p ${HOME}/.local/bin

git clone --depth 1 https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
rm -rf "${HOME}/.zgen/.git"

mise install -g chezmoi

chezmoi init https://github.com/trevorlauder/dotfiles
chezmoi apply
