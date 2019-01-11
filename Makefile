prefix ?= /usr/local
BIN_DIR = $(prefix)/bin
LIB_ME_DIR = $(prefix)/lib/me
LIB_ME_JOB_DIR = $(prefix)/lib/me-job
PROFILE_DIR = /etc/profile.d

RM := rm
GIT := git
INSTALL := install

.PHONY: update install uninstall

update:
	$(GIT) pull origin master

install:
	mkdir -p $(BIN_DIR)
	mkdir -p $(LIB_ME_DIR)
	mkdir -p $(LIB_ME_JOB_DIR)
	mkdir -p $(PROFILE_DIR)
	$(INSTALL) -m 755 bin/me $(BIN_DIR)
	$(INSTALL) -m 755 lib/me/* $(LIB_ME_DIR)
	$(INSTALL) -m 755 lib/me-job/* $(LIB_ME_JOB_DIR)
	$(INSTALL) -m 644 etc/profile.d/me.sh $(PROFILE_DIR)/me.sh

uninstall:
	rm -f $(BIN_DIR)/me*
	rm -f $(PROFILE_DIR)/me.sh
	rm -rf $(LIB_ME_DIR)
	rm -rf $(LIB_ME_JOB_DIR)
