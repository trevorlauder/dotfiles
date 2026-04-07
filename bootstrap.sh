#!/bin/bash

mkdir -p ${HOME}/.local/bin

git clone --depth 1 https://github.com/tarjoilija/zgen.git "${HOME_DIR}/.zgen"
rm -rf "${HOME_DIR}/.zgen/.git"

mise install -y

chezmoi init https://github.com/trevorlauder/dotfiles
chezmoi apply
