#!/usr/bin/env bash

packages=(
  m4
  make
  man-pages
  vim
  bash-completion
)

pacman -Sy --needed --noconfirm ${packages[@]}
