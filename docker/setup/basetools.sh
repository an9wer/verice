#!/usr/bin/env bash

packages=(
  m4
  make
  man-pages
  git
  vim
  bash-completion
)

pacman -Sy --needed --noconfirm ${packages[@]}
