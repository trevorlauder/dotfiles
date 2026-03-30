#!/bin/bash

mkdir -p ${HOME}/.local/bin

mise install -y

chezmoi init https://github.com/trevorlauder/dotfiles
chezmoi apply
