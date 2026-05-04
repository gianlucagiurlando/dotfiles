edit-colors:
	open terminal/colors.yaml

edit-symbols:
	open terminal/p10k/symbols.zsh

edit-segments:
	open terminal/p10k/segments.zsh

edit-wezterm:
	open terminal/wezterm/appearance.lua

edit-fonts:
	open terminal/wezterm/fonts.lua

edit-keybindings:
	open terminal/wezterm/keybindings.lua

sync:
	bash terminal/sync-colors.sh

install:
	bash terminal/install.sh

push:
	git add .
	git commit -m "chore: update terminal config"
	git push

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
	@echo "  make sync              sync colors.yaml → p10k + wezterm"
	@echo "  make install           symlink configs to home directory"
	@echo "  make push              commit and push all changes"
	@echo ""

.PHONY: edit-colors edit-symbols edit-segments edit-wezterm edit-fonts edit-keybindings sync install push help
