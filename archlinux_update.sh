#!/usr/bin/env bash

log_iptables() {
  local ANSI_BLUE="\e[94m"
  local ANSI_END="\e[0m"
  echo "${ANSI_BLUE}$(date)${ANSI_END}"
  iptables -vnL
  echo -e "\n\n"
}

pacman -Syu --noconfirm &&
log_iptables &>> /var/log/iptables.log &&
shutdown -r +2
