prefix ?= /usr/local
BIN_DIR = $(prefix)/bin
LIB_ME_DIR = $(prefix)/lib/me
PROFILE_DIR = /etc/profile.d
COMPLETOINS_DIR = $(prefix)/share/bash-completion/completions

M4 := m4
RM := rm
GIT := git
CHMOD := chmod
INSTALL := install

.PHONY: build update install uninstall

build: bin/me completions/me

bin/me: bin/me.in
	$(M4) -DLIB_ME_DIR=$(LIB_ME_DIR) $< >$@
	$(CHMOD) 755 $@

completions/me: completions/me.in
	$(M4) -DLIB_ME_DIR=$(LIB_ME_DIR) $< >$@

update: clean uninstall
	$(GIT) pull origin

clean:
	$(RM) -f bin/me
	$(RM) -f completions/me

install:
	mkdir -p $(BIN_DIR)
	mkdir -p $(LIB_ME_DIR)
	mkdir -p $(PROFILE_DIR)
	mkdir -p $(COMPLETOINS_DIR)
	$(INSTALL) -m 755 bin/me $(BIN_DIR)
	$(INSTALL) -m 755 lib/me/* $(LIB_ME_DIR)
	$(INSTALL) -m 644 etc/profile.d/me.sh $(PROFILE_DIR)/me.sh
	$(INSTALL) -m 644 completions/me $(COMPLETOINS_DIR)/me

uninstall:
	rm -f $(BIN_DIR)/me
	rm -f $(PROFILE_DIR)/me.sh
	rm -f $(COMPLETOINS_DIR)/me
	rm -rf $(LIB_ME_DIR)
