#!/bin/bash

mkdir -p ${HOME}/.local/bin

mise install starship fzf

eval "$(mise activate zsh)"

chezmoi init https://github.com/trevorlauder/dotfiles
chezmoi apply
