ROOT := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

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

edit-starship:
	nvim $(ROOT)/terminal/starship/starship.toml

edit-ghostty:
	nvim -p $(ROOT)/terminal/ghostty/colors.ghostty $(ROOT)/terminal/ghostty/fonts.ghostty $(ROOT)/terminal/ghostty/keybindings.ghostty

edit-tmux:
	nvim $(ROOT)/tmux/.tmux.conf

edit-zprofile:
	nvim $(ROOT)/zsh/.zprofile

edit-gh:
	nvim $(ROOT)/gh/config.yml

edit-opencode:
	nvim $(ROOT)/opencode/opencode.json

prompt-p10k:
	echo "p10k" > $(ROOT)/zsh/.prompt-engine

prompt-starship:
	echo "starship" > $(ROOT)/zsh/.prompt-engine

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
	@echo "  make edit-symbols      edit p10k icons & glyphs"
	@echo "  make edit-segments     edit prompt segments"
	@echo "  make edit-wezterm      edit wezterm appearance"
	@echo "  make edit-fonts        edit wezterm fonts"
	@echo "  make edit-keybindings  edit wezterm keybindings"
	@echo "  make edit-starship     edit starship prompt config"
	@echo "  make edit-ghostty      edit ghostty colors/fonts/keybindings"
	@echo "  make edit-tmux         edit tmux config"
	@echo "  make edit-zprofile     edit zsh profile (PATH, env setup)"
	@echo "  make edit-gh           edit gh CLI config"
	@echo "  make edit-opencode     edit opencode config"
	@echo "  make prompt-p10k       switch active prompt engine to p10k"
	@echo "  make prompt-starship   switch active prompt engine to starship"
	@echo "  make install           symlink configs to home directory"
	@echo "  make push              commit and push all changes"
	@echo ""

.PHONY: edit-symbols edit-segments edit-wezterm edit-fonts edit-keybindings edit-starship edit-ghostty edit-tmux edit-zprofile edit-gh edit-opencode prompt-p10k prompt-starship install push help
