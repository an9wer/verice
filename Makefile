prefix ?= /usr/local
BIN_DIR = $(prefix)/bin
LIB_ME_DIR = $(prefix)/lib/me
LIB_ME_JOB_DIR = $(prefix)/lib/me-job
PROFILE_DIR = /etc/profile.d

M4 := m4
RM := rm
GIT := git
CHMOD := chmod
INSTALL := install

.PHONY: build update install uninstall

build: bin/me

bin/me: bin/me.in
	$(M4) -DLIB_ME_DIR=$(LIB_ME_DIR) -DLIB_ME_JOB_DIR=$(LIB_ME_JOB_DIR) $< >$@
	$(CHMOD) 755 $@

update:
	$(GIT) pull origin master

clean:
	$(RM) -f bin/me

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
