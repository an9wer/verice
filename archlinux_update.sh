#!/usr/bin/env bash

log_iptables() {
  date
  iptables -vnL
  echo -e "\n\n"
}

pacman -Syu --noconfirm &&
log_iptables &>> /var/log/iptables.log &&
shutdown -r +2
