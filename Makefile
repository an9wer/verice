prefix ?= /usr/local
BIN_DIR = $(prefix)/bin
LIB_ME_DIR = $(prefix)/lib/me
COMPLETOINS_DIR = $(prefix)/share/bash-completion/completions
PROFILE_DIR = /etc/profile.d
ME_GITHUB_DIR = /etc/me-github.d
ME_DARKSKY_DIR = /etc/me-darksky.d
ME_TLBOT_DIR = /etc/me-tlbot-send.d

M4 := m4
RM := rm
LN := ln
GIT := git
CHMOD := chmod
INSTALL := install
PYTHON := python3

.PHONY: build update install uninstall

build: bin/me completions/me venv

bin/me: bin/me.in
	$(M4) -DLIB_ME_DIR=$(LIB_ME_DIR) $< >$@
	$(CHMOD) 755 $@

completions/me: completions/me.in
	$(M4) -DLIB_ME_DIR=$(LIB_ME_DIR) $< >$@

venv: requirements.txt
	$(PYTHON) -m venv venv
	venv/bin/pip install -r requirements.txt

update: clean uninstall
	$(GIT) pull origin

clean:
	$(RM) -f bin/me
	$(RM) -f completions/me

install:
	$(INSTALL) -d $(BIN_DIR) && $(INSTALL) -m 755 bin/me $(BIN_DIR)
	$(INSTALL) -d $(LIB_ME_DIR) && $(INSTALL) -m 755 lib/me/* $(LIB_ME_DIR)
	$(INSTALL) -d $(PROFILE_DIR) && $(INSTALL) -m 644 etc/profile.d/me.sh $(PROFILE_DIR)
	$(INSTALL) -d $(COMPLETOINS_DIR) && $(INSTALL) -m 644 completions/me $(COMPLETOINS_DIR)
	$(INSTALL) -d $(ME_GITHUB_DIR) && $(INSTALL) -m 644 etc/me-github.d/* $(ME_GITHUB_DIR)
	$(INSTALL) -d $(ME_DARKSKY_DIR) && $(INSTALL) -m 644 etc/me-darksky.d/* $(ME_DARKSKY_DIR)
	$(INSTALL) -d $(ME_TLBOT_DIR) && $(INSTALL) -m 644 etc/me-tlbot-send.d/* $(ME_TLBOT_DIR)
	$(INSTALL) -m 644 etc/me-github.conf /etc
	$(INSTALL) -b -m 644 etc/gitconfig /etc

uninstall:
	rm -f $(BIN_DIR)/me
	rm -f $(PROFILE_DIR)/me.sh
	rm -f $(COMPLETOINS_DIR)/me
	rm -rf $(LIB_ME_DIR)

