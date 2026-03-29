#!/bin/bash

mkdir -p ${HOME}/.local/bin

mise install starship fzf

chezmoi init https://github.com/trevorlauder/dotfiles
chezmoi apply
