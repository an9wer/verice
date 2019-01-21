#!/usr/bin/env bash

{ # Install dependences
  sudo pacman -Sy --needed --noconfirm git

} && { # Download verice
  VERICE_DIR=/home/an9wer/Naruto/verice
  git clone --depth 1 https://github.com/an9wer/verice.git ${VERICE_DIR}

}
