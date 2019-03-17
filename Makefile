prefix ?= /usr/local
BIN_DIR = $(prefix)/bin
ETC_DIR = $(prefix)/etc
LIB_ME_DIR = $(prefix)/lib/me
COMPLETOINS_DIR = $(prefix)/share/bash-completion/completions
PROFILE_DIR = /etc/profile.d
ME_GITHUB_DIR = /etc/me-github.d
ME_DARKSKY_DIR = /etc/me-darksky.d
ME_TLBOT_DIR = /etc/me-tlbot-send.d

IN_FILE = bin/me completions/me lib/me/me-conf-delete lib/me/me-conf-list \
	lib/me/me-conf-dir-list lib/me/me-conf-edit lib/me/me-conf-new \
	lib/me/me-conf-rename lib/me/me-conf-view lib/me/me-darksky \
	lib/me/me-tlbot-send lib/me/me-github

M4 := m4 -P
RM := rm
LN := ln
CP := cp
RM := rm
GIT := git
CHMOD := chmod
INSTALL := install
PYTHON := python3
PIP := $(PYTHON) -m pip

define setup_python
	$(PYTHON) -m venv --prompt me /usr/local
	$(PIP) install -r requirements.txt
endef

define unsetup_python
	$(RM) -f /usr/local/pyvenv.cfg
	$(RM) -f /usr/local/bin/{pip,python,activate,easy_install,virtualenv}*

	@# TODO: rm lib
	@#$(RM) -rf /usr/local/share/python-wheels
	@#$(RM) -rf /usr/local/lib/python*
	@#[[ -L /usr/local/lib64 ]] && $(RM) -f /usr/local/lib64

endef

define install_bin
	$(INSTALL) -m 755 -D bin/me "$(BIN_DIR)"
endef

define install_lib
	IFS=$$'\n'; \
	for f in $$(ls -1 lib/me -I '*.in'); do \
		$(INSTALL) -m 755 -D "lib/me/$$f" "$(LIB_ME_DIR)"; \
	done
endef

define install_etc
	IFS=$$'\n'; \
	for f in $$(ls -1 etc); do \
		if [[ $$f =~ $$me- ]]; then \
			$(CP) -af "etc/$$f" "$(ETC_DIR)"; \
		else \
			$(CP) -af "etc/$$f" /etc; \
		fi; \
	done
endef

define install_completions
	$(INSTALL) -m 644 -D completions/me $(COMPLETOINS_DIR)
endef

.PHONY: build update install uninstall

build: $(IN_FILE)
	$(setup_python)

bin/me: bin/me.in
	$(M4) -D M4_LIB_ME_DIR=$(LIB_ME_DIR) $< >$@
	$(CHMOD) 755 $@
	
lib/me/%: lib/me/%.in
	$(M4) -D M4_ETC_DIR=$(ETC_DIR) $< >$@
	$(CHMOD) 755 $@

completions/me: completions/me.in
	$(M4) -D M4_LIB_ME_DIR=$(LIB_ME_DIR) $< >$@

update: clean uninstall
	$(GIT) pull origin

clean:
	$(RM) -f $(IN_FILE)

install: $(LIB_ME_DIR)
	$(install_bin)
	$(install_lib)
	$(install_etc)
	$(install_completions)

$(LIB_ME_DIR):
	mkdir -p $(LIB_ME_DIR)

uninstall:
	$(RM) -f $(BIN_DIR)/me
	$(RM) -f $(PROFILE_DIR)/me.sh
	$(RM) -f $(COMPLETOINS_DIR)/me
	$(RM) -rf $(LIB_ME_DIR)
	$(unsetup_python)

