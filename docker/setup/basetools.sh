#!/usr/bin/env bash

packages=(
  m4
  make
  man-pages
  vim
)

pacman -Sy --needed --noconfirm ${packages[@]}
