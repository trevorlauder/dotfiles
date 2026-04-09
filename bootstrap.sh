#!/bin/bash

mkdir -p ${HOME}/.local/bin

umask 0022
git clone --depth 1 https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"
rm -rf "${HOME}/.zgen/.git"

mise install -y

chezmoi init https://github.com/trevorlauder/dotfiles
chezmoi apply
