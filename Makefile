prefix ?= /usr/local
BIN_DIR = $(prefix)/bin
PROFILE_DIR = /etc/profile.d

RM := rm
GIT := git
INSTALL := install

.PHONY: update install uninstall

update:
	$(GIT) pull origin master

install:
	mkdir -p $(BIN_DIR)
	mkdir -p $(PROFILE_DIR)
	$(INSTALL) -m 755 bin/ur $(BIN_DIR)/ur
	$(INSTALL) -m 644 etc/profile.d/me.sh $(PROFILE_DIR)/me.sh

uninstall:
	rm -f $(BIN_DIR)/ur
	rm -f $(PROFILE_DIR)/me.sh
