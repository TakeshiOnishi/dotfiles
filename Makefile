DOTFILES_EXCLUDES := .DS_Store .git .gitmodules .gitignore README.md $(wildcard *.swp)
DOTFILES_TARGET   := $(wildcard .??*)
DOTFILES_DIR      := $(PWD)
DOTFILES_FILES    := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))
XDG_CONFIG_ROOT		:= .config

all:
	@echo "[INFO] create_slink or rm_slink"

create_slink:
	mkdir -p "${HOME}/${XDG_CONFIG_ROOT}"
	ln -sfnv "${DOTFILES_DIR}/nvim" "${HOME}/${XDG_CONFIG_ROOT}/nvim"
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

rm_slink:
	@$(foreach val, $(DOTFILES_FILES), rm $(HOME)/$(val);)
