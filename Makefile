DOTFILES_EXCLUDES := .DS_Store .git .gitmodules .gitignore README.md $(wildcard *.swp)
DOTFILES_TARGET   := $(wildcard .??*)
DOTFILES_DIR      := $(PWD)
DOTFILES_FILES    := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))

all:
	@echo "[INFO] init or create_slink"

init:
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@$(foreach val, $(wildcard ./etc/init/*.sh), bash $(val);)

create_slink:
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

rm_slink:
	@$(foreach val, $(DOTFILES_FILES), rm $(HOME)/$(val);)
