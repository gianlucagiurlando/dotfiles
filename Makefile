ROOT := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

edit-colors:
	nvim $(ROOT)/terminal/colors.yaml

edit-symbols:
	nvim $(ROOT)/terminal/p10k/symbols.zsh

edit-segments:
	nvim $(ROOT)/terminal/p10k/segments.zsh

edit-wezterm:
	nvim $(ROOT)/terminal/wezterm/appearance.lua

edit-fonts:
	nvim $(ROOT)/terminal/wezterm/fonts.lua

edit-keybindings:
	nvim $(ROOT)/terminal/wezterm/keybindings.lua

edit-tmux:
	nvim $(ROOT)/tmux/.tmux.conf

edit-zprofile:
	nvim $(ROOT)/zsh/.zprofile

edit-gh:
	nvim $(ROOT)/gh/config.yml

sync:
	bash $(ROOT)/terminal/sync-colors.sh

install:
	bash $(ROOT)/terminal/install.sh

push:
	git -C $(ROOT) add .
	git -C $(ROOT) commit -m "chore: update terminal config"
	git -C $(ROOT) push

help:
	@echo ""
	@echo "  Dev Environment Makefile"
	@echo ""
	@echo "  make edit-colors       edit color palette (single source of truth)"
	@echo "  make edit-symbols      edit p10k icons & glyphs"
	@echo "  make edit-segments     edit prompt segments"
	@echo "  make edit-wezterm      edit wezterm appearance"
	@echo "  make edit-fonts        edit wezterm fonts"
	@echo "  make edit-keybindings  edit wezterm keybindings"
	@echo "  make edit-tmux         edit tmux config"
	@echo "  make edit-zprofile     edit zsh profile (PATH, env setup)"
	@echo "  make edit-gh           edit gh CLI config"
	@echo "  make sync              sync colors.yaml → p10k + wezterm"
	@echo "  make install           symlink configs to home directory"
	@echo "  make push              commit and push all changes"
	@echo ""

.PHONY: edit-colors edit-symbols edit-segments edit-wezterm edit-fonts edit-keybindings edit-tmux edit-zprofile edit-gh sync install push help
