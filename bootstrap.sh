#!/bin/bash

mkdir -p ${HOME}/.local/bin

brew install chezmoi \
  starship \
  fzf \
  zsh-syntax-highlighting \
  zsh-autosuggestions \
  zsh-git-prompt

chezmoi init https://github.com/trevorlauder/dotfiles
chezmoi apply
