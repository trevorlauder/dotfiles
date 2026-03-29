#!/bin/bash

brew install chezmoi
chezmoi init https://github.com/trevorlauder/dotfiles
chezmoi apply
