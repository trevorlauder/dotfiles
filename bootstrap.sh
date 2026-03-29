#!/bin/bash

mkdir -p ${HOME}/.local/bin

brew install chezmoi \
  starship \
  fzf

chezmoi init https://github.com/trevorlauder/dotfiles
chezmoi apply
