DOTFILES_EXCLUDES := .DS_Store .git .gitmodules .gitignore README.md $(wildcard *.swp)
DOTFILES_TARGET   := $(wildcard .??*)
DOTFILES_DIR      := $(PWD)
DOTFILES_FILES    := $(filter-out $(DOTFILES_EXCLUDES), $(DOTFILES_TARGET))

all:
	@echo "[INFO] deploy or init"

deploy:
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)

init:
	@$(foreach val, $(DOTFILES_FILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@$(foreach val, $(wildcard ./etc/init/*.sh), bash $(val);)

clean:
	@$(foreach val, $(DOTFILES_FILES), rm $(HOME)/$(val);)
