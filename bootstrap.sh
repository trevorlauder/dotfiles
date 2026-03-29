#!/bin/bash

mkdir -p ${HOME}/.local/bin

mise use starship fzf

chezmoi init https://github.com/trevorlauder/dotfiles
chezmoi apply
