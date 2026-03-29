#!/bin/bash

mkdir -p ${HOME}/.local/bin

(cd ${HOME} && mise use starship fzf)

chezmoi init https://github.com/trevorlauder/dotfiles
chezmoi apply
